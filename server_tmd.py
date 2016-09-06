"""Initial project application Flask server.

Provides web interface for browsing skyscrapers.

Author: Therese Diede
"""

from jinja2 import StrictUndefined

from flask import (Flask, render_template, redirect, request, session, flash, jsonify, Markup)
from flask_debugtoolbar import DebugToolbarExtension

from model_buildings import connect_to_db, db
from model_buildings import Building, City, User, Card

# from flickr import flickr_search
from mongodb_tmd import flickr, total_photos

import json
import pprint

from sqlalchemy.sql import func, desc

from random import randint, sample


app = Flask(__name__)
app.secret_key = 'jfsajweWlkakNjakswpclI_fictitious'
app.jinja_env.undefined = StrictUndefined


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


@app.route('/homepage')
def homepage():
    """Return homepage (dashboard)."""

    current_user = session.get('current_user')

    return render_template("homepage.html", current_user=current_user)


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

        empty_card_html = Markup('<div class="col-md-3"><div class="card card-block carte-blanche"><h3 class="card-title"><a href="#create">Create your card.</a></h3><p class="card-text"></p><a href="#" class="btn btn-info"></a></div></div>')

        collection_html = []
        for card_row in card_collection:
            row_html = []
            for card in card_row:
                card_html = Markup('<div class="col-md-3"><div class="card card-block card-collectible"><h3 class="card-title"> ' + card[1].building_name + ' </h3><img class="card-img-top thumbnail img-fluid" src=' + 'static/img/splash.jpg' + ' ><p class="card-text"></p><a id="flip-card" data-bldg=' + str(card[0].bldg_id) + ' class="btn btn-info">flip for info</a></div></div>')
                row_html.append(card_html)
            if len(row_html) < 3:
                row_html.append(empty_card_html)
            collection_html.append(row_html)
        if len(collection_html) % 3 == 0:
            row_html = []
            row_html.append(empty_card_html)
            collection_html.append(row_html)

        return render_template("dashboard.html", current_user=current_user, collection_html=collection_html)


def assemble_card_row(card_bldg):
    """Counts existing cards created by user and groups by threes."""

    card_collection = []
    i = 0
    while (i <= len(card_bldg)/3):
        card_row = card_bldg[i*3:i+3]
        card_collection.append(card_row)
        i += 1

    return card_collection


@app.route('/search_bldg.json')
def search_bldgs():
    """Queries database for building(s) searched by user and returns a json."""

    search_results = []
    bldg_response = {}

    # Search terms entered by user
    search_terms = request.args.get('building')
    if search_terms:
        search = search_terms.split(" ")
    else:
        # flash("Your search is empty.")
        return redirect('/dashboard')

    for term in search:
        # if term.lower() != "building" and term.lower() != "tower":  # Hope to exclude these terms from search. Better way?
        bldg_match = db.session.query(Building).filter(Building.building_name.ilike('%'+term+'%')).all()
        search_results.extend(bldg_match)

    if search_results:
        for bldg in search_results:
            bldg_response = {'bldg_id': bldg.bldg_id,
                             'place_id': bldg.place_id,
                             'rank': bldg.rank,
                             'status': bldg.status,
                             'building_name': bldg.building_name,
                             'lat': bldg.lat,
                             'lng': bldg.lng,
                             'city': bldg.city_id,
                             'height_m': bldg.height_m,
                             'height_ft': bldg.height_ft,
                             'floors': bldg.floors,
                             'completed_yr': bldg.completed_yr,
                             'material': bldg.material,
                             'use': bldg.use}

        return jsonify(bldg_response)

    else:
        # flash("Your search returned no results.")
        return redirect('/dashboard')


@app.route('/create_card.json')
def create_card():
    """User selects photo to put on card."""

    bldg_id = request.args.get('bldg_id')

    bldg = {'bldg_id': int(bldg_id)}

    return jsonify(bldg)


@app.route('/save_card.json')
def save_card():
    """Saves new card to user profile and database."""

    current_user = session['current_user']

    user = User.query.filter_by(username=current_user).one()
    user_id = user.user_id
    # bldg_id = request.form.get('bldg_id')

    bldg_id = 26

    duplicate_card = Card.query.filter_by(user_id=user_id).filter_by(bldg_id=bldg_id).first()
    if duplicate_card:
        flash("You already have that card %d!" % duplicate_card.card_id)
        return redirect('/dashboard')
    else:
        add_card(user_id, bldg_id)
        return jsonify(new_card)


# def refresh_dashboard():
#     """After user creates and saves card, refresh dashboard."""

#     cards = Card.query.filter_by(user_id=user_id).all()
#     print cards

#     card_html, empty_card_html = refresh_dashboard()

#     bldg = Building.query.filter_by(bldg_id=bldg_id).one()

#     flash("New card for {} has now been added to your collection!".format(bldg.building_name))
#     return render_template("dashboard.html", current_user=current_user, cards=cards, card_html=card_html, empty_card_html=empty_card_html)


# # # Only called once to generate files.
# # # Another function populates database.
# @app.route('/gen_flickr_files')
# def gen_flickr_files():
#     """Calls Flickr API for photo search. Saves JSON data files for each bldg."""

#     bldgs = db.session.query(Building).options(db.joinedload('city')).all()

#     flickr_search(bldgs)

#     return None


@app.route('/buildings')
def buildings_list():
    """Return list of buildings."""

    bldg_search = request.args.get('building')

    bldgs = []

    if bldg_search:
        search_results = get_bldg_query(bldg_search)
        if search_results:
            for result in search_results:
                if result is None:
                    search_results.remove(None)
                bldgs.append(result)
            return render_template("buildings_list.html", bldgs=bldgs)

        else:
            flash("Sorry, your search {} returned no results.".format(bldg_search))
            return redirect('/dashboard')

    else:
        bldgs = Building.query.all()

    return render_template("buildings_list.html", bldgs=bldgs)


@app.route('/cities')
def cities_list():
    """Return list of cities."""

    cities = City.query.all()

    return render_template("cities_list.html", cities=cities)


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


@app.route('/switch_user')
def switch_user():
    """User login form, when called to switch user."""

    flash("Switch user.")
    return redirect('/login')


@app.route('/logout')
def logout_user():
    """User logout, automatically called if user switch."""

    current_user = session['current_user']
    flash("Thanks for playing, %s. You have been logged out." % current_user)
    del session['current_user']
    return redirect('/')


@app.route('/map')
def display_map():
    """Page where user can see map and map data."""

    return render_template("mapbox.html")


@app.route('/dendrogram')
def display_dendogram():
    """Page where user can see dendrogram and dendrogram data."""

    return render_template("dendrogram.html")


@app.route('/dendrogram.json')
def dendogram_data():
    """Return data from buildings table for use in dendogram, JSON."""

    cities = City.query.filter_by(city="San Francisco").first()
    bldgs = Building.query.all()

    buildings = {}
    buildings_list = []

    for bldg in bldgs:

        tenants = {}
        tenants_list = []

        for tenant in bldg.tenants:
            tenants = {"name": tenant.tenant}
            tenants_list.append(tenants)

        buildings = {"name": bldg.building_name,
                     "children": tenants_list}
        buildings_list.append(buildings)

    dendrogram = {"name": cities.city,
                  "children": buildings_list}

    return jsonify(dendrogram)


# GEOJSON ROUTE
@app.route('/bldg_geojson.geojson')
def bldg_data():
    """Return data from buildings table as GEOJSON."""

    bldgs = Building.query.all()

    bldg_geojson = {}
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
    """Return data from buildings table for barchart."""

    # Get the bldg_id for the building in question (AJAX).
    # bldg = request.args.get(bldg_id)

    bldg = Building.query.get(bldg_id)

    # Get buildings average data.
    avg = avg_bldg_height()

    data = []
    data.append(avg)
    data.append(bldg.height_ft)

    labels = ["average"]
    labels.append(bldg.building_name)

    avg_color = 'rgba(255,155,0,0.6)'
    bldg_color = 'rgba(255,0,0,0.8)'
    border_avg_color = 'rgba(255,155,0,1.0)'
    border_bldg_color = 'rgba(255,0,0,1.0)'

    backgroundColor = [avg_color,
                       bldg_color]
    borderColor = [border_avg_color,
                   border_bldg_color]
    borderWidth = 2

    datasets = [
        {
            'label': "Compare to San Francisco average bldg height (this dataset)",
            'backgroundColor': backgroundColor,
            'borderColor': borderColor,
            'borderWidth': borderWidth,
            'data': data,
        }
    ]

    bldg_barchart = {"labels": labels, "datasets": datasets}

    return jsonify(bldg_barchart)


@app.route('/bldg/<int:bldg_id>')
def show_bldg_details(bldg_id):
    """When user clicks on name of building, show building details."""

    bldg = Building.query.get(bldg_id)

    photos = flickr.find({'$text': {'$search': bldg.building_name}})

    # urls_m = []

    # for photo in photos:
    #     url_m = photo['url_m']
    #     urls_m.append(url_m)

    url_m = photos[5]['url_m']

    bldg_feature = {}

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
                        },
                    "photos": {
                        "url_m": url_m,
                        },
                    }

    return jsonify(bldg_feature)


# JSON FOR FLICKR PHOTO OF BLDG
@app.route('/flickr_filter.json')
def flickr_filter():
    """Returns a random Flickr image url to display photo of bldg."""

    bldg_id = request.args.get('bldg_id')

    bldg = Building.query.get(bldg_id)
    bldg_text = bldg.building_name.replace(' ', '')
    bldg_text = bldg_text.lower()

    bldg_photos = flickr.find({'$text': {'$search': bldg_text}})
    count = bldg_photos.count()

    if count:
        i = get_randint(0, count-1)
        photo = bldg_photos[i]
        photo_url = photo['url_s']
        owner = photo['ownername']
        title = photo['title']
        description = photo['description']['_content']
        description = description.rstrip()
        photo = {"url_s": photo_url,
                 "ownername": owner,
                 "photo_title": title,
                 "descript": description,
                 }

    else:
        photo = None

    bldg_flickr = {"properties": {"bldg_id": bldg.bldg_id,
                                  "photo": photo,
                                  },
                   }

    return jsonify(bldg_flickr)


# def filter_photos():
#     """Perform an initial filter on photo results to extract quality photos in location."""

    # data = flickr.load_file()
    # bldg_photo_totals, bldgs_photos = flickr.return_photos(data, bldgs)
    # urls = flickr.filter_photos(bldg_photo_totals, bldgs_photos)

#     # bldg_tags = []

#     urls = []

#     for bldg_grp in photos:
#         # for photo in bldg_grp:
#         if len(bldg_grp) > 0:
#             my_randint = get_randint(0, len(bldg_grp)-1)
#             url = bldg_grp[my_randint]['url_s']
#             urls.append(url)
#         else:
#             continue

#     # raise Exception

#     return urls


# @app.route('/photos')
# def get_photos():

#     bldgs = Building.query.all()

#     photos_bldgs = []

#     for bldg in bldgs:
#         photos = create_photos_by_bldg(bldg.bldg_id)
#         photos_bldgs.append(photos)

#     return pprint.pprint(photos_bldgs)


@app.route('/user_curates', methods=['GET'])
def user_curates():

    user_query = "night skyscraper"
    # user_query = request.args.get['user_query']
    user_terms = user_query.split(' ')

    queried_photos = []

    # for term in user_terms:
    photos = flickr.find({'$text': {'$search': {'$all': user_terms}}})
    for photo in photos:
        queried_photos.append(photo)

    return render_template("curated_photos.html", query=queried_photos)


# @app.route('/flickr_data.json')
# def flickr_data():
#     """Combines JSON file data, including image urls, into one file for all bldgs."""

#     bldgs = Building.query.all()

#     combine_flickr_data(bldgs)

#     return None


# HELPER FUNCTIONS #
####################################################################
"""All functions database."""


def add_user(username, password):
    """Called when a new user registers."""

    user = User(username=username,
                password=password)

    db.session.add(user)
    db.session.commit()


def add_card(user_id, bldg_id):
    """Called when a user saves a new card."""

    card = Card(user_id=user_id,
                bldg_id=bldg_id)

    db.session.add(card)
    db.session.commit()


def avg_bldg_height():
    """Queries database for average building height."""

    avg = db.session.query(func.avg(Building.height_ft).label('average')).scalar()

    return avg


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


def get_randint(low, high):
    """Obtain a random integer between low and high, inclusive, for use in any function."""

    my_randint = randint(low, high)

    return my_randint


def get_randsample(high, n):
    """Obtain n random integers between 0 high, exclusive, for use in any function."""

    my_randsample = sample(range(high), n)

    return my_randsample


if __name__ == "__main__":
    import doctest

    result = doctest.testmod()
    if not result.failed:
        print "ALL TESTS PASSED. GOOD WORK!"


####################################################################


if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the
    # point that we invoke the DebugToolbarExtension
    app.debug = True

    app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = False

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    app.run(host='0.0.0.0')
