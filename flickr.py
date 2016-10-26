# Use Python os.environ to get environmental variables.
# Note: you must run `source secrets.sh` before running
# this file to set required environmental variables.

# CURATION TOOL. MACHINE LEARNING.

import os

import requests
import json

from server import app

from model import db, connect_to_db
from model import Building

from mongodb import db as mongo


FLICKR_KEY = os.environ['FLICKR_KEY']
FLICKR_SECRET = os.environ['FLICKR_SECRET']

# Connect to buildings database for bldgs query.
connect_to_db(app, os.environ.get("DATABASE_URL"))

# Drop existing flickr collection.
mongo.drop_collection('flickr')
# Create or recreate flickr collection.
flickr = mongo['flickr']


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

            insert(data)

            page_count = int(data['photos']['pages'])

            print '''Getting page {} in {} total pages.
                     Queried for {} building at rank {}'''.format(page,
                                                                  page_count,
                                                                  bldg_name,
                                                                  bldg.rank)

            page += 1


# 16MB is the limit for BSON document size.
def insert(data):
    """Inserts Flickr result (JSON) into MongoDB collection: each photo metadata as a document."""

    bldg_photos = data['photos']['photo']
    for bldg_photo in bldg_photos:
        flickr.insert(bldg_photo)
        print "inserted"


# def total_photos():

#     total_photos = flickr.find({}).count()
#     return total_photos


# cursor = flickr_responses.find({})
# for each in cursor:
#     pprint.pprint(each)

# Create compound index for text fields.
# flickr.create_index([("tags", 'text'), ("description.content", 'text'), ("title", 'text')])


# def count_tags():

#     flickr.aggregate([ {'$group': {'_id': '$tags', 'count': {'$sum': 1}}} ])
#     flickr.aggregate([ {'$group': {'_id': '$text', 'count': {'$sum': 1}}}, {'$sort': { 'count': 1}} ])
#     flickr.aggregate([ {'$match': { 'tags': 'building' } }, {'$group': {'_id': '$tags', 'count': {'$sum': 1}}}, {'$sort': { 'count': 1}} ])


######################################

# def get_random_image(results_count):
#     """Get one random image."""

#     flickr_per_page_limit = 500

#     if results_count > flickr_per_page_limit:
#         i = get_randint(0, flickr_per_page_limit-1)
#     else:
#         i = get_randint(0, results_count-1)

#     return i


# def get_random_images(results_count):
#     """Get a random sample of n images."""

#     flickr_per_page_limit = 500
#     n = 2  # Must be less than 500, or flickr_per_page_limit.

#     if results_count > flickr_per_page_limit:
#         idx = get_randsample(flickr_per_page_limit, n)
#     elif results_count > n:
#         idx = get_randsample(results_count, n)
#     else:
#         idx = get_randsample(results_count, results_count)

#     return idx

