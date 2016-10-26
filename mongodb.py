import os

import pymongo


MONGODB_URI = os.getenv('MONGODB_URI', 'mongodb://localhost:27017')


# Connection to Mongo DB
# MongoClient('localhost', port=27017)
if __name__ == '__main__':

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


#####################################################

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
