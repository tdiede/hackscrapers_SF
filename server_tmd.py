"""Initial project application Flask server.

Provides web interface for browsing skyscrapers.

Author: Therese Diede
"""

from jinja2 import StrictUndefined

from flask import (Flask, render_template, redirect, request, session, flash, jsonify)
from flask_debugtoolbar import DebugToolbarExtension

from model_buildings import connect_to_db, db
from model_buildings import Building, City, User

from database_functions import add_user, get_bldg_query, avg_bldg_height

import flickr


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

    user = User.query.filter_by(username=current_username).one()
    user_username = user.username
    user_password = user.password

    if user_username:  # Checks to see if user is registered.
        if current_password == user_password:  # Checks to see if user password is correct.
            session['current_user'] = current_username
            flash("Logged in as %s" % (current_username))
            return redirect('/dashboard')
        else:
            flash("Wrong password. Try again!")
            return redirect('/')
    else:
        flash("Please register.")
        return redirect('/register')


@app.route('/dashboard')
def dashboard():
    """Return homepage (dashboard)."""

    current_user = session.get('current_user')

    return render_template("homepage.html", current_user=current_user)


# @app.route('/gen_flickr_files')
# def gen_flickr_files():
#     """Calls Flickr API for photo search. Saves JSON data files for each bldg."""

#     bldgs = db.session.query(Building).options(db.joinedload('city')).all()

#     flickr.flickr_search(bldgs)

#     return None


# @app.route('/flickr_data.json')
# def flickr_data():
#     """Combines JSON file data, including image urls, into one file for all bldgs."""

#     bldgs = Building.query.all()

#     flickr.combine_files(bldgs)

#     return None


@app.route('/filter_flickr')
def filter_flickr():
    """Returns filtered list of Flickr image urls to display photos."""

    data = flickr.load_file()

    bldgs = Building.query.all()

    bldg_photo_totals, bldgs_photos = flickr.return_photos(data, bldgs)

    urls = flickr.filter_photos(bldg_photo_totals, bldgs_photos)

    return render_template("building_photos.html", urls=urls)


@app.route('/buildings')
def buildings_list():
    """Return list of buildings."""

    bldg_search = request.args.get('building')

    bldgs = []

    if bldg_search:
        search_results = get_bldg_query(bldg_search)
        for term in search_results:
            if term is None:
                search_results.remove(None)
            bldgs.append(term)
        return render_template("building_details.html", bldgs=bldgs)

        if len(search_results) == 0:
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

    flash("Thanks for playing. You have been logged out.")
    return redirect('/dashboard')


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


@app.route('/bldg_barchart.json')
def bldg_barchart():
    """Return data from buildings table for barchart."""

    # Only query the building in question (AJAX).
    bldgs = Building.get()

    # Get buildings average data.
    avg_bldg_height = avg_bldg_height()

    labels = ["average"]

    for bldg in bldgs:

        labels.append(bldg.building_name)

    datasets = [
        {
            label: "Compare to San Francisco average bldg height (this dataset)",
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
            ],
            borderWidth: 1,
            data: [avg_bldg_height + " ft", bldg.height_ft + " ft"],
        }
    ]

    bldg_barchart = {"labels": labels, "datasets": datasets}

    return jsonify(bldg_barchart)


if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the
    # point that we invoke the DebugToolbarExtension
    app.debug = True

    app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = False

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    app.run(host='0.0.0.0')
