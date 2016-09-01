# Use Python os.environ to get environmental variables.
# Note: you must run `source secrets.sh` before running
# this file to set required environmental variables.

# CURATION TOOL. MACHINE LEARNING.

import os

import requests
import json

from random import randint, sample

# INSTAGRAM_CLIENT_ID = os.environ['INSTAGRAM_CLIENT_ID']
# INSTAGRAM_CLIENT_SECRET = os.environ['INSTAGRAM_CLIENT_SECRET']

FLICKR_KEY = os.environ['FLICKR_KEY']
FLICKR_SECRET = os.environ['FLICKR_SECRET']


# def slice_list(bldgs):
#     """Slices list of buildings to make an appropriate FLICKR API call."""

#     length = len(bldgs)

#     bldg_subsets = []

#     for i in range(0, length, 20):
#         bldg_subset = bldgs[i:i+20]
#         bldg_subsets.append(bldg_subset)

#     return bldg_subsets


def flickr_search(bldgs):
    """Makes request to FLICKR API, given bldg tags. Saves file for each bldg and page of 500 results max."""

    flickr_per_page_limit = 500

    for bldg in bldgs:
        bldg_name = bldg.building_name
        city_name = bldg.city.city
        # Assumes all buildings are in the same city, if joined for API call.

        page = 1
        page_count = 80  # Arbitrary limit.

        extras = 'url_s, url_m, geo, tags, owner_name, date_taken, description'

        # extras: description, license, date_upload, date_taken, owner_name, icon_server,
        # original_format, last_update, geo, tags, machine_tags, o_dims, views, media, path_alias,
        # url_sq, url_t, url_s, url_q, url_m, url_n, url_z, url_c, url_l, url_o

        while (page < page_count):

            payload = {'tags': bldg_name+', '+city_name, 'tag_mode': 'all',
                       'extras': extras,
                       'ispublic': 1, 'format': 'json', 'nojsoncallback': 1,
                       'api_key': FLICKR_KEY,
                       'page': page, 'per_page': flickr_per_page_limit}

            # Response object.
            r = requests.get('https://api.flickr.com/services/rest/?method=flickr.photos.search', params=payload)

            # Content of Response object as string.
            content = r.content

            # JSON dictionary.
            data = json.loads(content)

            save_file(data, bldg, page)

            page_count = int(data['photos']['pages'])

            print '''Getting page {} in {} total pages.
                     Queried for {} building at rank {}'''.format(page,
                                                                  page_count,
                                                                  bldg_name,
                                                                  bldg.rank)

            page += 1


def save_file(data, bldg, page):
    """Dumps JSON data result into file."""

    f = open('json/'+str(bldg.bldg_id)+'/flckrdata_'+str(bldg.bldg_id)+'_'+str(page)+'.json', 'w')
    json.dump(data, f)
    f.close()


# # Cannot combine this many files, or files of this size. Fails.
# def combine_files(bldgs):
#     """Loads JSON data from files and combines into one file for all bldgs."""

#     photos_data = {}

#     for bldg in bldgs:
#         for file in os.listdir('json/'+str(bldg.bldg_id)):
#             if file.endswith('.json'):
#                 f = open('json/'+str(bldg.bldg_id)+'/'+file, 'r')
#                 data = json.load(f)
#                 photos_data[bldg.bldg_id] = data
#                 f.close()

#     f = open('json/flckrdata_bldgs.json', 'w')
#     json.dump(photos_data, f)
#     f.close()


# def load_file():
#     """Loads combined JSON data file to read."""

#     f = open('json/flckrdata_bldgs.json', 'r')
#     data = json.load(f)

#     return data


def return_photos(data, bldgs):
    """Return all photo results in a list. """

    count = 0

    bldgs_photos = []

    bldg_photo_totals = []

    for bldg in bldgs:
        total = data[str(bldg.bldg_id)]['photos']['total']
        bldg_photo_totals.append(total)

        photos = []

        for photo in data[str(bldg.bldg_id)]['photos']['photo']:
            photos.append(photo)
            count += 1

        bldgs_photos.append(photos)

    return bldg_photo_totals, bldgs_photos


def filter_photos(totals, photos):
    """Perform an initial filter on photo results to extract quality photos in location."""

    # bldg_tags = []

    urls = []

    for bldg_grp in photos:
        # for photo in bldg_grp:
        if len(bldg_grp) > 0:
            my_randint = get_randint(0, len(bldg_grp)-1)
            url = bldg_grp[my_randint]['url_s']
            urls.append(url)
        else:
            continue

    # raise Exception

    return urls


# def flickr_count_results(data):
#     """Assesses the results of the FLICKR API call."""

#     # Count the number of photo results.
#     results_count = int(data['photos']['total'])

#     return results_count


# def get_random_image(results_count):
#     """Get one random image."""

#     flickr_per_page_limit = 500

#     if results_count > flickr_per_page_limit:
#         i = get_randint(0, flickr_per_page_limit-1)
#     else:
#         i = get_randint(0, results_count-1)

#     return i


# def get_random_images(results_count):
#     """Get a random sample of n images."""

#     flickr_per_page_limit = 500
#     n = 2  # Must be less than 500, or flickr_per_page_limit.

#     if results_count > flickr_per_page_limit:
#         idx = get_randsample(flickr_per_page_limit, n)
#     elif results_count > n:
#         idx = get_randsample(results_count, n)
#     else:
#         idx = get_randsample(results_count, results_count)

#     return idx


# def get_image_urls(idx):

#     bldg_urls = []

#     for i in idx:
#         idx_photo = data['photos']['photo'][i]['id']
#         # idx_user = data['photos']['photo'][i]['owner']
#         idx_farm = data['photos']['photo'][i]['farm']
#         idx_server = data['photos']['photo'][i]['server']
#         idx_secret = data['photos']['photo'][i]['secret']
#         # url = 'https://www.flickr.com/photos/' + idx_user + '/' + idx_photo
#         url = 'https://farm'+str(idx_farm)+'.staticflickr.com/'+idx_server+'/'+idx_photo+'_'+idx_secret+'_s.jpg'
#         # url = 'https://farm'+str(idx_farm)+'.staticflickr.com/'+idx_server+'/'+idx_photo+'_'+idx_secret+'_q.jpg'
#         bldg_urls.append(url)

#         urls.append(bldg_urls)

#     return urls


#     urls = []


def get_randint(low, high):
    """Obtain a random integer between low and high, inclusive, for use in any function."""

    my_randint = randint(low, high)

    return my_randint


def get_randsample(high, n):
    """Obtain n random integers between 0 high, exclusive, for use in any function."""

    my_randsample = sample(range(high), n)

    return my_randsample
