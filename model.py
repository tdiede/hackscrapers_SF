"""Models and database functions for Buildings project."""

from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


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

    bldg = db.relationship("Building",
                           backref=db.backref("tenants",
                                              order_by=tenant_id))


class User(db.Model):
    """Users of web app in database."""

    __tablename__ = "users"

    def __repr__(self):
        """Show info about user."""
        return "<User username=%s>" % (self.username)

    user_id = db.Column(db.String(16), primary_key=True)
    username = db.Column(db.String(64), unique=True)
    oauth_token = db.Column(db.String(64))


class Card(db.Model):
    """Cards of bldgs created by users of web app in database."""

    __tablename__ = "cards"

    def __repr__(self):
        """Show info about cards."""
        return "<Card card_id=%d user_id=%d bldg_id=%d>" % (self.card_id, self.user_id, self.bldg_id)

    card_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    user_id = db.Column(db.String(16), db.ForeignKey('users.user_id'), nullable=False)
    bldg_id = db.Column(db.Integer, db.ForeignKey('buildings.bldg_id'), nullable=False)
    card_img = db.Column(db.String(256))
    comments = db.Column(db.String(256))

    user = db.relationship("User",
                           backref=db.backref("cards",
                                              order_by=card_id))


def connect_to_db(app, db_uri=None):
    """Connect the database to our Flask app."""

    # Configure to use our PostgreSQL database.
    app.config['SQLALCHEMY_DATABASE_URI'] = db_uri or 'postgresql:///buildings'
    db.app = app
    db.init_app(app)


if __name__ == "__main__":

    from server import app
    connect_to_db(app)
    print("Connected to PostgreSQL DB.")
