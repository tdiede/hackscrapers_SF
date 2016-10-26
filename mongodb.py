import os
import sys

import pymongo

import json
import pprint


MONGODB_URI = os.getenv('MONGODB_URI', 'mongodb://localhost:27017')


# Connection to Mongo DB
# MongoClient('localhost', port=27017)
def main(args):

    try:
        client = pymongo.MongoClient(MONGODB_URI,
                                     connectTimeoutMS=30000,
                                     socketTimeoutMS=None,
                                     socketKeepAlive=True)
        print "Connected to MongoDB!"
    except pymongo.errors.ConnectionFailure:
        print "Could not connect to MongoDB."

    db = client.get_default_database()
    print db.collection_names()

    flickr = db['flickr']

    db.drop_collection('flickr')

    client.close()


if __name__ == '__main__':
    main(sys.argv[1:])


def total_photos():

    total_photos = flickr.find({}).count()

    return total_photos


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


##################################################################

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
