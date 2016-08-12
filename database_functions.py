"""All functions database."""

from model_buildings import User

from model_buildings import db


def add_user(username, password):
    """Called when a new user registers."""

    user = User(username=username,
                password=password)

    db.session.add(user)
    db.session.commit()
