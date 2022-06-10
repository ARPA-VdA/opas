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
jQuery.validator.addMethod("notEqual", function(value, element, param) {
  return this.optional(element) || value != param;
}, "Please specify a different (non-default) value");
var startDate, endDate;
function updateDataRange(date1, date2) {
    $('#reportrange span').html(moment(date1).format('MMMM D, YYYY') + ' - ' + moment(date2).format('MMMM D, YYYY'));
    $('#reportrange').data('daterangepicker').setStartDate(moment(date1));
    $('#reportrange').data('daterangepicker').setEndDate(moment(date2));
    startDate = moment(date1).format('YYYY-MM-DD');
    endDate = moment(date2).format('YYYY-MM-DD');
}
$(document).ready(function() {
    $('#reportrange').daterangepicker({
        format: 'DD/MM/YYYY',
        startDate: moment().subtract(29, 'days'),
        endDate: moment(),
        maxDate: moment(),
        showDropdowns: true,
        showWeekNumbers: true,
        timePicker: false,
        timePickerIncrement: 1,
        timePicker12Hour: true,
        ranges: {
            'Ultimi 30 Giorni': [moment().subtract(29, 'days'), moment()],
            'Ultimi 6 Mesi': [moment().subtract(6, 'months'), moment()],
            'Ultimo Anno': [moment().subtract(1, 'year'), moment()]
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
        $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
    });
    $("#instrument").chosen();
    $( "#add_instrument_match" ).hide();
    $( "#view_instrument_match" ).hide();
    $('#start-date, #end-date').datepicker({
        language: 'it',
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true,
    });
    $('#start-date, #end-date').datepicker('update', 'today');
    $('#start-time, #end-time').timepicker({
        minuteStep: 60,
        snapToStep: true,
        showInputs: false,
        disableFocus: true,
        showMeridian: false
    });
    $('#start-time, #end-time').timepicker('setTime', moment().format('HH:00:00'));
    $( "#btn-add-instrument-match" ).click(function() {
        $( "#add_instrument_match" ).show( "slow" );
        $('#add_instrument_match h5').text('Aggiungi bombola');
        $('#btn-instrument-match-form').text('Salva');
        $('#instrument-match-form').attr('action', 'man_instrument_match_new');
        $('#add_instrument_match h5').text('Aggiungi stanziamento strumento');
        $('#btn-instrument-match-form').text('Salva');
        clearfields();
    });
    $( ".row" ).on( "click", ".set-tool", function(e) {
        clearfields();
        var id = $(this).parent().parent().data("id");
        console.log(id);
        $( "#add_instrument_match" ).show( "slow" );
        $( "#view_instrument_match" ).hide( "slow" );
        $('#instrument-match-form').attr('action', 'man_instrument_match_edit');
        $('#add_instrument_match h5').text('Modifica stanziamento strumento');
        $('#btn-instrument-match-form').text('Modifica');
        loadReport(id, 'edit');
        e.preventDefault();
        return false;
    });
    $('#instrument-match-form').validate({
        rules: {
            'station': {
                required: true,
                min: 0
            },
            'instrument': {
                required: true,
                notEqual: "-1"
            },
            'start-date': {
                required: true
            },
            'end-date': {
                required: true
            },
            'start-time': {
                required: true
            },
            'end-time': {
                required: true
            },
        },
        messages: {
            'station': {
                min: "Selezionare stazione"
            },
            'instrument': {
                notEqual: "Selezionare strumento"
            },
            'start-date': {
                required: "Selezionare data inizio"
            },
            'end-date': {
                required: "Selezionare data fine"
            },
            'start-time': {
                required: "Selezionare ora inizio"
            },
            'end-time': {
                required: "Selezionare ora fine"
            },
        },
        ignore: "",
    });
    $( ".row" ).on( "click", ".delete-tool", function(e) {
        var deleted = $(this).parent().parent();
        var id = $(this).parent().parent().data("id");
        console.log("MY ID: "+id);
        console.log("deleted: "+deleted);
        swal({
            title: "Elimina stanziamento strumento",
            text: "Sei proprio sicuro di voler eliminare lo stanziamento selezionato?",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Elimina",
            closeOnConfirm: false,
            cancelButtonText: "Annulla"
        }, function () {
            var jqxhr = $.ajax({
                url: 'man_instrument_match_delete',
                type: "post",
                dataType: "json",
                data: { id: id },
            })
            .done(function(result) {
                console.dir( result );
                deleted.remove();
                if ( result ==1 )
                    swal("Eliminato", "Lo stanziamento selezionato è stato eliminato", "success");
                else
                    swal("Stanziamento non eliminato", "Errore durante l'eliminazione dello stanziamento", "error");
            })
            .fail(function(xhr, err) {
                toastr.error(err, 'Errore');
            });
        });
        e.preventDefault();
        return false;
    });
    $( "#cancel-instrument-match-form" ).on( "click", function() {
        $( "#add_instrument_match" ).hide( "slow" );
        clearfields();
        return false;
    });
    $( ".row" ).on( "click", ".view-tool", function(e) {
        viewClearfields();
        $('#add_instrument_match').hide( "slow" );
        $( "#view_instrument_match" ).show( "slow" );
        var id = $(this).parent().parent().data("id");
        console.log('id:'+id);
        loadReport(id, 'show');
        e.preventDefault();
        return false;
    });
    $( "#btn-close-view" ).on( "click", function() {
        $( "#view_instrument_match" ).hide( "slow" );
    });
    $( "#refresh-list" ).click(function(e) {
        e.preventDefault();
        $.redirectPost( "man_instrument_match", {
            startDate: startDate,
            endDate : endDate
        } );
        return false;
    });
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
        "order": [[ 1, "asc" ]],
    });
});
function clearfields(){
    $('#start-date').datepicker('update', 'today');
    $('#end-date' ).datepicker('update', moment().add(5, 'year').format('DD/MM/YYYY'));
    $('#start-time, #end-time').timepicker('setTime', moment().format('HH:00:00'));
    $('#notes').val('');
    $('.i-checks').iCheck('uncheck');
    $("#station, #instrument").val('-1');
    $('#instrument').trigger("chosen:updated");
};
function viewClearfields(){
    $(".clear-txt").text("");
};
function loadReport(id, dest) {
    console.log('loadReport(' + id + ' -> ' + dest + ')');
    var jqxhr = $.ajax({
        url: 'man_instrument_get_match',
        type: "post",
        dataType: "json",
        data: { id: id },
    })
    .done(function(result) {
        console.dir( result );
        if (dest == 'show')
            viewMatch(result.match);
        if (dest == 'edit')
            editMatch(result.match);
    })
    .fail(function(xhr, err) {
        return null;
    });
}
function viewMatch(report) {
    viewClearfields();
    console.log('viewMatch');
    console.dir(report);
    $("#view-arpaid").text(report.arpa_id);
    $("#view-station").text(report.station_name);
    $("#view-instrument").text(report.strumento);
    $("#view-start-date").text(report.date_start_format);
    $("#view-start-time").text(report.time_start_format);
    if(report.date_end == "infinity"){
        $("#view-end-date").text(report.date_end);
    }else{
        $("#view-end-date").text(report.date_end_format);
    }
    $("#view-end-time").text(report.time_end_format);
    if(report.attivo == 1){
        $("#view-active_ins").text("si");
    }else{
        $("#view-active_ins").text("no");
    }
    $("#view-notes").text(report.note);
}
function editMatch(report) {
    clearfields();
    console.log('editMatch');
    console.dir(report);
    $('#in-match-id').val(report.st_in_id);
    $('#station').val(report.st_id);
    $('#instrument').val(report.arpa_id);
    $('#instrument').trigger("chosen:updated");
    $('#start-date').datepicker('update', report.date_start_format);
    $('#end-date').datepicker('update', report.date_end_format);
    $('#start-time').val(report.time_start_format);
    $('#end-time').val(report.time_end_format);
    if(report.attivo == 1){
        $('.i-checks').iCheck('check');
    }
    $('#notes').val(report.note);
}
