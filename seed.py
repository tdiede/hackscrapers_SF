"""Utility file to seed buildings database from data in skyscraper data."""

from server import app

from model import connect_to_db, db
from model import (Building, City, Tenant)  # my model file for buildings

from google_places import (get_google_places, extract_geo, extract_names)  # my google places api file

import sys
reload(sys)  # Reload does the trick!
sys.setdefaultencoding('UTF8')

import os
# Whenever seeding, drop existing database and create a new database.
# os.system("dropdb buildings")
# print "dropdb buildings"
# os.system("createdb buildings")
# print "createdb buildings"


def load_buildings():
    """Load buildings from SFbldgs.csv into database."""

    print "Buildings"

    # Delete all rows in table, so if we need to run this a second time,
    # we won't be trying to add duplicates.
    Building.query.delete()
    Tenant.query.delete()

    bldg_count = 0

    # Read data file and insert data
    for row in open("seed_data/SFbldgs.csv"):
        row = row.rstrip()
        rank, status, building_name, city_name, height_m, height_ft, floors, completed_yr, material, use = row.split(",")

        bldg_count += 1
        print "*"*80
        print city_name

        # Get city_id from building's city_name.
        city_id = City.query.filter_by(city=city_name).first().city_id

        # Make Google Places API request!
        places = get_google_places(building_name)

        if places:
            place_id, lat, lng = extract_geo(places)

        else:
            place_id = 0
            lat = 0
            lng = 0

        if height_m == '':
            height_m = None
        if height_ft == '':
            height_ft = None
        if completed_yr == '':
            completed_yr = None
        if floors == '':
            floors = None

        bldg = Building(place_id=place_id,
                        rank=rank,
                        status=status,
                        building_name=building_name,
                        lat=lat,
                        lng=lng,
                        city_id=city_id,
                        height_m=height_m,
                        height_ft=height_ft,
                        floors=floors,
                        completed_yr=completed_yr,
                        material=material,
                        use=use)

        print bldg

        # We need to add to the session or it won't ever be stored
        db.session.add(bldg)

        db.session.flush()

        if places:

            # Get bldg_id from newly committed building.
            bldg_id = Building.query.filter_by(place_id=place_id).first().bldg_id

            # Also seed "tenants" table.
            load_tenants(places, bldg_count, bldg_id)

    # Once we're done, we should commit our work
    db.session.commit()


def load_tenants(places, bldg_count, bldg_id):
    """Load tenants from Google Places API request into database."""

    print "Tenants"

    place_id, place_names = extract_names(places)

    for place in place_names:

        tenant = Tenant(tenant=place,
                        place_id=place_id,
                        bldg_id=bldg_id)

        print place

        # We need to add to the session or it won't ever be stored
        db.session.add(tenant)

    # Once we're done, we should commit our work
    db.session.commit()


# Manual entry for buildings not found by Google Places API.
# Actually I entered into Google Maps and they updated the data within 24 hours!
# def load_manual():
#     hd_bldg = Building.query.filter_by(building_name="Hunter-Dulin Building").one()
#     atct_bldg.Building.query.filter_by(building_name="San Francisco International Airport FAA Airport Traffic Control Tower (ATCT)").one()
#     db.session.add(hd_bldg)
#     db.session.add(atct_bldg)
#     db.session.commit()


def load_cities():
    """Load cities from GLBcities into database."""

    print "Cities"

    # Delete all rows in table, so if we need to run this a second time,
    # we won't be trying to add duplicate users
    City.query.delete()

    # Read data file and insert data
    for row in open("seed_data/GLBcities.csv"):
        row = row.rstrip()
        rank, city, country, bldg_count = row.split(",")

        city = City(rank=rank,
                    city=city,
                    country=country,
                    bldg_count=bldg_count)

        # We need to add to the session or it won't ever be stored
        db.session.add(city)

    # Once we're done, we should commit our work
    db.session.commit()


##############################################################################
# Helper functions


if __name__ == "__main__":

    connect_to_db(app, os.environ.get("DATABASE_URL"))

    # In case tables haven't been created, create them
    # db.drop_all()
    # db.create_all()

    # Import different types of data
    # load_cities()
    # load_buildings()
