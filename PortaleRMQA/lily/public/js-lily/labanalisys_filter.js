$.extend(
{
    redirectPost: function(location, args)
    {
        var form = '';
        $.each( args, function( key, value ) {
            form += '<input type="hidden" name="'+key+'" value="'+value+'">';
        });
        $('<form action="' + location + '" method="POST">' + form + '</form>').appendTo($(document.body)).submit();
    }
});
var formule, volume;
var startDate, endDate;
function updateDataRange(date1, date2) {
    $('#reportrange span').html(moment(date1).format('DD.MM.YY') + ' - ' + moment(date2).format('DD.MM.YY'));
    $('#reportrange').data('daterangepicker').setStartDate(moment(date1));
    $('#reportrange').data('daterangepicker').setEndDate( moment(date2));
    startDate = moment(date1).format('YYYY-MM-DD');
    endDate = moment(date2).format('YYYY-MM-DD');
}
$(document).ready(function() {
    $('#reportrange').daterangepicker({
        format: 'DD/MM/YYYY',
        startDate: moment().subtract(87, 'days'),
        endDate: moment(),
        minDate: moment("1996-01-01", "YYYY-MM-DD"),
        maxDate: moment(),
        dateLimit: { days: 744 },
        showDropdowns: true,
        showWeekNumbers: true,
        timePicker: false,
        timePickerIncrement: 1,
        timePicker12Hour: true,
        ranges: {
            'Ultimo Mese': [moment().subtract(29, 'days'), moment()],
            'Ultimi 3 Mesi': [moment().subtract(87, 'days'), moment()],
            'Ultimi 6 Mesi': [moment().subtract(174, 'days'), moment()],
            'Ultimi 9 Mesi': [moment().subtract(261, 'days'), moment()],
            'Ultimo Anno': [moment().subtract(348, 'days'), moment()],
        },
        opens: 'left',
        drops: 'down',
        buttonClasses: ['btn', 'btn-sm'],
        applyClass: 'btn-primary',
        cancelClass: 'btn-default',
        separator: ' to ',
        locale: {
            applyLabel: 'Vai',
            cancelLabel: 'Annulla',
            fromLabel: 'Da',
            toLabel: 'A',
            customRangeLabel: 'Utente',
            daysOfWeek: ['Do', 'Lu', 'Ma', 'Me', 'Gi', 'Ve','Sa'],
            monthNames: ['Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno', 'Luglio', 'Agosto', 'Settembre', 'Ottobre', 'Novembre', 'Dicembre'],
            firstDay: 1
        }
    }, function(start, end, label) {
        console.log(start.format('YYYY-MM-DD'), end.toISOString(), label);
        startDate = start.format('YYYY-MM-DD');
        endDate = end.format('YYYY-MM-DD');
        $('#reportrange span').html(start.format('DD.MM.YY') + ' - ' + end.format('DD.MM.YY'));
    });
    $('.table-sample').dataTable({
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
            { "sWidth": "50px", "aTargets": [ 0 ] },
            { "sType": "string", "aTargets": [ 3 ] }
        ],
    });
    $( "#view_sample" ).on( "change", ".input_mass", function() {
        console.log('start operation');
        var mass = $(this).val();
        var next = $(this).parent().next().next().children();
        var operation = (mass / volume * formule).toFixed(4);
        console.log(operation);
        next.val(operation);
    });
    $( "#refresh-list" ).click(function(e) {
        e.preventDefault();
        var selPrel = $('#filter_prel').val();
        var selAnalysis = $('#filter_analysis').val();
        var selStations = $('#filter_stations').val();
        var sampleFrom = $('#sample-id-from').val();
        var sampleTo = $('#sample-id-to').val();
        $.redirectPost( "labanalisys_filter", {
            startDate : startDate,
            endDate : endDate,
            selPrel : selPrel,
            selAnalysis : selAnalysis,
            selStations : selStations,
            sampleFrom : null,
            sampleTo : null
        } );
        return false;
    });
    $( "#refresh-list2" ).click(function(e) {
        e.preventDefault();
        var selPrel = $('#filter_prel').val();
        var selAnalysis = $('#filter_analysis').val();
        var selStations = $('#filter_stations').val();
        var sampleFrom = $('#sample-id-from').val();
        var sampleTo = $('#sample-id-to').val();
        var sampleFrom = $('#sample-id-from').val();
        var sampleTo = $('#sample-id-to').val();
        $.redirectPost( "labanalisys_filter", {
            startDate : startDate,
            endDate : endDate,
            selPrel : selPrel,
            selAnalysis : selAnalysis,
            selStations : selStations,
            sampleFrom : sampleFrom,
            sampleTo : sampleTo
        } );
        return false;
    });
    $( "#view_sample" ).hide();
    $( "#btn-close-view" ).on( "click", function() {
        $( "#view_sample" ).hide( "slow" );
    });
    $( ".row" ).on( "click", ".view-tool", function(e) {
        viewClearfields();
        $( "#title-sample" ).text( "Visualizza campione" );
        $( "#buttons-data #btn-save-data" ).remove();
        $( "#view_sample" ).show( "slow" );
        var id = $(this).parent().parent().data("id");
        loadReport(id, 'empty', 'show');
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".add-data", function(e) {
        viewClearfields();
        $( "#buttons-data #btn-save-data" ).remove();
        $( "#title-sample" ).text( "Modifica dati campione" );
        $( "#view_sample" ).show( "slow" );
        var id = $(this).parent().parent().data("id");
        console.log('id:'+id);
        var anid = $(this).parent().parent().data("anid");
        console.log('anid:'+anid);
        loadReport(id, anid, 'edit');
        e.preventDefault();
        return false;
    });
});
function viewClearfields(){
    $(".clear-txt").text("");
    $("#table-data-sample").empty();
};
function loadReport(id, anid, dest) {
    console.log('loadReport(' + id + ' -> ' + dest + ')');
    var jqxhr = $.ajax({
        url: 'sample_get',
        type: "post",
        dataType: "json",
        data: { id: id },
    })
    .done(function(result) {
     viewClearfields();
        volume = result.sample.volume;
        console.log('volume: '+volume);
        console.dir( result );
        console.log("pippuzzo");
        console.log(result.sample.sp_id);
     $("#view-sample-id").text(result.sample.sp_id);
     $("#view-vol-sample").text(result.sample.volume);
     $("#view-prel").text(result.sample.filter_name);
     $("#view-analysis").text(result.sample.analysis_name);
     $("#view-start-date").text(result.sample.date_start);
     $("#view-days").text(result.sample.no_days);
     $("#view-station").text(result.sample.stationname);
     $("#view-notes").text(result.sample.note);
        if (dest == 'show')
            viewSample(result);
        if (dest == 'edit')
            editSample(result, anid);
    })
    .fail(function(xhr, err) {
        return null;
    });
}
function viewSample(report) {
    console.log('viewSample');
    console.dir(report);
    if(report.data && report.data.length){
        $( "#table-all-data" ).show();
        $.each(report.data, function(key, value) {
            var mass = value.mass;
            mass = mass.replace("-", "< ");
            var conc = value.conc;
            conc = conc.replace("-", "< ");
            var ope = '<tr>';
                    ope += '<td>'+value.lab_pr_id+'</td>';
                    ope += '<td>'+value.name+'</td>';
                    ope += '<td>'+mass+'</td>';
                    ope += '<td>'+value.unit+'</td>';
                    ope += '<td>'+conc+'</td>';
                    ope += '<td>'+value.unitconv+'</td>';
                ope += '</tr>';
            $( "#table-data-sample" ).append( ope );
        });
    }else{
        $( "#table-all-data" ).hide();
    }
}
function editSample(report, anid) {
    console.log('editSample');
    console.log('arrivata:'+ anid);
    console.dir(report);
    $( "#buttons-data" ).append( '<button class="btn btn-warning" id="btn-save-data" type="submit" name="btn-close-view">Salva dati</button>' );
    $( "#sample_id_filter" ).val( report.sample.sp_id );
    if(report.data && report.data.length){
        $( "#table-all-data" ).show();
        $.each(report.data, function(key, value) {
            formule = value.formule;
            var ope = '<tr>';
                    ope += '<td>'+value.lab_pr_id+'</td>';
                    ope += '<td>'+value.name+'</td>';
                    ope += '<td><input type="text" class="input_mass" value="'+value.mass+'" name="mass_'+value.lab_pr_id+'" id="mass_'+value.lab_pr_id+'" /></td>';
                    ope += '<td>'+value.unit+'</td>';
                    ope += '<td><input type="text" class="conc_value" value="'+value.conc+'" name="conc_'+value.lab_pr_id+'" id="conc_'+value.lab_pr_id+'" /></td>';
                    ope += '<td>'+value.unitconv+'</td>';
                ope += '</tr>';
            $( "#table-data-sample" ).append( ope );
        });
    }else{
        var jqxhr = $.ajax({
            url: 'filter_empty',
            type: "post",
            dataType: "json",
            data: { anid: anid },
        })
        .done(function(result) {
            $("#table-data-sample").empty();
            $( "#table-all-data" ).show();
            console.log("the end");
            console.dir( result );
            $.each(result.filter, function(key, value) {
                formule = value.formule;
                var ope = '<tr>';
                        ope += '<td>'+value.lab_pr_id+'</td>';
                        ope += '<td>'+value.name+'</td>';
                        ope += '<td><input type="text" class="input_mass" name="mass_'+value.lab_pr_id+'" id="mass_'+value.lab_pr_id+'" /></td>';
                        ope += '<td>'+value.unit+'</td>';
                        ope += '<td><input type="text" class="conc_value" name="conc_'+value.lab_pr_id+'" id="conc_'+value.lab_pr_id+'" /></td>';
                        ope += '<td>'+value.unitconv+'</td>';
                    ope += '</tr>';
                $( "#table-data-sample" ).append( ope );
            });
        })
        .fail(function(xhr, err) {
            return null;
        });
    }
}
