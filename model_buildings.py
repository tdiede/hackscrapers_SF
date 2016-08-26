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
    height_m = db.Column(db.Float, nullable=True)
    height_ft = db.Column(db.Float, nullable=True)
    floors = db.Column(db.Integer, nullable=True)
    completed_yr = db.Column(db.Integer, nullable=True)
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
# User

class User(db.Model):
    """Users of web app in database."""

    __tablename__ = "users"

    def __repr__(self):
        """Show info about user."""

        return "<User user_id=%d username=%s password=%s>" % (self.user_id, self.username, self.password)

    user_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    username = db.Column(db.String(64))
    password = db.Column(db.String(64))


###############################################################################
# Definition example_data() for testing

def example_data():
    """Sample data for testing."""
  # In case this is run more than once, empty out existing data from each table.
    User.query.delete()
    Building.query.delete()
    Tenant.query.delete()
    City.query.delete()

    user = User(user_id=1,
                username='me',
                password='password')

    bldg = Building(bldg_id=1,
                    place_id='ChIJWdUJpGOAhYARfBVi2TE8daI',
                    rank=1,
                    status='Under Construction',
                    building_name='Salesforce Tower',
                    city_id=41,
                    lat=37.7904907,
                    lng=-122.397125,
                    height_m=326.1,
                    height_ft=1070,
                    floors=61,
                    completed_yr=2018,
                    material='composite',
                    use='office')

    tenant = Tenant(tenant_id=1,
                    tenant='50 Fremont Center',
                    place_id='ChIJWdUJpGOAhYARfBVi2TE8daI',
                    bldg_id=1)

    city = City(city_id=41,
                rank=40,
                city='San Francisco',
                country='United States',
                bldg_count=109)

    # db.session.add([user, bldg, tenant, city])

    db.session.add(user)

    db.session.add(bldg)
    # db.session.flush()
    db.session.add(tenant)
    # db.session.flush()
    db.session.add(city)

    db.session.commit()


##############################################################################
# Helper functions

def connect_to_db(app, db_uri='postgresql:///buildings'):
    """Connect the database to our Flask app."""

    # Configure to use our PstgreSQL database
    app.config['SQLALCHEMY_DATABASE_URI'] = db_uri  # 'postgresql:///buildings'
    db.app = app
    db.init_app(app)


if __name__ == "__main__":
    # As a convenience, if we run this module interactively, it will leave
    # you in a state of being able to work with the database directly.

    from server_tmd import app
    connect_to_db(app)
    print "Connected to DB."
