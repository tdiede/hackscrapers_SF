import requests_oauthlib

import os
FLICKR_KEY = os.environ['FLICKR_KEY']
FLICKR_SECRET = os.environ['FLICKR_SECRET']

api_key = FLICKR_KEY
api_secret = FLICKR_SECRET


# OAuth URLs
request_token_url = u'https://www.flickr.com/services/oauth/request_token'
authorization_url = u'https://www.flickr.com/services/oauth/authorize'
access_token_url = u'https://www.flickr.com/services/oauth/access_token'

# This is (also) set in the app settings (under hackcrapers@yahoo.com profile).
# callback_uri = u'http://127.0.0.1:5000/callback'
callback_uri = 'https://hackscrapers.herokuapp.com/callback'


oauth_session = requests_oauthlib.OAuth1Session(client_key=api_key, client_secret=api_secret,
                                                signature_method=u'HMAC-SHA1',
                                                signature_type=u'AUTH_HEADER',
                                                callback_uri=callback_uri)


def fetch_request_token():

    # First step, fetch the request token:
    return oauth_session.fetch_request_token(request_token_url)


def follow_link():

    # Second step, follow this link and authorize:
    return str(oauth_session.authorization_url(authorization_url))+'&perms=write'


def fetch_access_token(oauth_token, oauth_verifier):

    # Third step, fetch the access token:
    # redirect_response = raw_input('Paste the full redirect URL here.')
    redirect_response = str(callback_uri) + '?oauth_token=' + oauth_token + '&oauth_verifier=' + str(oauth_verifier)
    oauth_session.parse_authorization_response(redirect_response)
    return oauth_session.fetch_access_token(access_token_url)

# Done! You can now make authenticated requests using the token and token secret.
# https://www.flickr.com/services/api/flickr.photos.search.html
# https://www.flickr.com/services/api/misc.urls.html
# https://www.flickr.com/services/api/flickr.photos.getSizes.html


# flickr.galleries.create

# flickr.galleries.addPhoto

# flickr.galleries.getPhotos

# Modify the photos in a gallery. Use this method to add, remove and re-order photos.
# flickr.galleries.editPhotos



# (Social) Return the list of galleries to which a photo has been added. Galleries are returned sorted by date which the photo was added to the gallery.
# flickr.galleries.getListForPhoto
