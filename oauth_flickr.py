import requests_oauthlib

import os
FLICKR_KEY = os.environ['FLICKR_KEY']
FLICKR_SECRET = os.environ['FLICKR_SECRET']

api_key = FLICKR_KEY
api_secret = FLICKR_SECRET


# OAuth URLs
request_token_url = 'https://www.flickr.com/services/oauth/request_token'
authorization_url = 'https://www.flickr.com/services/oauth/authorize'
access_token_url = 'https://www.flickr.com/services/oauth/access_token'

# This is set in the app settings (under hackcrapers@yahoo.com profile)
callback_uri = 'localhost:5000/callback'
# callback_uri = 'https://hackscrapers.herokuapp.com/callback'

oauth_session = requests_oauthlib.OAuth1Session(client_key=api_key, client_secret=api_secret, signature_method=u'HMAC-SHA1', signature_type=u'AUTH_HEADER', callback_uri=callback_uri)


def fetch_request_token():

    # First step, fetch the request token:
    request_token = oauth_session.fetch_request_token(request_token_url)

    # Second step, follow this link and authorize:
    link_to_authorize = oauth_session.authorization_url(authorization_url)+'&perms=write'

    print link_to_authorize
    return link_to_authorize


def fetch_access_token():

    # Third step, fetch the access token:
    redirect_response = raw_input('Paste the full redirect URL here.')
    print oauth_session.parse_authorization_response(redirect_response)
    access_token = oauth_session.fetch_access_token(access_token_url)
    print access_token
    return access_token

# Done! You can now make authenticated requests using the token and token secret.
