"""Utility file to seed buildings database from data in skyscraper data."""

from model_buildings import Building
from model_buildings import connect_to_db, db
from server_tmd import app


def load_buildings():
    """Load buildings from skyscrapers_SF into database."""

    print "Buildings"

    # Delete all rows in table, so if we need to run this a second time,
    # we won't be trying to add duplicate users
    Building.query.delete()

    # Read data file and insert data
    for row in open("seed_data/SFbldgs.csv"):
        row = row.rstrip()
        bldg_id, status, building_name, city, height_m, height_ft, floors, completed_yr, material, use = row.split(",")

        print bldg_id + "***"

        bldg = Building(bldg_id=bldg_id,
                        status=status,
                        building_name=building_name,
                        city=city,
                        height_m=height_m,
                        height_ft=height_ft,
                        floors=floors,
                        completed_yr=completed_yr,
                        material=material,
                        use=use)

        # We need to add to the session or it won't ever be stored
        db.session.add(bldg)

    # Once we're done, we should commit our work
    db.session.commit()


if __name__ == "__main__":
    connect_to_db(app)

    # In case tables haven't been created, create them
    db.create_all()

    # Import different types of data
    load_buildings()
