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

var url_bldgs = '/bldg_geojson.geojson';

var bldgs_source = new mapboxgl.GeoJSONSource({
    data: url_bldgs
});

var marker = new mapboxgl.Marker()
    .setLngLat([-122.3924805, 37.7893387])
    .addTo(map);

var icon = '../static/img/x.png';


var popup = new mapboxgl.Popup()
  .setLngLat(marker.lngLat)
  .setHTML("<h1>Hello World!</h1>")
  .addTo(map);



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

    map.addSource('bldgs', {
        'type': 'geojson',
        'data': url_bldgs,
    });

    map.addLayer({
        'id': 'bldgs',
        'type': 'symbol',
        'source': 'bldgs',
        'layout': {
            'icon-image': 'marker-15',
            'icon-padding': 1,
            'text-field': '{building_name}',
            'text-font': ['Open Sans Regular', 'Arial Unicode MS Regular'],
            'text-size': 12,
            'text-offset': [0.5, 0.1],
            'text-anchor': 'top-left'
        },
        // 'paint': {
        //     'circle-radius': {
        //         "property": "scaling",
        //         "stops": [
        //           // zoom is start_zoom and "scaling" is 0 -> circle radius will be.
        //           [{zoom: start_zoom, value: 0}, 1],
        //           // zoom is end_zoom and "scaling" is 0 -> circle radius will be.
        //           [{zoom: end_zoom, value: 0}, 6],
        //         ]},
        //     'circle-color': '#088',
        //     'circle-opacity': 0.5,
        // }
    });

    // map.addSource('adus', {
    //     'type': 'geojson',
    //     'data': url_adus,
    // });

    // map.addLayer({
    //     'id': 'adus_data',
    //     'type': 'fill',
    //     'source': 'adus',
    //     'layout': {},
    //     'paint': {
    //         'fill-color': '#088',
    //         'fill-opacity': 0.2
    //     }
    // });

});


// Indicate that the symbols are clickable
// by changing the cursor style to 'pointer'.
map.on('mousemove', function (e) {
    var features = map.queryRenderedFeatures(e.point, { layers: ['bldgs'] });
    map.getCanvas().style.cursor = (features.length) ? 'pointer' : 'crosshair';
});


// When a click event occurs near a building circle or symbol,
// open a popup at the location of the feature,
// with description HTML from its properties.
map.on('click', function (e) {
    var features = map.queryRenderedFeatures(e.point, { layers: ['bldgs'] });
    if (!features.length) {
        return;
    }

    var feature = features[0];

    var popup = new mapboxgl.Popup()
        .setLngLat(map.unproject(e.point))
        .setHTML(feature.properties.building_name + "<br>" + feature.properties.use)
        .addTo(map);
});



// // AJAX
// function showBuildingInfo(results) {
//     console.log(results);
//     // alert(results.bldg_id);
//     // alert(results.lat);
//     // alert(results.lng);
// }


// function getBuildingInfo(evt) {
//     evt.preventDefault();

//     $.get('/bldg_geojson.geojson',
//         showBuildingInfo);
// }

// $("#testing-ajax").on("click", showBuildingInfo);
