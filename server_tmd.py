"""Initial project application Flask server.

Provides web interface for browsing skyscrapers.

Author: Therese Diede
"""

from model_buildings import Building

from flask import (Flask, render_template)

app = Flask(__name__)

app.secret_key = 'jfsajweWlkakNjakswpclI'


@app.route('/')
def index():
    """Return homepage."""

    return render_template("homepage.html")


@app.route('/buildings')
def buildings_list():
    """Return list of buildings."""

    bldgs = Building.query.all()

    return render_template("buildings_list.html", bldgs=bldgs)


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')
