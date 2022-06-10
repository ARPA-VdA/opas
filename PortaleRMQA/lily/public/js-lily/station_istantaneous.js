$(document).ready(function() {
    $('.widg-little').tooltip({
        selector: "[data-toggle=tooltip]",
        container: "body"
    });
    $('#data-frame').hide();
    $( "a.to-data" ).on( "click", function() {
        var nameStat = $(this).parent().parent().find( "h2.font-bold" ).text();
        console.log('click nameStat: '+nameStat);
        var ip = $(this).data("ip");
        getIstantaneousData('station_istantaneous_get_camp', ip, nameStat);
    });
    $( "a.to-lgnt" ).on( "click", function() {
        var nameStat = $(this).parent().parent().find( "h2.font-bold" ).text();
        console.log('click nameStat: '+nameStat);
        var ip = $(this).data("ip");
        getIstantaneousData('station_istantaneous_get_lognet', ip, nameStat);
    });
    function getIstantaneousData(url, ip, nameStat) {
        console.log('getIstantaneousData, ip: '+ip);
        $("#table-data > tbody").empty();
        var jqxhr = $.ajax({
            url: url,
            type: "post",
            data: {
                ip:ip
            },
        })
        .done(function(json) {
            console.dir(json);
            $('#default-text').hide();
            $('#data-frame').show();
            $('#data-frame .stat-name').text(nameStat);
            var rows = jQuery.parseJSON(json.rows);
            $.each(rows, function(index, value) {
                console.log(rows['label'] + ' - ' + rows['label']);
                $( "#table-data tbody" ).append( "<tr>" +
                "<td>" + value['label'] + "</td>" +
                "<td>" + value['value'] + "</td>" +
                "</tr>" );
            });
        })
        .fail(function(xhr, err) {
            toastr.error(err, 'Errore');
            return null;
        });
    }
});
