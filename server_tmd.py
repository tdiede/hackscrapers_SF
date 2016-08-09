"""Initial project application Flask server.

Provides web interface for browsing skyscrapers.

Author: Therese Diede
"""

from jinja2 import StrictUndefined

from flask import (Flask, render_template)
from flask_debugtoolbar import DebugToolbarExtension

from model_buildings import connect_to_db
from model_buildings import Building, City


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


if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the
    # point that we invoke the DebugToolbarExtension
    app.debug = True

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    app.run(host='0.0.0.0')
