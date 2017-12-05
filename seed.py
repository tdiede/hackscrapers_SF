"""Utility file to seed buildings database from data in skyscraper data."""

import csv
from google_places import (get_google_places, extract_geo, extract_names)  # my google places api module


def utf_8_encoder(unicode_csv_data):
    for line in unicode_csv_data:
        yield line.encode('utf-8')


def unicode_csv_reader(unicode_csv_data, dialect=csv.excel, **kwargs):
    csv_reader = csv.reader(utf_8_encoder(unicode_csv_data), dialect=dialect, **kwargs)
    for row in csv_reader:
        yield [unicode(cell, 'utf-8') for cell in row]


def load_buildings():
    """Load buildings from SFbldgs.csv into database."""

    print("Buildings")
    Building.query.delete()
    Tenant.query.delete()

    bldg_count = 0

    # Read data file and insert data
    with open("seed_data/SFbldgs.csv", 'rU') as f:
        reader = unicode_csv_reader(f)
        for row in reader:

            rank, status, building_name, city_name, height_m, height_ft, floors, completed_yr, material, use = row

            bldg_count += 1
            print("*"*80)
            print(city_name)

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

            print(bldg)
            db.session.add(bldg)
            db.session.flush()

            if places:
                bldg_id = Building.query.filter_by(place_id=place_id).first().bldg_id
                load_tenants(places, bldg_count, bldg_id)

    db.session.commit()


def load_tenants(places, bldg_count, bldg_id):
    """Load tenants from Google Places API request into database."""

    print("Tenants")

    place_id, place_names = extract_names(places)

    for place in place_names:

        tenant = Tenant(tenant=place,
                        place_id=place_id,
                        bldg_id=bldg_id)

        print(place)

        db.session.add(tenant)

    db.session.commit()


def load_cities():
    """Load cities from GLBcities into database."""

    print("Cities")
    City.query.delete()

    # Read data file and insert data
    with open('seed_data/GLBcities.csv', 'rU') as f:
        reader = unicode_csv_reader(f)
        for row in reader:
            rank, city, country, bldg_count = row

            city = City(rank=rank,
                        city=city,
                        country=country,
                        bldg_count=bldg_count)

            db.session.add(city)

    db.session.commit()


if __name__ == "__main__":  # program run by itself

    import os
    os.system("dropdb buildings")
    print("dropdb buildings")
    os.system("createdb buildings")
    print("createdb buildings")

    from server import create_app

    from model import db
    from model import (Building, City, Tenant)

    app = create_app()
    with app.test_request_context():
        # db.drop_all()
        db.create_all()

        load_cities()
        load_buildings()
