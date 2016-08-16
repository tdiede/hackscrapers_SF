"use strict";

mapboxgl.accessToken = 'pk.eyJ1IjoidGRpZWRlIiwiYSI6ImNpcXNpOTcwOTAyeGVmb25uYmxjN3VwaTQifQ.xcvPMOnJsUR4jSvIYwgoIQ';


var layers = [{
            "id": "water",
            "type": "fill",
            "paint": {
                "fill-color": "#eeeeee",
                "fill-opacity": 0.3,
                }
            }];

var origStyleURL = "mapbox://styles/mapbox/dark-v9";
var newStyleURL = "mapbox://styles/mapbox/light-v9";

// This is the JSON style object, called below when creating a new instance of Map Class. Root properties.
var style = {
    "version": 8,
    "name": "Mapbox Streets",
    "sprite": "mapbox://sprites/mapbox/streets-v8",
    "glyphs": "mapbox://fonts/mapbox/{fontstack}/{range}.pbf",
    "sources": {
            "mapboxstreets": {
                "type": "vector",
                "url": origStyleURL,
                },
            },
    "transition": {
        "duration": 300,
        "delay": 0
        },
    "layers": layers,
    };



var start_coord = [-122.39620375509841, 37.79451329641192];
var end_coord = [-122.40, 37.79];
var start_zoom = 8.75;
var end_zoom = 12.85;
var start_pitch = 30;
var end_pitch = 60;
var start_bearing = 0;
var end_bearing = -125;

var map = new mapboxgl.Map({
    container: 'map-mapbox',
    style: origStyleURL,  //stylesheet location
    center: start_coord,
    zoom: start_zoom,
    pitch: start_pitch, // pitch in degrees
    bearing: start_bearing, // bearing in degrees
});


var nav = new mapboxgl.Navigation({position: 'top-left'});

// map.addControl(nav);

map.setStyle(newStyleURL);




// layers[0]
// map.style.sources.adus

var url_adus = '../static/geojson/adus.geojson';

var adus_source = new mapboxgl.GeoJSONSource({
    data: url_adus
});

var url_bldgs = '../static/geojson/bldgs.json';

var bldgs_source = new mapboxgl.GeoJSONSource({
    data: url_bldgs
});

map.on('load', function () {

    map.flyTo({
        center: end_coord,
        zoom: end_zoom,
        pitch: end_pitch,
        bearing: end_bearing,

        speed: 0.7, // make the flying slow
        curve: 1, // change the speed at which it zooms out

        // This can be any easing function: it takes a number between
        // 0 and 1 and returns another number between 0 and 1.
        easing: function (t) {
            return t;
        }
    });

    map.addSource('adus', {
        'type': 'geojson',
        'data': url_adus,
    });

    map.addSource('bldgs', {
        'type': 'json',
        'data': url_bldgs,
    });

    map.addLayer({
        'id': 'adus_data',
        'type': 'fill',
        'source': 'adus',
        'layout': {},
        'paint': {
            'fill-color': '#088',
            'fill-opacity': 0.2
        }
    });

    map.addLayer({
        'id': 'bldgs_data',
        'type': 'circle',
        'source': 'bldgs',
        'layout': {},
        'paint': {
            'fill-color': '#088',
            'fill-opacity': 0.2
        }
    });
});





// AJAX
// function showBuildingInfo(results) {
//     console.log(results);
//     alert(results.bldg_id);
//     alert(results.lat);
//     alert(results.lng);

//     bldg_info.forEach( function(marker) {

//     // Create marker.
//     new mapboxgl.Marker()
//         .setLngLat()
//         .addTo(map);

//     console.log(marker._LntLat);

//     });

//     // map.marker.setLngLat(results.lng, results.lat);

// }


// function getBuildingInfo(evt) {
//     evt.preventDefault();

//     $.get("/bldg_info.json",
//         showBuildingInfo);
// }

// $("#testing-ajax").on("click", showBuildingInfo);







//   var infoWindow = new google.maps.InfoWindow({
//       width: 150
//   });

//   // Retrieving the information with AJAX
//   $.get('/buildings.json', function (buildings) {
//   });

//     var bldg, marker, html;

//       for (var key in bldgs) {
//           bldg = bldgs[key];

//           // Define the marker
//           marker = new google.maps.Marker({
//               position: new google.maps.LatLng(bldg.capLat, bldg.capLong),
//               map: map,
//               title: 'Building ID: ' + bldg.bldg_id,
//               icon: '/static/img/x.png'
//           });

//           // Define the content of the infoWindow
//           html = (
//               '<div class="window-content">' +
//                   '<img src="/static/img/polarbear.jpg" alt="polarbear" style="width:150px;" class="thumbnail">' +
//                   '<p><b>Building Name: </b>' + bldg.building_name + '</p>' +
//                   '<p><b>Bear birth year: </b>' + bear.birthYear + '</p>' +
//               '</div>');

//           // Inside the loop we call bindInfoWindow passing it the marker,
//           // map, infoWindow and contentString
//           bindInfoWindow(marker, map, infoWindow, html);
//       }

// function bindInfoWindow(marker, map, infoWindow, html) {
//       google.maps.event.addListener(marker, 'click', function () {
//           infoWindow.close();
//           infoWindow.setContent(html);
//           infoWindow.open(map, marker);
//       });
//   }
// }

// google.maps.event.addDomListener(window, 'load', initMap);



