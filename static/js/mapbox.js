"use strict";

mapboxgl.accessToken = 'pk.eyJ1IjoidGRpZWRlIiwiYSI6ImNpcXNpOTcwOTAyeGVmb25uYmxjN3VwaTQifQ.xcvPMOnJsUR4jSvIYwgoIQ';

// Checks if this flag is active, moves the point on mousemove.
var isDragging;
// Checks if this flag is active, listens for a mousedown event.
var isCursorOverPoint;

var srcFeatures = [];

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
var coord = [-122.43805537700867, 37.771823592326754];
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

var canvas = map.getCanvasContainer();

// Pulls in bldgs geojson data.
var bldgs = '/bldgs.geojson';

// Sets initial radius of generic point.
var radius = 10;

// Create a generic geojson.
var geojson = {
        'type': 'FeatureCollection',
        'features': [{
            'type': 'Feature',
            'properties': {},
            'geometry': {
                'type': 'Point',
                'coordinates': [-122.50882387161255, 37.80990262140361],
                }
            }]
        };

function mouseDown() {
    if (!isCursorOverPoint) return;
    isDragging = true;

    // Set a cursor indicator.
    canvas.style.cursor = 'grab';

    // Mouse events.
    map.on('mousemove', onMove);
    map.on('mouseup', onUp);
}

function onMove(e) {
    if (!isDragging) return;
    var lngLat = e.lngLat;

    // Set a cursor indicator for dragging.
    canvas.style.cursor = 'grabbing';

    // Update the Point feature in 'geojson'.
    geojson.features[0].geometry.coordinates = [lngLat.lng, lngLat.lat];
    map.getSource('point').setData(geojson);

    // x, y coordinates of the mousemove event relative to top-left corner of map
    // e.lngLat is the longitude, latitude geographical position of the event
    console.log(e.lngLat);

    checkInside(lngLat);

}

function checkInside(lngLat) {

var center = geojson.features[0].geometry.coordinates;  // lngLat
var radius_mi = 0.5;
var steps = 10;
var units = 'miles';

// Turf.js creates circle around event center point.
var circle = turf.circle(center, radius_mi, steps, units);
console.log(circle);

// srcFeatures
$.each(srcFeatures, function (k, v) {
    var pt = {"type": "Feature",
              "properties": {"marker-color": "blue", "marker-size": "large"},
              "geometry": {"type": "Point",
                           "coordinates": v.geometry.coordinates}};

    var isInside = turf.inside(pt, circle);
    // console.log(isInside);
    if (isInside === true) {
        // console.log(k);
        // console.log(v);
        console.log(this);
        console.dir(this);
        this.properties['marker-color'] = '#000000';

        map.setPaintProperty('point', 'circle-color', '#000000');
        }
});
}

function onUp(e) {
    if (!isDragging) return;
    canvas.style.cursor = '';
    isDragging = false;
}

map.on('load', function () {

    map.addSource('point', {
        'type': 'geojson',
        'data': geojson,
        });

    map.addLayer({
        'id': 'point',
        'type': 'circle',
        'source': 'point',
        'paint': {
            'circle-radius': radius,
            'circle-color': '#98a7be',
            'circle-opacity': 0.5,
            },
        });

    // If feature found on map movement, permit mousedown events.
    map.on('mousemove', function(e) {
        var features = map.queryRenderedFeatures(e.point, { layers: ['point'] });
        console.log(features);

            // Change point and cursor style, enable other mouse events.
            if (features.length) {
                map.setPaintProperty('point', 'circle-color', '#3bb2d0');
                canvas.style.cursor = 'move';
                isCursorOverPoint = true;
                map.dragPan.disable();
            } else {
                map.setPaintProperty('point', 'circle-color', '#98a7be');
                canvas.style.cursor = '';
                isCursorOverPoint = false;
                map.dragPan.enable();
            }
    });

    // Set 'true' to dispatch the event before other functions call it.
    // Disable default map dragging.
    map.on('mousedown', mouseDown, true);


    // Add data source and layer for buildings.
    var srcBldgs = map.addSource('bldgs', {
        'type': 'geojson',
        'data': bldgs,
    });

    map.on("click", function(e) { console.log("aha!");});

    var layerBldgs = map.addLayer({
        'id': 'bldgs',
        'type': 'symbol',
        'source': 'bldgs',
        'layout': {
            'icon-image': 'marker-15',
            'icon-size': 1,
            'icon-padding': 1,
            'text-field': '{building_name}',
            'text-font': ['Open Sans Regular', 'Arial Unicode MS Regular'],
            'text-size': 12,
            'text-offset': [0.5, 0.1],
            'text-anchor': 'top-left'
        },
    });

    setTimeout(function() {
        srcFeatures = map.querySourceFeatures("bldgs", {});
        console.log(srcFeatures);
    }, 1000);

});




// Search radius.
function updateRadius (e) {
    e.preventDefault();
    radius = $('#radius').val();
    console.log(radius);
    map.setPaintProperty('point', 'circle-radius', Number(radius));
}

$('#update-radius').on('click', updateRadius);



// Treating bldg markers.
// Displaying more information on click.

var currentURL = '';

function showPhoto (result) {
    console.log(result);
    if (result.properties.photo === null) {
        $('#bldg-img').attr('src', '');
        $('#photo-suggest').html("No photo found. Maybe you should go snap it!");
        $('.photo-properties').hide();
    } else {
        $('#bldg-img').attr('src', result.properties.photo.url_s);
        currentURL = result.properties.photo.url_s;
        $('#photo-suggest').html('');
        $('.photo-properties').show();
        $('#photo-title').html(result.properties.photo.photo_title);
        $('#photo-ownername').html(result.properties.photo.ownername);
        $('#photo-descript').html(result.properties.photo.descript);
    }
}

function getPhoto (marker) {
    var bldgId = marker.properties.bldg_id;
    var url = '/flickr_filter.json?bldg_id=' + bldgId;
    console.log(bldgId);
    console.log(url);
    $.get(url, showPhoto);
}

function hideInfo (marker) {
    $('.jumbotron').slideUp(1000);
}

$('#details-close').on('click', hideInfo);

function showInfo (marker) {
    $('.jumbotron').slideDown(500);
    $('#bldg-name').html(marker.properties.building_name);
    $('#bldg-info').html("<br> Rank: " + marker.properties.rank + " in SF." +
                         "<br> Height: " + marker.properties.height_ft + " ft tall!" +
                         "<br> Material: " + marker.properties.material + " construction." +
                         "<br> Use: " + marker.properties.use + " use.").append();
    $('#data-bldg-id').data('bldg', marker.properties.bldg_id);
}

// Saves card to collection.
function submitSave (e) {
    e.preventDefault();
    var number = $('#data-bldg-id').data('bldg');
    var url = '/save_card.json?bldg_id=' + number + '&url=' + currentURL;
    $.get(url, function (result) {
        alert("You now have added a card to your collection!");
        $.get('/dashboard');
    });
}

$('#save-card').on('submit', submitSave);






// When user moves mouse over map,
// indicate symbols are clickable,
// change cursor style to 'pointer'
// else 'crosshair'.
map.on('mousemove', function (e) {
    var features = map.queryRenderedFeatures(e.point, { layers: ['bldgs'] });
    map.getCanvas().style.cursor = (features.length) ? 'pointer' : 'crosshair';
});

// // When a click event occurs near a feature, show feature information.
map.on('click', function (e) {
    // e.point is where on the map canvas user clicks: x and y coordinates.
    var markers = map.queryRenderedFeatures(e.point, { layers: ['bldgs'] });
    if (!markers.length) {
        return;
    }

    var marker = markers[0];
    console.log(marker.properties.bldg_id);

    getPhoto(marker);
    showInfo(marker);

    showChart(marker);

    // Defines how clicking around the map re-positions the map.
    map.flyTo({center: markers[0].geometry.coordinates, zoom: zoom+2.5, speed: 0.4, curve: 1});
});













$('#bar-chart').hide();

// BarChart from chart.js to display bldg height comparison.
function createChart (bldgData) {
    var options = { responsive: true, maintainAspectRatio: false, events: [],
                    scales: {
                        xAxes: [{
                            barThickness: 20,
                            display: true,
                            gridLines: {
                                zeroLineWidth: 0,
                                zeroLineColor: 'rgba(0, 0, 0, 0)'
                                },
                            ticks: {
                                display: false
                                }
                            }],
                        yAxes: [{
                            gridLines: {
                                zeroLineWidth: 2,
                                zeroLineColor: 'rgba(0, 0, 0, 0.25)'
                            },
                            ticks: {
                                max: 1100,
                                min: 0,
                                stepSize: 100
                                }
                            }]
                        },
                    title: {
                        display: true,
                        position: 'bottom',
                        text: 'BUILDING HEIGHT (FT)',
                        fontStyle: 'normal'
                        },
                    tooltips: {
                        enabled: true,
                        backgroundColor: 'rgba(0, 0, 0, 0.25)',
                        caretSize: 0,
                        cornerRadius: 0
                        },
                    legend: {
                        display: true,
                        mode: 'label',
                        position: 'top',
                        labels: {
                            boxWidth: 0
                            }
                        }
                    };
    var ctx_bar = $("#barChart").get(0).getContext("2d");
    var myBarChart = new Chart(ctx_bar, {type: 'bar',
                                         data: bldgData,
                                         options: options});
    // $('#barLegend').html(myBarChart.generateLegend());
}

function showChart (marker) {
    $('#bar-chart').show();
    var bldg_id = marker.properties.bldg_id;
    $.get('/bldg_barchart.json/'+bldg_id, createChart);
}

// $('#bldg_details').on('click', showChart);