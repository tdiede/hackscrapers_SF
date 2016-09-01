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

var lightStyle = "mapbox://styles/mapbox/light-v9";

// This is the JSON style object, called below when creating a new instance of Map Class. Root properties.
var style = {
    "version": 8,
    "name": "Mapbox Streets",
    "sprite": "mapbox://sprites/mapbox/streets-v8",
    "glyphs": "mapbox://fonts/mapbox/{fontstack}/{range}.pbf",
    "sources": {
            "mapboxstreets": {
                "type": "vector",
                "url": lightStyle,
                },
            },
    "transition": {
        "duration": 300,
        "delay": 0
        },
    "layers": layers,
    };

// Setting initial coordinates, zoom, pitch, bearing.
var coord = [-122.43767443655646, 37.75799046891847];
var zoom = 11.85;
var pitch = 0;
var bearing = 0;


// Set bounds to San Francisco.
var bounds = [
    [-122.1, 37], // Southwest coordinates
    [-122.6, 38]  // Northeast coordinates
];

// Check if Mapbox GL is supported by browser.
if (!mapboxgl.supported()) {
    alert('Your browser does not support Mapbox GL .');
} else {
    var map = new mapboxgl.Map({
        container: 'map-mapbox',
        style: lightStyle,  //stylesheet location
        center: coord,
        zoom: zoom,
        pitch: pitch, // pitch in degrees
        bearing: bearing, // bearing in degrees
        maxBounds: bounds,
    });
}

// map.setStyle(lightStyle);  // if want to change at future point.

var nav = new mapboxgl.Navigation({position: 'top-left'});
map.addControl(nav);


var url_bldgs = '/bldg_geojson.geojson';



map.on('load', function () {

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
    });

// var bbox = [37, -123, 38, -122];

// var points = turf.random('points', 30, {
//   bbox: bbox
// });
// //=points
// // add a random property to each point between 0 and 9
// for (var i = 0; i < points.features.length; i++) {
//   points.features[i].properties.z = ~~(Math.random() * 9);
// }
// var tin = turf.tin(points, 'z')
// for (var i = 0; i < tin.features.length; i++) {
//   var properties  = tin.features[i].properties;
//   // roughly turn the properties of each
//   // triangle into a fill color
//   // so we can visualize the result
//   properties.fill = '#' + properties.a +
//     properties.b + properties.c;
// }

// console.log(tin);



//     map.addSource('tin', {
//         'type': 'geojson',
//         'data': {
//             'type': 'FeatureCollection',
//             'features': [{
//                 'type': 'Feature',
//                 'properties': {
//                     'a': properties.a,
//                     'b': properties.b,
//                     'c': properties.c,
//                     'fill': properties.fill
//                 },
//                 'geometry': {
//                     'type': 'Polygon',
//                     'coordinates': coordinates
//             }}]}

});


    // BarChart from chart.js to display bldg height comparison.
    function createChart(bldgData) {
        var options = { responsive: true };
        var ctx_bar = $("#barChart").get(0).getContext("2d");
        var myBarChart = new Chart(ctx_bar, {type: 'bar',
                                             data: bldgData,
                                             options: options});
        $('#barLegend').html(myBarChart.generateLegend());
    }

    function showChart(evt) {
        var bldg_id = $('#bldg-details').data('feature');
        $.get('/bldg_barchart.json/'+bldg_id, createChart);
    }

    // $('#bldg_details').on('click', showChart);
    $('#map-mapbox').on('click', showChart);




// Initially, no feature has experienced a click.
var features = {};
var i;
for (i=1; i <= 76; i++) {
    features[i] = false;
}
console.log(features);

$.each(features, function(key, value) {
    console.log(key, value);
});






// When user moves mouse over map,
// indicate symbols are clickable,
// change cursor style to 'pointer'
// else 'crosshair'.
map.on('mousemove', function (e) {
    var features = map.queryRenderedFeatures(e.point, { layers: ['bldgs'] });
    map.getCanvas().style.cursor = (features.length) ? 'pointer' : 'crosshair';
});

function hideInfo(feature) {
    $('.jumbotron').slideUp(1000);
}

$('#details-close').on('click', hideInfo);

function showInfo(feature) {
    $('.jumbotron').slideDown(500);
    $('#bldg-name').html(feature.properties.building_name);
    $('#bldg-info').html("Rank: " + feature.properties.rank + " at " + feature.properties.height_ft + " feet tall!" + feature.properties.use).append("another line here");
    $('#bldg-details').data('feature', feature.properties.bldg_id);
}

// // Uses the #bldg_details button to post bldg_id and route to new url.
// function showBldgDetails(evt) {
//     $.post('/bldg', {'bldg_id': feature.properties.bldg_id});
// }

// $('#bldg_details').on('click', showBldgDetails);



map.on('click', function (e) {
    // x, y coordinates of the mousemove event relative to top-left corner of map
    // e.lngLat is the longitude, latitude geographical position of the event
    console.log(e.point);
    console.log(e.lngLat);
});



// // Turf.js create circle buffer.
// var center = {
//   "type": "Feature",
//   "properties": {
//     "marker-color": "#0f0"
//   },
//   "geometry": {
//     "type": "Point",
//     "coordinates": [e.lngLat.lng, e.lngLat.lat]
//   }
// };

// console.log(center);

// var radius = 5;
// var steps = 10;
// var units = 'kilometers';

// var circle = turf.circle(center, radius, steps, units);

// var result = {
//   "type": "FeatureCollection",
//   "features": [center, circle]
// };









// When a click event occurs near a feature, show feature information.
map.on('click', function (e) {
    // e.point is where on the map canvas user clicks: x and y coordinates.
    var features = map.queryRenderedFeatures(e.point, { layers: ['bldgs'] });
    if (!features.length) {
        return;
    }

    var feature = features[0];
    console.log(feature.properties.bldg_id);
    showInfo(feature);

    // Defines how clicking around the map re-positions the map.
    map.flyTo({center: features[0].geometry.coordinates, zoom: zoom+2.5, speed: 0.4, curve: 1});




    // // Displays Mapbox GL popup with bldg rank data.
    // var popup = new mapboxgl.Popup()
    //     .setLngLat(map.unproject(e.point))
    //     .setHTML(feature.properties.rank)
    //     .addTo(map);

});
