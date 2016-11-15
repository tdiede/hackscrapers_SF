"use strict";



mapboxgl.accessToken = 'pk.eyJ1IjoidGRpZWRlIiwiYSI6ImNpcXNpOTcwOTAyeGVmb25uYmxjN3VwaTQifQ.xcvPMOnJsUR4jSvIYwgoIQ';

// Setting initial coordinates, zoom, pitch, bearing.
var coord = [-122.4064, 37.7833];
var zoom = 13.85;
var pitch = 0;
var bearing = 0;

// Set bounds to San Francisco.
var bounds = [
    [-122.1, 37], // Southwest coordinates
    [-122.6, 38]  // Northeast coordinates
];

var lightStyle = "mapbox://styles/tdiede/civfpcrs8001b2jotfflpgwqn";
// map.setStyle(lightStyle);  // if want to change at future point.

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
        "delay": 0,
        },
    "layers": [{}],
    };

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

var canvas = map.getCanvasContainer();

var nav = new mapboxgl.Navigation({position: 'bottom-left'});
map.addControl(nav);

map.scrollZoom.disable();  // disable map zoom when using scroll.
map.boxZoom.enable();  // enable box zoom, using shift key.









// BLDGS GEOJSON DATA //

var bldgsGEOJSON = {};

// Pulls in bldgs geojson data.
var json = '/bldgs.geojson';
var response = $.getJSON(json);

function makeBldgs() {
    bldgsGEOJSON = response.responseJSON;
}

$(document).ajaxSuccess(function(e) {
    makeBldgs();
});


// EVERYTHING DONE ON LOAD //

map.on('load', function () {

    // Add data source and layer for buildings.
    map.addSource('bldgs', {
        'type': 'geojson',
        'data': bldgsGEOJSON,
    });

    map.addLayer({
        'id': 'bldgs',
        'type': 'symbol',
        'source': 'bldgs',
        'layout': {
            // "icon-image": "{icon}-15",
            'text-field': '{building_name}',
            'text-font': ['Open Sans Regular', 'Arial Unicode MS Regular'],
            'text-size': 14,
            'text-offset': [1.5, 1.1],
            'text-rotate': 0,
            'text-anchor': 'top-left',
            'text-padding': 3,
        },
        'paint': {
            // "icon-color": "red",
            // "icon-opacity": 0.3,
            'text-color': '#0063DC',
            'text-opacity': 1.0,
        },
    });

    // generate markers for each bldg feature
    bldgsGEOJSON.features.forEach(function(marker) {
        // create a DOM element for the marker
        var el = document.createElement('div');
        el.className = 'marker';
        el.style.backgroundImage = 'url(/static/svg/building-15.png)';
        el.style.width = marker.properties.floors / 2 + 'px';
        el.style.height = marker.properties.floors / 2 + 'px';

        el.addEventListener('click', function() {
            console.log(marker.properties.bldg_id);
            console.log(marker.properties);
            getBuilding(marker);

            var bldgID = marker.properties.bldg_id;
            colorTableRow(bldgID);
        });

        // add marker to map
        new mapboxgl.Marker(el, {offset: [-marker.properties.floors / 4, -marker.properties.floors / 4] })
            .setLngLat(marker.geometry.coordinates)
            .addTo(map);
    });

});




// ON MOVE AND ON CLICK EVENTS FOR MAP //

var prevBuilding;
var currentPhotoURL;

map.on('mousemove', function (e) {
    var bldgFeatures = map.queryRenderedFeatures(e.point, { layers: ['bldgs'] });
    map.getCanvas().style.cursor = (bldgFeatures.length) ? 'pointer' : 'crosshair';
});

map.on('click', function (e) {
    // e.point is where on the map canvas user clicks: x and y coordinates.
    var markers = map.queryRenderedFeatures(e.point, { layers: ['bldgs'] });
    if (!markers.length) {
        return;
    }

    var marker = markers[0];
    console.log(marker.properties.bldg_id);
    console.log(marker.properties);

    getBuilding(marker);

    var bldgID = marker.properties.bldg_id;
    colorTableRow(bldgID);

    // Defines how clicking around the map re-positions the map.
    map.flyTo({center: markers[0].geometry.coordinates, zoom: zoom+2.5, speed: 0.4, curve: 1});
});






// From clicking bldg markers.

function getBuilding(marker) {
    var bldgID = marker.properties.bldg_id;
    var route = '/bldg_flickr.json/'+bldgID;

    $('#bldg-name').html(marker.properties.building_name);
    $('#bldg-rank').html(marker.properties.rank);
    $('#bldg-height-ft').html(marker.properties.height_ft);
    $('#bldg-floors').html(marker.properties.floors);
    $('#bldg-status').html(marker.properties.status);
    $('#bldg-year-completed').html(marker.properties.completed_yr);
    $('#bldg-material').html(marker.properties.material);
    $('#bldg-use').html(marker.properties.use);

    $('#data-bldg-id').data('bldg', marker.properties.bldg_id);

    $.get(route, displayPhoto);
}

function displayPhoto (result) {
    console.log(result);
    $('#photo-flickr').show();
    $('#table-half').css('height', '400px');
    $('tbody').css('height', '400px');
    $('#table-buildings').css('border-bottom', 'none');
    if (result.not_found === true) {
        // NO PHOTO FOUND
        $('.photo-properties').hide();
        currentPhotoURL = '';
        // $('#bldg-img').attr('src', '');
        $('#bldg-img-container').css('background-image', 'url()');
        $('a#img-url').attr('href', '');
        $('#photo-suggest').html(result.suggestion);
        $('#collect-card').data('url', '');
    } else {
        // PHOTO FOUND
        $('.photo-properties').show();
        currentPhotoURL = result.url_s;
        // $('#bldg-img').attr('src', currentPhotoURL);
        $('#bldg-img-container').css('background-image', 'url(' + currentPhotoURL + ')');
        $('a#img-url').attr('href', currentPhotoURL);
        $('#photo-suggest').html('');
        $('#collect-card').data('url', currentPhotoURL);
        
        $('#photo-title').html(result.photo_title);
        $('#photo-ownername').html(result.ownername);
        $('#photo-descript').html(result.photo_description);
    }
}




// TABLE FUNCTIONS

function colorTableRow(bldgID) {

    if (bldgID !== prevBuilding) {

        // Highlight the row visually.
        $('tr').css('font-weight', 'initial');
        $('tr[data-bldg='+prevBuilding+']').removeClass('pink-text');
        $('tr[data-bldg='+bldgID+']').addClass('pink-text');
        $('tr[data-bldg='+bldgID+'] > td.rank').css('font-weight', 'bold');

        // Bring this row to the top.
        var target = $('tr[data-bldg='+bldgID+']');
        if ( target.length ) {
            event.preventDefault();
            target.get(0).scrollIntoView();
        }

    }

    prevBuilding = bldgID;
}

$(document).ready(function() {

    $('.bldg-row').on('click', function(e) {
        var bldgID = $(this).data('bldg');
        var route = '/bldg_flickr.json/'+bldgID;

        $.get(route, displayPhoto);

        colorTableRow(bldgID);

        $('#bldg-name').html($(this).data('name'));
        $('#bldg-rank').html($(this).data('rank'));
        $('#bldg-height-ft').html($(this).data('feet'));
        $('#bldg-floors').html($(this).data('floors'));
        $('#bldg-status').html($(this).data('status'));
        $('#bldg-year-completed').html($(this).data('year'));
        $('#bldg-material').html($(this).data('material'));
        $('#bldg-use').html($(this).data('use'));

    });

});












// PHOTO INTERACTIONS

$(document).ready(function() {

    $('.fa-times').on('click', function(e) {
        $('#photo-flickr').hide();
        $('#table-half').css('height', '800px');
        $('tbody').css('height', '800px');
        $('#table-buildings').css('border-bottom', '6px solid #FC329B');
    });

    $('.fa-expand').on('click', function(e) {
    });

    $('.fa-bookmark').on('click', function(e) {
    });

    $('.fa-heart').on('click', function(e) {
        // // Saves card to collection.
        // e.preventDefault();
        // var number = $('#collect-card').data('bldg');
        // var url = '/save_card.json?bldg_id=' + number + '&url=' + currentPhotoURL;
        // $.get(url, function (result) {
        //     alert("You now have added a card to your collection!");
        //     $.get('/dashboard');
        // });
    });

    $('.fa-comment').on('click', function(e) {
    });

    $('.fa-camera').on('click', function(e) {
    });

    // $('[data-toggle="tooltip"]').tooltip();
    // $('[data-toggle="popover"]').popover(
    //     {trigger: 'hover'});

});












// $('a[href^="#"]').on('click', function(e) {
//     var target = $(this.getAttribute('href'));
//     if ( target.length ) {
//         event.preventDefault();
//         $('html, body').stop().animate({
//             scrollTop: target.offset().top
//         }, 1000);
//     }
// });

// target.height()























// $('#bar-chart').hide();

// // BarChart from chart.js to display bldg height comparison.
// function createChart (bldgData) {
//     var options = { responsive: true, maintainAspectRatio: false, events: [],
//                     scales: {
//                         xAxes: [{
//                             barThickness: 20,
//                             display: true,
//                             gridLines: {
//                                 zeroLineWidth: 0,
//                                 zeroLineColor: 'rgba(0, 0, 0, 0)'
//                                 },
//                             ticks: {
//                                 display: false
//                                 }
//                             }],
//                         yAxes: [{
//                             gridLines: {
//                                 zeroLineWidth: 2,
//                                 zeroLineColor: 'rgba(0, 0, 0, 0.25)'
//                             },
//                             ticks: {
//                                 max: 1100,
//                                 min: 0,
//                                 stepSize: 100
//                                 }
//                             }]
//                         },
//                     title: {
//                         display: true,
//                         position: 'bottom',
//                         text: 'BUILDING HEIGHT (FT)',
//                         fontStyle: 'normal'
//                         },
//                     tooltips: {
//                         enabled: true,
//                         backgroundColor: 'rgba(0, 0, 0, 0.25)',
//                         caretSize: 0,
//                         cornerRadius: 0
//                         },
//                     legend: {
//                         display: true,
//                         mode: 'label',
//                         position: 'top',
//                         labels: {
//                             boxWidth: 0
//                             }
//                         }
//                     };
//     var ctx_bar = $("#barChart").get(0).getContext("2d");
//     var myBarChart = new Chart(ctx_bar, {type: 'bar',
//                                          data: bldgData,
//                                          options: options});
//     // $('#barLegend').html(myBarChart.generateLegend());
// }

// function showChart (marker) {
//     $('#bar-chart').show();
//     var bldg_id = marker.properties.bldg_id;
//     $.get('/bldg_barchart.json/'+bldg_id, createChart);
// }

// // $('#bldg_details').on('click', showChart);










// GENERIC POINT GEOJSON FOR //
// SEARCH RADIUS TURF.JS FEATURE //


// Checks if this flag is active, moves the point on mousemove.
var isDragging;

// Checks if this flag is active, listens for a mousedown event.
var isCursorOverPoint;

// Sets initial radius of generic point.
var radius = 20;

// Create a generic geojson.
var geojson = {
        'type': 'FeatureCollection',
        'features': [{
            'type': 'Feature',
            'properties': {},
            'geometry': {
                'type': 'Point',
                'coordinates': [-122.40, 37.77],
                }
            }]
        };


// Search radius.
function updateRadius (e) {
    e.preventDefault();
    radius = $('#radius').val();
    console.log(radius);
    map.setPaintProperty('point', 'circle-radius', Number(radius));
}

$('#update-radius').on('click', updateRadius);


// EVERYTHING DONE ON LOAD //

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
            'circle-color': '#eea7be',
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

});

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


var srcFeatures;

setTimeout(function() {
    srcFeatures = map.querySourceFeatures("bldgs", {});
    console.log(srcFeatures);
}, 1000);

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







