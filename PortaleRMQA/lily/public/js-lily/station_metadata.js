var coordX, coordY, details, map, marker;
var defCoordX, defCoordY;
var currStation;
$(document).ready(function() {
    $('#show-tab-5').hide();
    defCoordX = 45.741760;
    defCoordY = 7.354806;
    if (appLocation == 'torrazza') {
        $('#show-tab-5').show();
        defCoordX = 45.21989949292534;
        defCoordY = 7.965899012863076;
    }
    $('.show-stations').hide();
    $('#gallery-images .single-image-gallery').on('click', function(event) {
        event = event || window.event;
        var target = event.target || event.srcElement,
            link = target.src ? target.parentNode : target,
            options = {
                index: link,
                event: event,
                hidePageScrollbars: false
            },
            links = $('a.single-image-gallery');
        blueimp.Gallery(links, options);
    });
    $( "#show-stats" ).on( "click", function() {
        var id = $("#select-params").val();
        console.log(id);
        currStation = null;
        var jqxhr = $.ajax({
            url: 'metadata_get_station',
            type: "post",
            dataType: "json",
            data: { id: id },
        })
        .done(function(result) {
            if (result && result.res == 'OK')
                clearMetadata();
                currStation = result;
                showMetadata(currStation);
                showMetadataWallSvg(currStation);
            $('.show-stations').show();
        })
        .fail(function(xhr, err) {
            return null;
        });
    });
    $( ".nav-tabs li.themap" ).on( "click", function() {
        refreshMap();
    });
    $( ".nav-tabs li.thewall" ).on( "click", function() {
        setTimeout(function(){ showMetadataWallSvg(currStation); }, 50);
    });
    console.log('init map');
    var latlngAosta = new L.LatLng(45.737334, 7.320113);
    map = L.map('station_map').setView(latlngAosta, 14);
    var osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
    var osm = new L.TileLayer(osmUrl, {minZoom: 9, maxZoom: 18}).addTo(map);
});
function refreshMap() {
    setTimeout(function(){
        console.log('refreshMap');
        map.invalidateSize();
        map.panTo(new L.LatLng(coordX, coordY));
    }, 50);
}
function clearMetadata() {
    $('#map-default').hide();
    console.log( 'clearMetadata' );
    $('.empty_txt').html('');
    $("#container-p-meteo").hide();
    $("#container-p-analis").hide();
    $("#container-p-chem").hide();
    $("#param-meteo").empty();
    $("#param-analis").empty();
    $("#param-chem").empty();
    $("#stat-media-pdf").empty();
    $("#stat-media-images").empty();
    coordX = "";
    coordY = "";
    details = "";
    if (map != undefined){
        if (marker != undefined)
            map.removeLayer(marker)
    }
}
function showMetadataWallSvg(currStation) {
    console.log('showMetadataWallSvg');
    var svg = document.getElementById('svg-wall').contentDocument;
    if (currStation) {
        $("#testa-pozzo", svg).text(currStation.data.wall_top);
        $("#livello-falda", svg).text(currStation.data.groundwater_level);
        $("#sonda-smtp", svg).text(currStation.data.probe_level);
        $("#quota-pompa", svg).text(currStation.data.pump_level);
        $("#fondo-pozzo", svg).text(currStation.data.wall_bottom);
    } else {
        $("#testa-pozzo", svg).text('--');
        $("#livello-falda", svg).text('--');
        $("#sonda-smtp", svg).text('--');
        $("#quota-pompa", svg).text('--');
        $("#fondo-pozzo", svg).text('--');
    }
}
function showMetadata( result ) {
    console.log( 'showMetadata' );
    console.dir( result );
    $('#map-default').hide();
    $('.stat_name').html(result.data.stazione);
    $('#stat_zone').html(result.data.zona);
    $('#stat_basin').html(result.data.bacino);
    $('#stat_place').html(result.data.localita);
    $('#stat_district').html(result.data.comune);
    $('#stat_province').html(result.data.provincia);
    $('#stat_region').html(result.data.regione);
    $('#stat_notes').html(result.data.note);
    $('#stat_type').html(result.data.tipo_stazione);
    $('#stat_network').html(result.data.tipo_rete);
    $('#stat_datestart').html(result.data.data_inizio);
    $('#stat_datend').html(result.data.data_fine);
    $('#stat_polling').html(result.data.b_active);
    $('#stat_id').html(result.data.st_id);
    $('#stat_ip').html(result.data.b_tcpip);
    $('#stat_altitude').html(result.data.altitudine);
    $('#stat_ED50nord').html(result.data.utm_nord_ed50);
    $('#stat_ED50est').html(result.data.utm_est_ed50);
    $('#stat_WGS84nord').html(result.data.utm_nord_wgs84);
    $('#stat_WGS84est').html(result.data.utm_est_wgs84);
    $('#stat_WGS84lat').html(result.data.lat_gradi_wgs84);
    $('#stat_WGS84lon').html(result.data.lon_gradi_wgs84);
    details = "<b>Stazione "+result.data.stazione+"</b><br>"+result.data.localita+" - "+result.data.comune;
    if(result.data.lat_gradi_wgs84 != null){
        coordX = result.data.lat_gradi_wgs84;
    }else{
        coordX = defCoordX;
        $('#map-default').show();
    }
    if(result.data.lon_gradi_wgs84 != null){
        coordY = result.data.lon_gradi_wgs84;
    }else{
        coordY = defCoordY;
        $('#map-default').show();
    }
    if (map != undefined){
        console.log('coordinate '+coordX+' - '+coordY);
        marker = L.marker([coordX, coordY]).addTo(map);
        marker.bindPopup(details);
        refreshMap();
    }
    if(result.meteo && result.meteo.length){
        $.each(result.meteo, function(key, value) {
            var ope = '<li>'+value.name+' ('+value.unit+')</li>';
            $( "#param-meteo" ).append( ope );
        });
        $("#container-p-meteo").show();
    }
    if(result.analis && result.analis.length){
        $.each(result.analis, function(key, value) {
            var ope = '<li>'+value.name+' ('+value.unit+')</li>';
            $( "#param-analis" ).append( ope );
        });
        $("#container-p-analis").show();
    }
    if(result.chem && result.chem.length){
        $.each(result.chem, function(key, value) {
            var ope = '<li>'+value.name+' ('+value.unit+')</li>';
            $( "#param-chem" ).append( ope );
        });
        $("#container-p-chem").show();
    }
    var stid = result.data.st_id;
    var src_img = result.picture;
    $('#stat_img').attr('src', src_img);
    var pdf_count = 0;
    var media_files = result.media;
    if (media_files.length > 0){
        var patt1 = /^.*\.png|\.jpg|\.jpeg|\.gif$/i;
        var patt2 = /^.*\.mp4|\.ogg|\.webm$/i;
        for ( var i = 0, l = media_files.length; i < l; i++ ) {
            var url = media_files[i];
            if ( patt1.test(url) ) {
                console.log('image: '+url)
                $( "#stat-media-images" ).append( "<a href="+url+" title='' class='single-image-gallery' data-gallery='stat-img'><img src="+url+"></a>" );
            } else {
                console.log('pdf: '+url)
                pdf_count ++;
                $( "#content-media-pdf" ).show();
                console.log(media_files[i]);
                var filename = media_files[i].match('.*\\/(.*)\\?v=\\d{10}')[1];
                $( "#stat-media-pdf" ).append( "<li><a href="+url+" target='_blank'><i class='fa fa-file-text text-danger'></i> "+filename+"</a></li>" );
            }
        }
    }
}
