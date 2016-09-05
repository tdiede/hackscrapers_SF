"use strict";


$('.carousel').hide();

function createBuildingDetails(result) {
    $('.carousel').slideToggle(500);
    console.log(result);
    $('#bldg-info').html(result.properties.building_name + " " + result.properties.material);
    $('#bldg-img').attr('src', result.photos.url_m);
    
}

function showBuildingDetails(e) {
    var bldg_id = $(this).data('bldg');
    $.get('/bldg/'+bldg_id, createBuildingDetails);
}

$('.bldg-name').on('click', showBuildingDetails);

function hideInfo(feature) {
    $('.carousel').slideUp(1000);
}

$('#details-close').on('click', hideInfo);



// $('thead')
//   .awesomeCursor('building', {
//     color: 'cyan',
//     size: 32,
//   });

// function sortField(evt) {
//     var field_id = $('#sort').data('field');
//     $.post('/sort_field' + '/' + field_id, );
// }

// $('#sort').on('click', sortField)