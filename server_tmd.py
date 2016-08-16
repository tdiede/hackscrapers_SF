"""Initial project application Flask server.

Provides web interface for browsing skyscrapers.

Author: Therese Diede
"""

from jinja2 import StrictUndefined

from flask import (Flask, render_template, redirect, request, session, flash, jsonify)
from flask_debugtoolbar import DebugToolbarExtension

from model_buildings import connect_to_db
from model_buildings import Building, City, User

from database_functions import add_user


app = Flask(__name__)

app.secret_key = 'jfsajweWlkakNjakswpclI'

app.jinja_env.undefined = StrictUndefined


@app.route('/')
def index():
    """Return homepage."""

    return render_template("homepage.html")


@app.route('/buildings')
def buildings_list():
    """Return list of buildings."""

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
        return redirect('/login')
    else:
        add_user(current_username, current_password)
        flash("Welcome. You are now a registered user, %s! Please make yourself at home." % (current_username))
        return redirect('/')


@app.route('/login')
def user_login():
    """User login form."""

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
            return redirect('/')
        else:
            flash("Wrong password. Try again!")
            return redirect('/login')
    else:
        flash("Please register.")
        return redirect('/register')


@app.route('/map')
def display_map():
    """Page where user can see map and map data."""

    return render_template("mapbox.html")


@app.route('/bldg_data.json')
def bldg_data():
    """Return data from buildings table as JSON."""

    bldgs = Building.query.all()

    bldg_data = {}

    for bldg in bldgs:
        bldg_info = {"place_id": bldg.place_id,
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
                     "use": bldg.use, }

        bldg_data[bldg.bldg_id] = bldg_info

    return jsonify(bldg_data)


if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the
    # point that we invoke the DebugToolbarExtension
    app.debug = True

    app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = False

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    app.run(host='0.0.0.0')
