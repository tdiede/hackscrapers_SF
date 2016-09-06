

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













// // Initially, no feature has experienced a click.
// var features = {};
// var i;
// for (i=1; i <= 76; i++) {
//     features[i] = false;
// }
// console.log(features);







// // Uses the #bldg_details button to post bldg_id and route to new url.
// function showBldgDetails(evt) {
//     $.post('/bldg', {'bldg_id': feature.properties.bldg_id});
// }

// $('#bldg_details').on('click', showBldgDetails);








// var bufferLayer = turf.buffer(pt, 2, 'miles');
// var result = turf.featurecollection([bufferLayer, center]);







// // Displays Mapbox GL popup with bldg rank data.
// var popup = new mapboxgl.Popup()
//     .setLngLat(map.unproject(e.point))
//     .setHTML(feature.properties.rank)
//     .addTo(map);





