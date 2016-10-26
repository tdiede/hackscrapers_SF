"""Utility file to seed MongoDB database from Flickr API call for photos metadata."""

from server import app

from model import connect_to_db, db
from model import (Building)  # my model file for buildings

from mongodb import db as mongo

import requests
import json

import sys
reload(sys)  # Reload does the trick!
sys.setdefaultencoding('UTF8')

import os
FLICKR_KEY = os.environ['FLICKR_KEY']
FLICKR_SECRET = os.environ['FLICKR_SECRET']


# Drop existing flickr collection.
mongo.drop_collection('flickr')
# Create or recreate flickr collection.
flickr = mongo['flickr']


if __name__ == "__main__":

    connect_to_db(app, os.environ.get("DATABASE_URL"))


def flickr_search():
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

            insert_photos(data)

            page_count = int(data['photos']['pages'])

            print '''Getting page {} in {} total pages.
                     Queried for {} building at rank {}'''.format(page,
                                                                  page_count,
                                                                  bldg_name,
                                                                  bldg.rank)

            page += 1


# 16MB is the limit for BSON document size.
def insert_photos(data):
    """Inserts Flickr result (JSON) into MongoDB collection: each photo metadata as a document."""

    bldg_photos = data['photos']['photo']
    for bldg_photo in bldg_photos:
        flickr.insert(bldg_photo)
        print "inserted"
