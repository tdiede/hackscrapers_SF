"""Models and database functions for Buildings project."""

from flask_sqlalchemy import SQLAlchemy

# This is the connection to the PostgreSQL database; we're getting this through
# the Flask-SQLAlchemy helper library. On this, we can find the `session`
# object, where we do most of our interactions (like committing, etc.)

db = SQLAlchemy()


##############################################################################
# Model definitions

class Building(db.Model):
    """Buildings in SF."""

    __tablename__ = "buildings"

    def __repr__(self):
        """Show info about the building."""

        return "<Building rank={} building_name={}>".format(self.rank, self.building_name)

    bldg_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    place_id = db.Column(db.String(64))
    rank = db.Column(db.Integer)
    status = db.Column(db.String(64), nullable=True)
    building_name = db.Column(db.String(128))
    city_id = db.Column(db.Integer, db.ForeignKey('cities.city_id'), nullable=False)
    lat = db.Column(db.Float)
    lng = db.Column(db.Float)
    height_m = db.Column(db.String, nullable=True)
    height_ft = db.Column(db.String, nullable=True)
    floors = db.Column(db.Integer, nullable=True)
    completed_yr = db.Column(db.String, nullable=True)
    material = db.Column(db.String(64), nullable=True)
    use = db.Column(db.String(64), nullable=True)

    # Define relationship to city.
    city = db.relationship("City",
                           backref=db.backref("buildings",
                                              order_by=bldg_id))


class City(db.Model):
    """Cities in the world with tall buildings."""

    __tablename__ = "cities"

    def __repr__(self):
        """Show info about the city."""

        return "<City rank=%d city=%s bldg_count=%d>" % (self.rank, self.city, self.bldg_count)

    city_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    rank = db.Column(db.Integer)
    city = db.Column(db.String(64))
    country = db.Column(db.String(64))
    bldg_count = db.Column(db.Integer)


class Tenant(db.Model):
    """Tenants in San Francisco tall buildings."""

    __tablename__ = "tenants"

    def __repr__(self):
        """Show a list of all tenants found by Google Places API."""

        return "<Tenant tenant_id=%d tenant=%s>" % (self.tenant_id, self.tenant)

    tenant_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    tenant = db.Column(db.String(128))
    place_id = db.Column(db.String(64))
    bldg_id = db.Column(db.Integer, db.ForeignKey('buildings.bldg_id'), nullable=False)

    # Define relationship to bldg.
    bldg = db.relationship("Building",
                           backref=db.backref("tenants",
                                              order_by=tenant_id))


##############################################################################
# Model definition

class User(db.Model):
    """Users of web app in database."""

    __tablename__ = "users"

    def __repr__(self):
        """Show info about user."""

        return "<User user_id=%d username=%s password=%s>" % (self.user_id, self.username, self.password)

    user_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    username = db.Column(db.String(64))
    password = db.Column(db.String(64))


##############################################################################
# Helper functions

def connect_to_db(app):
    """Connect the database to our Flask app."""

    # Configure to use our PstgreSQL database
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///buildings'
    db.app = app
    db.init_app(app)


if __name__ == "__main__":
    # As a convenience, if we run this module interactively, it will leave
    # you in a state of being able to work with the database directly.

    from server_tmd import app
    connect_to_db(app)
    print "Connected to DB."
