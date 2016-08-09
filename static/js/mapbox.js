// Mapbox JS


mapboxgl.accessToken = 'pk.eyJ1IjoidGRpZWRlIiwiYSI6ImNpcXNpOTcwOTAyeGVmb25uYmxjN3VwaTQifQ.xcvPMOnJsUR4jSvIYwgoIQ';

var map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/light-v9',
    center: [-122.43, 37.75],
    zoom: 10.75,
});

var nav = new mapboxgl.Navigation({position: 'top-left'});
map.addControl(nav);

var marker = new mapboxgl.Marker()
    .setLngLat([-70.5, -30.5])
    .addTo(map);
