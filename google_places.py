# Use Python os.environ to get environmental variables.
# Note: you must run `source secrets.sh` before running
# this file to set required environmental variables.

import os

GOOGLE_PLACES_API_KEY = os.environ['GOOGLE_PLACES_API_KEY']

from googleplaces import GooglePlaces  # external library


def get_google_places(building_name):
    """Use the Google Places API from the python-google-places library to extract a place object, given a building name."""

    google_places = GooglePlaces(GOOGLE_PLACES_API_KEY)

    query_result = google_places.nearby_search(
        location='San Francisco, California', keyword=building_name)

    places = query_result.places

    return places


def extract_geo(places):
    """Use the Google Places API from the python-google-places library to extract place geo_location, given a place object."""

    for place in places:
        place_id = place.place_id
        lat = place.geo_location['lat']
        lng = place.geo_location['lng']

    return place_id, lat, lng


def extract_names(places):
    """Use the Google Places API from the python-google-places library to extract place names, given a place object."""

    place_names = []

    for place in places:
        place_id = place.place_id
        place_name = place.name
        place_names.append(place_name)

    return place_id, place_names


# Future exploration.
# def write_data():
#     """Save places data to google_places.csv file."""

#     f = open("google_places.cvs", "w")
#     f.write("line\n")  # Will convert \n to os.linesep
#     f.close()
