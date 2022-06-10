$(document).ready(function() {
    $('.tooltip-table').tooltip({
        selector: "[data-toggle=tooltip]",
        container: "body"
    });
    $( ".ibox" ).on( "click", ".btn-ping", function(e) {
        var stid = $(this).parent().prev().text();
        console.log(stid);
        var jqxhr = $.ajax({
            url: 'ping_station',
            type: "post",
            dataType: "json",
            data: { stid: stid },
        })
        .done(function(result) {
            console.dir( result );
        })
        .fail(function(xhr, err) {
            return null;
        });
        e.preventDefault();
    });
});
