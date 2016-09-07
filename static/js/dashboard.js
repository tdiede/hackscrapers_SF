"use strict";


// $( document ).ready(function);

$('#search-table').hide();
$('#find-photo').hide();
$('#new-card').hide();
$('#new-card-phront').hide();
$('#create-card').hide();
$('#comment-card').hide();
$('#save-card').hide();

$('.bldg-properties').hide();

// $('#collect-card').on('click', function (e) {
//     console.log(this);
//     $('#create').scrollTop(this.hash);
// });

function populateTable (result) {
    $('#search-table').show();
    $('#find-photo').show();
    $('#rank').html(result.rank);
    $('#name').html(result.building_name);
    $('#year').html(result.completed_yr);
    $('#status').html(result.status);
    $('#floors').html(result.floors);
    $('#feet').html(result.height_ft);
    $('#meters').html(result.height_m);
    $('#material').html(result.material);
    $('#use').html(result.use);
    $('#data-bldg-id').attr('data-bldg', result.bldg_id);
}

function submitData (e) {
    e.preventDefault();
    var searchTerms = $('#search-terms').val();
    if (searchTerms === '') {
        alert('You seem to be missing something!');
    } else {
        var url = '/search_bldg.json?building=' + searchTerms;
        console.log(searchTerms);
        console.log(url);
        $.get(url, populateTable);
    }
}

$('#search-bldg').on('submit', submitData);

function showPhoto (result) {
    console.log(result);
    $('#new-card-phront').show();
    $('#create-card').show();
    if (result.properties.photo.url_s === null || result.properties.photo.url_s === undefined) {
        $('#bldg-img').css({'background-image': 'url()'});
        $('#photo-suggest').html("No photo found. Maybe you should go snap it!");
        $('.photo-properties').hide();
    } else {
        $('#bldg-img').css({'background-image': 'url(' + result.properties.photo.url_s + ')', 'background-size': 'cover'});
        $('#photo-suggest').html('');
        $('.photo-properties').show();
        $('#photo-title').html(result.properties.photo.photo_title);
        $('#photo-ownername').html(result.properties.photo.ownername);
        $('#photo-descript').html(result.properties.photo.descript);
    }
}

function submitBldg (e) {
    e.preventDefault();
    var number = $('#data-bldg-id').data();
    var url = '/flickr_filter.json?bldg_id=' + number.bldg;
    console.log(number);
    console.log(url);
    $.get(url, showPhoto);
    // $('#data-card-id').attr('data-card', result.card_id);
}

$('#find-photo').on('submit', submitBldg);




function previewCard (result) {
    console.log(result);
    $('#new-card').show();
    $('#save-card').show();
    $('.bldg-properties').show();
    $('#bldg-name').html(result.building.properties.building_name);
    $('#bldg-info').html("<br> Rank: " + result.building.properties.rank + " in SF." +
                         "<br> Height: " + result.building.properties.height_ft + " ft tall!" +
                         "<br> Material: " + result.building.properties.material + " construction." +
                         "<br> Use: " + result.building.properties.use + " use.").append();
}


function submitCard (e) {
    e.preventDefault();
    var number = $('#data-bldg-id').data();
    var url = '/create_card.json?bldg_id=' + number.bldg;
    console.log(number);
    console.log(url);
    $.get(url, previewCard);
    // $('#data-card-id').attr('data-card', result.card_id);
}

$('#create-card').on('submit', submitCard);





function submitSave (e) {
    e.preventDefault();
    var number = $('#data-card-id').data();
    var url = '/save_card.json?card_id=' + number.card;
    console.log(number);
    console.log(url);
    $.get(url, showPhoto);
}

$('#save-card').on('submit', submitSave);

