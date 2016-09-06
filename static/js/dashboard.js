"use strict";


// $( document ).ready(function);

$('#search-table').hide();



$('.carte-blanche .btn').on('click', function (e) {
    $('#create').scrollTop(this.hash);
});


function populateTable (result) {
    $('#search-table').show();
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



function showPhotos (result) {
    console.log(result);
}




function submitBldg (e) {
    e.preventDefault();
    var number = $('#data-bldg-id').data();
    var url = '/create_card.json?bldg_id=' + number.bldg;
    console.log(number);
    console.log(url);
    $.get(url, showPhotos);
    $('#data-card-id').attr('data-card', result.card_id);
}

$('#create-card').on('submit', submitBldg);

function submitCard (e) {
    e.preventDefault();
    var number = $('#data-card-id').data();
    var url = '/save_card.json?card_id=' + number.card;
    console.log(number);
    console.log(url);
    $.get(url, showPhotos);
}

$('#save-card').on('submit', submitCard);

