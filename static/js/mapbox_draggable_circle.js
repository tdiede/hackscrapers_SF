

var canvas = map.getCanvasContainer();

// Create a generic geojson.
var geojson = {
        'type': 'FeatureCollection',
        'features': [{
            'type': 'Feature',
            'properties': {},
            'geometry': {
                'type': 'Point',
                'coordinates': [-122.3887323943661, 37.79971622083343],
                }
            }]
        };

var radius = 200;

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
            'circle-color': '#3887be',
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
                map.setPaintProperty('point', 'circle-color', '#3887be');
                canvas.style.cursor = '';
                isCursorOverPoint = false;
                map.dragPan.enable();
            }
    });

    // Set 'true' to dispatch the event before other functions call it.
    // Disable default map dragging.
    map.on('mousedown', mouseDown, true);

});
