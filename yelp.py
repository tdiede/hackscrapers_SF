# Use Python os.environ to get environmental variables.
# Note: you must run `source secrets.sh` before running
# this file to set required environmental variables.

import os

YELP_CONSUMER_KEY = os.environ['YELP_CONSUMER_KEY']
YELP_CONSUMER_SECRET = os.environ['YELP_CONSUMER_SECRET']
YELP_TOKEN = os.environ['YELP_TOKEN']
YELP_TOKEN_SECRET = os.environ['YELP_TOKEN_SECRET']

from yelp.client import Client  # external library
from yelp.oauth1_authenticator import Oauth1Authenticator  # oauth authentication


auth = Oauth1Authenticator(consumer_key=YELP_CONSUMER_KEY,
                            consumer_secret=YELP_CONSUMER_SECRET,
                            token=YELP_TOKEN,
                            token_secret=YELP_TOKEN_SECRET)

client = Client(auth)


def search_yelp(lat, lng):
    """Use the lat and lng to search yelp."""

    response = client.search_by_coordinates(lat, lng)

    return response
