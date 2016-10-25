import os
import sys

import pymongo

import json
import pprint


MONGODB_URI = os.getenv('MONGODB_URI', 'mongodb://localhost:27017')

# Connection to Mongo DB
try:
    client = pymongo.MongoClient(MONGODB_URI)
    print "Connected to MongoDB!"
except pymongo.errors.ConnectionFailure, e:
    print "Could not connect to MongoDB."

# MongoClient('localhost', port=27017)

mydb = client.mydb
flickr = mydb.flickr

# cursor = flickr_responses.find({})
# for each in cursor:
#     pprint.pprint(each)

# Create compound index for text fields.
flickr.create_index([("tags", 'text'), ("description.content", 'text'), ("title", 'text')])


def total_photos():

    total_photos = flickr.find({}).count()

    return total_photos


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


##############################################################################

# # This function was run once, and now the database collection has documents.
# # 16MB is the limit for BSON document size.
# def load_jsons():
#     """Opens JSON files and reads data into f, loads into doc."""

#     flickr.drop()

#     for file in os.listdir('json/'):
#         if file.endswith('.json'):
#             print "processing ", file
#             filename = os.path.join('json/', file)
#             f = open(filename, 'r')
#             json_file = json.load(f)
#             bldg_photos = json_file['photos']['photo']
#             for bldg_photo in bldg_photos:
#                 flickr.insert(bldg_photo)
#             f.close()


# # If I were to use Flask-MongoAlchemy...
# def connect_to_mongo(app, db_uri='library'):
#     """Connect the database to our Flask app."""

#     # Configure to use our mdb database
#     app.config['MONGOALCHEMY_DATABASE'] = db_uri
#     app.config['MONGOALCHEMY_SERVER_AUTH'] = False

#     mongodb = MongoAlchemy(app)

#     def init_app():
#         app = Flask(__name__)
#         mongodb.init_app(app)
#         return app
