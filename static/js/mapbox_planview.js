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

});


// When user moves mouse over map,
// indicate symbols are clickable,
// change cursor style to 'pointer'
// else 'crosshair'.
map.on('mousemove', function (e) {
    var features = map.queryRenderedFeatures(e.point, { layers: ['bldgs'] });
    map.getCanvas().style.cursor = (features.length) ? 'pointer' : 'crosshair';
});


function hideInfo(prevFeature) {
    $('.jumbotron').slideToggle(1000);
}

function showInfo(feature) {
    $('.jumbotron').slideToggle(500);
    $('#bldg_name').html(feature.properties.building_name);
    $('#bldg_info').html("Rank: " + feature.properties.rank + " at " + feature.properties.height_ft + " feet tall!" + feature.properties.use);




var options = { responsive: true };

var ctx_bar = $("#barChart").get(0).getContext("2d");




var data = {
    labels: ["average", feature.properties.building_name],
    datasets: [
        {
            label: 'label',
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
            ],
            borderWidth: 1,
            data: [76, feature.properties.height_ft],
        }
    ]
};





// $.get("/bldg_barchart.json",

    var myBarChart = new Chart(ctx_bar, {type: 'bar',
                                         data: data,
                                         options: options});
    $('#barLegend').html(myBarChart.generateLegend());



}

// When a click event occurs near a feature,
// show feature information.
map.on('click', function (e) {
    var features = map.queryRenderedFeatures(e.point, { layers: ['bldgs'] });
    if (!features.length) {
        return;
    }

    var prevFeature = null;
    var feature = features[0];
    if (feature === prevFeature) {
        hideInfo(prevFeature);
    } else if (feature !== prevFeature) {
        showInfo(feature);
    }
    prevFeature = feature;
    
    map.flyTo({center: features[0].geometry.coordinates, zoom: zoom+2.5, speed: 0.4, curve: 1});

    // var popup = new mapboxgl.Popup()
    //     .setLngLat(map.unproject(e.point))
    //     .setHTML("Rank: " + feature.properties.rank + " at " + feature.properties.height_ft + " feet tall!")
    //     .addTo(map);

});

