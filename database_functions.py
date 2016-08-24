"""All functions database."""

from model_buildings import User, Building

from model_buildings import db

from sqlalchemy.sql import func


def add_user(username, password):
    """Called when a new user registers."""

    user = User(username=username,
                password=password)

    db.session.add(user)
    db.session.commit()


def get_bldg_query(bldg_search):
    """Queries database for building searched by user."""

    # search terms entered by user
    search = bldg_search.split(" ")

    search_results = []

    for term in search:
        if term.lower() != "building" and term.lower() != "tower":  # Hope to exclude these terms from search. Better way?
            bldg_match = db.session.query(Building).filter(Building.building_name.ilike('%'+term+'%')).first()
            search_results.append(bldg_match)

    search_results = list(set(search_results))

    return search_results


def avg_bldg_height():
    """Queries database for average building height."""

    avg = db.session.query(func.avg(Building.height_ft).label('average'))

    return avg
