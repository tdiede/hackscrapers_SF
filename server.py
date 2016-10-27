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


app = Flask(__name__)
app.config['SECRET_KEY'] = os.environ.get("FLASK_SECRET_KEY", "abcdef")

# Normally, if you use an undefined variable in Jinja2, it fails silently.
# This is horrible. Fix this so that, instead, it raises an error.
# from jinja2 import StrictUndefined
# app.jinja_env.undefined = StrictUndefined


@app.route("/error")
def error():
    raise Exception("Error!")


@app.route('/')
def index():
    """Web app begins with login splash page."""
    return render_template("login.html")


@app.route('/login', methods=['POST'])
def handle_login():
    """Action for login form; user login to be completed."""

    current_username = request.form['username']
    current_password = request.form['password']

    user = User.query.filter_by(username=current_username).first()

    if user:  # Checks to see if user is registered.
        if current_password == user.password:  # Checks to see if user password is correct.
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

    if User.query.filter_by(username=current_username).first():  # Checks to see if user is registered.
        flash("You're already registered. Please login.")
        return redirect('/')
    else:
        add_user(current_username, current_password)
        session['current_user'] = current_username
        flash("Welcome. You are now a registered user, %s! Please make yourself at home." % (current_username))
        return redirect('/dashboard')


@app.route('/switch_user', methods=['POST'])
def switch_user():
    """User login form, when called to switch user."""

    flash("Switch user.")
    return redirect('/login')


@app.route('/logout', methods=['POST'])
def logout_user():
    """User logout, automatically called if user switch."""

    current_user = session['current_user']
    flash("Thanks for playing, %s. You have been logged out." % current_user)
    del session['current_user']
    return redirect('/')


@app.route('/dashboard')
def dashboard():
    """Return user dashboard and profile."""

    if not session:
        return redirect('/')

    else:
        current_user = session['current_user']
        user = User.query.filter_by(username=current_user).one()
        cards = Card.query.filter_by(user_id=user.user_id).all()

        card_bldg = []
        for card in cards:
            bldg = Building.query.filter_by(bldg_id=card.bldg_id).one()
            match = card, bldg
            card_bldg.append(match)

        card_collection = assemble_card_row(card_bldg)

        # empty_card_html = Markup('<h3>Create a new card.</h3>')

        collection_html = []
        for card_row in card_collection:
            row_html = []
            for card in card_row:
                card_html = []
                card_html.append(card[1].building_name)
                card_html.append(card[0].card_img)
                card_html.append(str(card[0].bldg_id))
                row_html.append(card_html)
            # if len(row_html) < 3:
            #     row_html.append(empty_card_html)
            collection_html.append(row_html)
        # if len(collection_html) % 3 == 0:
        #     row_html = []
        #     row_html.append(empty_card_html)
        #     collection_html.append(row_html)

        return render_template("dashboard.html", current_user=current_user, collection_html=collection_html)


@app.route('/buildings')
def buildings_list():
    """Return list of buildings."""

    bldgs = Building.query.all()
    return render_template("buildings_list.html", bldgs=bldgs)


@app.route('/bldg/<int:bldg_id>')
def show_bldg_details(bldg_id):
    """When user clicks on name of building, show building photo and details."""

    bldg = Building.query.get(bldg_id)

    photos = json.loads(bldg_flickr(bldg_id))

    return render_template("building_details.html", bldg=bldg, photos=photos)


@app.route('/map')
def display_map():
    """Page where user can see map and map data."""
    return render_template("mapbox.html")


### JSON ROUTES ###

# JSON ROUTE FOR GENERIC DISPLAY OF BUILDING
@app.route('/bldg_feature.json/<int:bldg_id>')
def bldg_feature(bldg_id):
    """Returns JSON to represent SINGLE BLDG RECORD."""

    bldg = Building.query.get(bldg_id)

    photo_metadata = json.loads(bldg_flickr(bldg_id))

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
                    "photo_metadata": photo_metadata
                    }

    return json.dumps(bldg_feature)


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
                          "title": title,
                          "description": description,
                          }

    else:
        photo_metadata = {bldg_id: {"result": 'This building does not have any tagged Flickr photos.'}}
        photo = None

    return json.dumps(photo_metadata)


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


@app.route('/create_card.json')
def create_card():
    """User selects photo and comment to put on card, previews card."""

    bldg_id = request.args.get('bldg_id')

    bldg_feature = show_bldg_details(bldg_id)
    r = bldg_feature.response
    f = r.pop()
    feature = json.loads(f)

    bldg_flickr = flickr_filter()
    p = bldg_flickr.response
    h = p.pop()
    flickr = json.loads(h)

    comments = request.form.get('comments')

    bldg_card = {'building': feature,
                 'photo': flickr,
                 'comments': comments}

    return jsonify(bldg_card)


@app.route('/save_card.json')
def save_card():
    """Saves new card to user profile and database."""

    current_user = session['current_user']

    user = User.query.filter_by(username=current_user).one()
    user_id = user.user_id
    bldg_id = request.args.get('bldg_id')

    card_img = request.args.get('url')
    comments = "I love this!"

    duplicate_card = Card.query.filter_by(user_id=user_id).filter_by(bldg_id=bldg_id).first()

    if duplicate_card:
        flash("You already have that card %d!" % duplicate_card.card_id)

    else:
        add_card(user_id, bldg_id, card_img, comments)

    return redirect('/dashboard')


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


#################################

def assemble_card_row(card_bldg):
    """Counts existing cards created by user and groups by threes."""

    card_collection = []
    i = 0
    while (i <= len(card_bldg)/3):
        card_row = card_bldg[i*3:i+3]
        card_collection.append(card_row)
        i += 1

    return card_collection


# def refresh_dashboard():
#     """After user creates and saves card, refresh dashboard."""

#     cards = Card.query.filter_by(user_id=user_id).all()
#     print cards

#     card_html, empty_card_html = refresh_dashboard()

#     bldg = Building.query.filter_by(bldg_id=bldg_id).one()

#     flash("New card for {} has now been added to your collection!".format(bldg.building_name))
#     return render_template("dashboard.html", current_user=current_user, cards=cards, card_html=card_html, empty_card_html=empty_card_html)


# @app.route('/sort_field')
# def sort_field(field_id):
#     """Return refreshed list of buildings after sorting field."""

#     sort_field(field_id)

#     return render_template("buildings_list.html", bldgs=bldgs)


# def sort_field():
#     """Orders query results in descending order."""

#     bldgs = db.session.query(Building).all()

#     bldgs_desc = bldgs.order_by(desc(Building.completed_yr))
#     # bldgs_desc = bldgs.order_by(desc(Building.floors))

#     return bldgs_desc


####################################################################

if __name__ == "__main__":
    # app.debug = True
    # app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = False
    # from flask_debugtoolbar import DebugToolbarExtension
    # DebugToolbarExtension(app)

    # import doctest
    # result = doctest.testmod()
    # if not result.failed:
    #     print "ALL TESTS PASSED. GOOD WORK!"

    connect_to_db(app, os.environ.get("DATABASE_URL"))

    # Create the tables we need from our models.
    db.create_all()

    DEBUG = "NO_DEBUG" not in os.environ
    PORT = int(os.environ.get("PORT", 5000))

    app.run(host="0.0.0.0", port=PORT, debug=DEBUG)
