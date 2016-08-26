from pymongo import MongoClient, errors


# Connection to Mongo DB
try:
    Client = MongoClient()
    print "Connected successfully!!!"
except errors.ConnectionFailure, e:
    print "Could not connect to MongoDB."

MongoClient('localhost', port=27017)


db = Client.mydb
# collection = db["Buildings"]
# building = {}


# cursor = collection.find()
