$(document).ready(function() {
    $('.dataTables-example').dataTable({
        responsive: {
            details: {
                display: $.fn.dataTable.Responsive.display.childRowImmediate,
                type: ''
            }
        },
        "autoWidth": false,
        "language": {
            "url": "js-lily/italian.json"
        },
        "aoColumnDefs": [
            { 'bSortable': false, 'aTargets': [ 0 ] },
            { "sWidth": "50px", "aTargets": [ 0 ] }
        ],
    });
    $('#add_station').hide();
    $("#view_station").hide();
    $( ".row" ).on( "click", ".view-tool", function(e) {
        $('#add_station').hide( "slow" );
        $( "#view_station" ).show( "slow" );
        var id = $(this).parent().parent().data("id");
        console.log('id:'+id);
        loadReport(id, 'show');
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".set-tool", function(e) {
        clearfields();
        var id = $(this).parent().parent().data("id");
        console.log(id);
        $( "#add_station" ).show( "slow" );
        $( "#view_station" ).hide( "slow" );
        loadReport(id, 'edit');
        e.preventDefault();
        return false;
    });
    $( "#btn-close-view" ).on( "click", function() {
        $("#view_station").hide("slow");
    });
    $( "#cancel-station-form" ).on( "click", function() {
        $( "#add_station" ).hide( "slow" );
        clearfields();
        return false;
    });
    $('#station-form').validate({
        rules: {
            'st-name': {
                required: true
            }
        },
        messages: {
            'st-name': {
                required: "Inserire un nome stazione"
            }
        },
        ignore: "",
    });
});
function clearfields(){
    $('#station-form input').iCheck('uncheck');
    $("#st-name").val('');
}
function viewClearfields(){
    $(".clear-txt").text("");
}
function loadReport(id, dest) {
    console.log('loadReport(' + id + ' -> ' + dest + ')');
    var jqxhr = $.ajax({
        url: 'man_statroam_get',
        type: "post",
        dataType: "json",
        data: { id: id },
    })
    .done(function(result) {
        console.dir( result );
        if (dest == 'show')
            viewStat(result.stat);
        if (dest == 'edit')
            editStat(result.stat);
    })
    .fail(function(xhr, err) {
        return null;
    });
}
function viewStat(report) {
    viewClearfields();
    console.log('viewStat');
    console.dir(report);
    $("#view-station").text(report.stationname);
    $("#view-table").text(report.tablename);
    $("#view-type").text(report.roaming_type);
    if (report.active == 1){
        $("#view-active").text("si");
    }else{
        $("#view-active").text("no");
    }
}
function editStat(report) {
    clearfields();
    console.log('editStat');
    console.dir(report);
    if (report.active) { $('#st-active').iCheck('check'); }
    $('#st-name').val(report.stationname);
    $('#st-id').val(report.st_id);
}
