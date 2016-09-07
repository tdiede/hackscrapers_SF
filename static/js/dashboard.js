"use strict";


// $( document ).ready(function);

$('#search-table').hide();
$('#create-form').hide();
$('#new-card').hide();

$('.carte-blanche .btn').on('click', function (e) {
    $('#create').scrollTop(this.hash);
});


function populateTable (result) {
    $('#search-table').show();
    $('#create-form').show();
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
    var url = '/search_bldg.json?building=' + searchTerms;
    console.log(searchTerms);
    console.log(url);
    $.get(url, populateTable);
}

$('#search-bldg').on('submit', submitData);







function showPhoto (result) {
    console.log(result);
    $('#new-card').show();
    if (result.card.card_img === null) {
        $('#bldg-img').css({'background-image': 'url()'});
        $('#photo-suggest').html("No photo found. Maybe you should go snap it!");
        $('.photo-properties').hide();
    } else {
        $('#bldg-img').css({'background-image': 'url(' + result.card.card_img + ')', 'background-size': 'cover'});
        $('#photo-suggest').html('');
        $('.photo-properties').show();
        $('#photo-title').html(result.metadata.photo_title);
        $('#photo-ownername').html(result.metadata.ownername);
        $('#photo-descript').html(result.metadata.descript);
    }
}

function submitBldg (e) {
    e.preventDefault();
    var number = $('#data-bldg-id').data();
    var url = '/create_card.json?bldg_id=' + number.bldg;
    console.log(number);
    console.log(url);
    $.get(url, showPhoto);
    // $('#data-card-id').attr('data-card', result.card_id);
}

$('#create-card').on('submit', submitBldg);






function submitCard (e) {
    e.preventDefault();
    var number = $('#data-card-id').data();
    var url = '/save_card.json?card_id=' + number.card;
    console.log(number);
    console.log(url);
    $.get(url, showPhoto);
}

$('#save-card').on('submit', submitCard);

