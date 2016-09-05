# Use Python os.environ to get environmental variables.
# Note: you must run `source secrets.sh` before running
# this file to set required environmental variables.

# CURATION TOOL. MACHINE LEARNING.

import os

import requests
import json

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


# Once called, no need to call again.
def flickr_search(bldgs):
    """Makes request to FLICKR API, given bldg tags. Saves file for each bldg, each page 500 results max."""

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

    f = open('json/flckrdata_'+str(bldg.bldg_id)+'_'+str(page)+'.json', 'w')
    json.dump(data, f)
    f.close()


# # Cannot combine this many files, or files of this size. Fails.
# def combine_flickr_data(bldgs):
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


# def get_image_urls(idx):

#     bldg_urls = []
#     urls = []

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
