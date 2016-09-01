"""All functions database."""

from model_buildings import User, Building

from model_buildings import db

from sqlalchemy.sql import func, desc


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

if __name__ == "__main__":
    import doctest

    print
    result = doctest.testmod()
    if not result.failed:
        print "ALL TESTS PASSED. GOOD WORK!"
    print
