# Use Python os.environ to get environmental variables.
# Note: you must run `source secrets.sh` before running
# this file to set required environmental variables.

# CURATION TOOL. MACHINE LEARNING.

import os

import requests
import json

from model import db
from model import Building

from mongodb import flickr


FLICKR_KEY = os.environ['FLICKR_KEY']
FLICKR_SECRET = os.environ['FLICKR_SECRET']


# Drop existing flickr database to re-populate.
flickr.drop()


def flickr_search(bldgs):
    """Makes request to FLICKR API, given bldg tags. Saves file for each bldg, each page 500 results max."""

    bldgs = db.session.query(Building).options(db.joinedload('city')).all()

    flickr_per_page_limit = 500

    for bldg in bldgs:
        bldg_name = bldg.building_name
        city_name = bldg.city.city
        # Assumes all buildings are in the same city, if joined for API call.

        page = 1
        page_count = 80  # Arbitrary limit.

        extras = 'url_s, url_m, geo, tags, owner_name, date_taken, description'

        # extras: description, license, date_upload, date_taken, owner_name, icon_server,
        # original_format, last_update, geo, tags, machine_tags, o_dims, views, media, path_alias,
        # url_sq, url_t, url_s, url_q, url_m, url_n, url_z, url_c, url_l, url_o

        while (page < page_count):

            payload = {'tags': bldg_name+', '+city_name, 'tag_mode': 'all',
                       'extras': extras,
                       'ispublic': 1, 'format': 'json', 'nojsoncallback': 1,
                       'api_key': FLICKR_KEY,
                       'page': page, 'per_page': flickr_per_page_limit}

            # Response object.
            r = requests.get('https://api.flickr.com/services/rest/?method=flickr.photos.search', params=payload)

            # Content of Response object as string.
            content = r.content

            # JSON dictionary.
            data = json.loads(content)

            load_jsons(data)

            page_count = int(data['photos']['pages'])

            print '''Getting page {} in {} total pages.
                     Queried for {} building at rank {}'''.format(page,
                                                                  page_count,
                                                                  bldg_name,
                                                                  bldg.rank)

            page += 1


# 16MB is the limit for BSON document size.
def load_jsons(data):
    """Inserts JSON data into MongoDB collection as a document."""

    bldg_photos = data['photos']['photo']
    for bldg_photo in bldg_photos:
        flickr.insert(bldg_photo)
        print "inserted"
