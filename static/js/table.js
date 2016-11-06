"use strict";


// $('#current').hide();

function showBuildingDetails(result) {
    // $('#current').slideToggle(500);
    console.log(result);
    $('#bldg-details').html(result.building_name + " " + result.material);

}


function showBuildingPhoto(result) {
    console.log(result);
    $('#bldg-img').attr('src', result.url_s);    
}




function getBuildingDetails(e) {
    var bldgID = $(this).data('bldg');
    var url = '/bldg_feature.json/'+bldgID;
    var photo = '/bldg_flickr.json/'+bldgID;
    console.log(bldgID);
    console.log(url);
    $.get(url, showBuildingDetails);
    $.get(photo, showBuildingPhoto);
}

$('.bldg-row').on('click', getBuildingDetails);



function hideInfo(feature) {
    $('#current').slideUp(1000);
}

$('#details-close').on('click', hideInfo);
