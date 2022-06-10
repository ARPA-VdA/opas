$(document).ready(function() {
    var map = L.map('mapper_map').setView([45.737334, 7.320113], 15);
    var osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
    var osm = new L.TileLayer(osmUrl, {minZoom: 5, maxZoom: 18}).addTo(map);
    var marker = L.marker([45.729067, 7.310753]).addTo(map);
    marker.bindPopup("<b>Ecometer S.n.c.</b><br>via Garin 49 - Aosta").openPopup();
    $(".chosen-select").chosen({width: "99%!important"});
    $('#datepicker').datepicker({
        language: 'it',
        keyboardNavigation: false,
        forceParse: false,
        autoclose: true
    });
});
