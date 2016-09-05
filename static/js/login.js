"use strict";


// $( document ).ready(function);

$('.navbar').hide();

$('.login').hide();

$('#register').on("click", function(e) {
    $('.register').show();
    $('.login').hide();
});

$('#login').on("click", function(e) {
    $('.login').show();
    $('.register').hide();
});