"""Python/Flask server: provides web interface for browsing skyscrapers."""

import os

from flask import (Flask, render_template, redirect, request, session, flash, jsonify)

import json

from model import connect_to_db, db
from model import Building, User, Card

from mongodb import db as mongo
flickr = mongo['flickr']
# Create compound index for text fields.
flickr.create_index([("tags", 'text'), ("description.content", 'text'), ("title", 'text')])


from sqlalchemy.sql import func
from random import randint, sample

import bcrypt

import oauth_flickr


app = Flask(__name__)
app.config['SECRET_KEY'] = os.environ.get("FLASK_SECRET_KEY", "abcdef")


# Normally, if you use an undefined variable in Jinja2, it fails silently.
# This is horrible. Fix this so that, instead, it raises an error.
# from jinja2 import StrictUndefined
# app.jinja_env.undefined = StrictUndefined


@app.route("/oauth")
def oauth():

    request_token = oauth_flickr.fetch_request_token()
    oauth_token = request_token['oauth_token']
    session['current_oauth_token'] = oauth_token
    print oauth_token

    oauth_url = oauth_flickr.follow_link()
    print oauth_url

    return redirect(oauth_url)


@app.route("/callback")
def callback():

    print "hi"

    # print session['current_oauth_token']
    dd = oauth_flickr.fetch_access_token()
    print dd

    # return request


@app.route("/error")
def error():
    raise Exception("Error!")


@app.route('/')
def index():
    """Web app begins with splash page."""
    return render_template("splash.html")


@app.route('/login')
def user_login():
    """User login form."""
    return render_template("login.html")


@app.route('/login', methods=['POST'])
def handle_login():
    """Action for login form; user login to be completed."""

    current_username = request.form['username']
    current_password = request.form['password']

    user = User.query.filter_by(username=current_username).first()
    hashed = user.password

    if user:  # Checks to see if user is registered.
        # # Checks to see if user password is correct (not using bcrypt hashing).
        # if current_password == user.password:

        # Check that an unhashed password matches one that has previously been hashed.
        if bcrypt.checkpw(current_password, hashed):
            session['current_user'] = current_username
            flash("Logged in as %s" % (current_username))
            return redirect('/dashboard')
        else:
            flash("Wrong password. Try again!")
            return redirect('/')
    else:
        flash("Please register.")
        return redirect('/register')


@app.route('/register')
def user_register():
    """User register form."""
    return render_template("register.html")


@app.route('/register', methods=['POST'])
def handle_register():
    """Action for register form; user entered into database."""

    current_username = request.form['username']
    current_password = request.form['password']

    if User.query.filter_by(username=current_username).first():  # Checks to see if user is already registered.
        flash("You're already registered. Please login.")
        return redirect('/')
    else:
        # Hash a password for the first time, with a randomly-generated salt.
        hashed = bcrypt.hashpw(current_password, bcrypt.gensalt())
        add_user(current_username, hashed)
        session['current_user'] = current_username
        flash("Welcome. You are now a registered user, %s! Please make yourself at home." % (current_username))
        return redirect('/dashboard')


@app.route('/logout', methods=['POST'])
def process_logout():
    """Identifies user session to be deleted. Deletes user session. Redirects."""

    current_user = session['current_user']
    del session['current_user']
    flash("Thanks for playing, %s. You are now logged out." % current_user)
    return redirect('/')


@app.route('/buildings')
def buildings_list():
    """Return list of buildings."""

    bldgs = Building.query.all()
    return render_template("buildings_list.html", bldgs=bldgs)


@app.route('/bldg/<int:bldg_id>')
def show_bldg_details(bldg_id):
    """When user clicks on name of building, show building photo and details."""

    bldg = Building.query.get(bldg_id)

    photo_metadata = bldg_flickr(bldg_id)

    photos = []
    for result in photo_metadata.response:
        photo = json.loads(result)
        photos.append(photo)

    # raise Exception
    return render_template("building_details.html", bldg=bldg, photos=photos)


@app.route('/map')
def display_map():
    """Page where user can see map and map data."""
    bldgs = Building.query.all()
    return render_template("mapbox.html", bldgs=bldgs)


### JSON ROUTES ###

# # JSON ROUTE FOR GENERIC DISPLAY OF BUILDING
@app.route('/bldg_feature.json/<int:bldg_id>')
def bldg_feature(bldg_id):
    """Returns JSON to represent SINGLE BLDG RECORD."""

    bldg = Building.query.get(bldg_id)

    photo_metadata = bldg_flickr(bldg_id)

    photos = []
    for result in photo_metadata.response:
        photo = json.loads(result)
        photos.append(photo)

    bldg_feature = {"place_id": bldg.place_id,
                    "rank": bldg.rank,
                    "status": bldg.status,
                    "building_name": bldg.building_name,
                    "lat": bldg.lat,
                    "lng": bldg.lng,
                    "city": bldg.city_id,
                    "height_m": bldg.height_m,
                    "height_ft": bldg.height_ft,
                    "floors": bldg.floors,
                    "completed_yr": bldg.completed_yr,
                    "material": bldg.material,
                    "use": bldg.use,
                    "photos": photos
                    }

    return jsonify(bldg_feature)


# JSON ROUTE FOR FLICKR PHOTO URL
@app.route('/bldg_flickr.json/<int:bldg_id>')
def bldg_flickr(bldg_id):
    """Returns a random Flickr image url from SINGLE BLDG RECORD."""

    cursor_bldg_photos = find_photos(bldg_id)
    count = cursor_bldg_photos.count()

    if count > 0:
        i = get_randint(0, count-1)
        photo = cursor_bldg_photos[i]

        url_s = photo.get('url_s')
        ownername = photo.get('ownername')
        title = photo.get('title')
        raw_description = photo['description'].get('_content')
        description = raw_description.rstrip().lstrip()

        photo_metadata = {"url_s": url_s,
                          "ownername": ownername,
                          "photo_title": title,
                          "photo_description": description
                          }

    else:
        photo_metadata = {"not_found": True,
                          "message": 'This building does not have any tagged Flickr photos.',
                          "suggestion": 'No photo found. Maybe you should go snap it!'
                          }

    return jsonify(photo_metadata)


# GEOJSON ROUTE FOR MAP
@app.route('/bldgs.geojson')
def create_bldgs_geojson():
    """Return ALL BLDGS RECORDS from buildings table as GEOJSON."""

    bldgs = Building.query.all()

    features = []
    for bldg in bldgs:

        coordinates_list = [bldg.lng, bldg.lat]
        bldg_feature = {"type": "Feature",
                        "geometry": {
                            "type": "Point",
                            "coordinates": coordinates_list,
                            },
                        "properties": {
                            "bldg_id": bldg.bldg_id,
                            "place_id": bldg.place_id,
                            "rank": bldg.rank,
                            "status": bldg.status,
                            "building_name": bldg.building_name,
                            "lat": bldg.lat,
                            "lng": bldg.lng,
                            "city": bldg.city_id,
                            "height_m": bldg.height_m,
                            "height_ft": bldg.height_ft,
                            "floors": bldg.floors,
                            "completed_yr": bldg.completed_yr,
                            "material": bldg.material,
                            "use": bldg.use,
                            }
                        }

        features.append(bldg_feature)

    bldg_geojson = {"type": "FeatureCollection",
                    "features": features}

    return jsonify(bldg_geojson)


# JSON ROUTE FOR BAR CHART
@app.route('/bldg_barchart.json/<int:bldg_id>')
def bldg_barchart(bldg_id):
    """Return SINGLE BLDG RECORD from buildings table AS JSON for Chart.js."""

    current_bldg = Building.query.get(bldg_id)

    #Get tallest building in dataset.
    tallest_bldg = Building.query.filter_by(rank=1).one()

    # Get buildings average data.
    avg = avg_bldg_height()

    data = []
    data.append(current_bldg.height_ft)
    data.append(tallest_bldg.height_ft)
    data.append(int(avg))

    labels = []
    labels.append(current_bldg.building_name)
    labels.append(tallest_bldg.building_name + " (tallest)")
    labels.append("San Francisco average (of 130 buildings)")

    current_bldg_color = 'rgba(255,0,0,0.6)'
    current_bldg_border = 'rgba(255,0,0,1.0)'

    tallest_bldg_color = 'rgba(255,155,0,0.6)'
    tallest_bldg_border = 'rgba(255,155,0,1.0)'

    avg_color = 'rgba(255,155,205,0.6)'
    avg_border = 'rgba(255,155,205,1.0)'

    backgroundColor = [current_bldg_color,
                       tallest_bldg_color,
                       avg_color]
    borderColor = [current_bldg_border,
                   tallest_bldg_border,
                   avg_border]
    borderWidth = 2

    datasets = [
        {
            'label': '',
            'backgroundColor': backgroundColor,
            'borderColor': borderColor,
            'borderWidth': borderWidth,
            'data': data,
        }
    ]

    bldg_barchart = {"labels": labels, "datasets": datasets}

    return jsonify(bldg_barchart)


# HELPER FUNCTIONS ################
"""All general helper functions."""


def get_randint(low, high):
    """Obtain a random integer between low and high, inclusive, for use in any function."""

    my_randint = randint(low, high)
    return my_randint


def get_randsample(high, n):
    """Obtain n random integers between 0 high, exclusive, for use in any function."""

    my_randsample = sample(range(high), n)
    return my_randsample


# HELPER FUNCTIONS ####################
"""All functions querying database."""


def avg_bldg_height():
    """Queries buildings database for average building height."""

    avg = db.session.query(func.avg(Building.height_ft).label('average')).scalar()
    return avg


def find_photos(bldg_id):
    """Queries MongoDB for photos by bldg_id. Returns bldg_photos cursor object."""

    bldg = Building.query.get(bldg_id)
    name = bldg.building_name.replace(' ', '').lower()
    print name

    cursor_bldg_photos = flickr.find({'$text': {'$search': name}})
    return cursor_bldg_photos


# HELPER FUNCTIONS ####################
"""All functions adding to database."""


def add_user(username, password):
    """Called when a new user registers."""

    user = User(username=username,
                password=password)

    db.session.add(user)
    db.session.commit()


def add_card(user_id, bldg_id, card_img, comments):
    """Called when a user saves a new card."""

    card = Card(user_id=user_id,
                bldg_id=bldg_id,
                card_img=card_img,
                comments=comments)

    db.session.add(card)
    db.session.commit()


####################################################################

if __name__ == "__main__":

    from flask_debugtoolbar import DebugToolbarExtension
    DebugToolbarExtension(app)

    # import doctest
    # result = doctest.testmod()
    # if not result.failed:
    #     print "ALL TESTS PASSED. GOOD WORK!"

    connect_to_db(app, os.environ.get("DATABASE_URL"))
    db.create_all()

    DEBUG = "NO_DEBUG" not in os.environ
    PORT = int(os.environ.get("PORT", 5000))

    app.run(host="0.0.0.0", port=PORT, debug=DEBUG)
