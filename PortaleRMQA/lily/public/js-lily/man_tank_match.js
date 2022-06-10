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
var startDate, endDate;
function updateDataRange(date1, date2) {
    $('#reportrange span').html(moment(date1).format('MMMM D, YYYY') + ' - ' + moment(date2).format('MMMM D, YYYY'));
    $('#reportrange').data('daterangepicker').setStartDate(moment(date1));
    $('#reportrange').data('daterangepicker').setEndDate(moment(date2));
    startDate = moment(date1).format('YYYY-MM-DD');
    endDate = moment(date2).format('YYYY-MM-DD');
}
$(document).ready(function() {
    $( "#add_match" ).hide();
    $( "#view_match" ).hide();
    $( "#btn-add-match" ).click(function() {
        $( "#add_match" ).show( "slow" );
        $( "#view_match" ).hide( "slow" );
        $('#add_match h5').text('Aggiungi stanziamento');
        $('#btn-match-form').text('Salva');
        clearfields();
        $('#match-form').attr('action', 'man_tank_match_new');
    });
    $( "#btn-close-view" ).on( "click", function() {
        $( "#view_match" ).hide( "slow" );
    });
    $( ".row" ).on( "click", ".view-tool", function(e) {
        viewClearfields()
        $( "#add_match" ).hide( "slow" );
        $( "#view_match" ).show( "slow" );
        var id = $(this).parent().parent().data("cyid");
        console.log('id:'+id);
        loadReport(id, 'show');
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".set-tool", function(e) {
        clearfields();
        $( "#add_match" ).show( "slow" );
        $( "#view_match" ).hide( "slow" );
        $('#add_match h5').text('Modifica stanziamento');
        $('#btn-match-form').text('Modifica');
        var id = $(this).parent().parent().data("cyid");
        console.log(id);
        $('#tank-st-cy-id').val(id);
        loadReport(id, 'edit');
        $('#match-form').attr('action', 'man_tank_match_edit');
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".delete-tool", function(e) {
        e.preventDefault();
        var deleted = $(this).parent().parent();
        var id = $(this).parent().parent().data("cyid");
        console.log("id: "+id+", deleted: "+deleted);
        swal({
            title: "Elimina il report",
            text: "Sei proprio sicuro di voler eliminare il report selezionato?",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Elimina",
            closeOnConfirm: false,
            cancelButtonText: "Annulla"
        }, function () {
            var jqxhr = $.ajax({
                url: 'man_tank_match_delete',
                type: "post",
                dataType: "json",
                data: { id: id },
            })
            .done(function(result) {
                console.dir( result );
                deleted.remove();
                if ( result ==1 )
                    swal("Eliminato", "Il report selezionato è stato eliminato", "success");
                else
                    swal("Report non eliminato", "Errore durante l'eliminazione del report", "error");
            })
            .fail(function(xhr, err) {
                toastr.error(err, 'Errore');
            });
        });
    });
    $( "#cancel-match-form" ).on( "click", function() {
        $( "#add_match" ).hide( "slow" );
        clearfields();
        return false;
    });
    $('#start-date, #end-date').datepicker({
        language: 'it',
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true
    });
    $('#start-date, #end-date').datepicker('update', 'today');
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
    $( "#refresh-list" ).click(function(e) {
        e.preventDefault();
        $.redirectPost( "man_tank_match", {
            startDate: startDate,
            endDate : endDate
        } );
        return false;
    });
    $('#match-form').validate({
        rules: {
            'tank': {
                required: true,
                min: 0
            },
            'workstation': {
                required: true,
                min: 0
            },
            'start-date': {
                required: true
            },
            'end-date': {
                required: true
            }
        },
        messages: {
            'tank': {
                min: "Selezionare una bombola"
            },
            'workstation': {
                min: "Selezionare una postazione"
            },
            'start-date': {
                required: "Inserire data inizio"
            },
            'end-date': {
                required: "Inserire data fine"
            }
        },
        ignore: "",
    });
    $("#match-form").submit(function(event){
        if (! $('#match-form').valid() ) {
            console.log('Form non valido!');
            return false;
        }
        console.log('Form valido.');
        return true;
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
    $("#tank, #workstation").val('-1');
    $("#notes").val('');
    $('#start-date').datepicker('update', 'today');
    $('#end-date' ).datepicker('update', moment().add(1, 'year').format('DD/MM/YYYY'));
};
function viewClearfields(){
    $(".clear-txt").text("");
};
function loadReport(id, dest) {
    console.log('loadReport(' + id + ' -> ' + dest + ')');
    var jqxhr = $.ajax({
        url: 'tank_match_get_report',
        type: "post",
        dataType: "json",
        data: { id: id },
    })
    .done(function(result) {
        console.dir( result );
        if (dest == 'show')
            viewTank(result.tank);
        if (dest == 'edit')
            editTank(result.tank);
    })
    .fail(function(xhr, err) {
        return null;
    });
}
function viewTank(report) {
    viewClearfields();
    console.log('viewTank');
    console.dir(report);
    $("#view-tank").text(report.description+" ("+report.arpa_id+") "+report.ch_values);
    $("#view-workstation").text(report.stationname);
    $("#view-start-date").text(report.date_start_format);
    $("#view-end-date").text(report.date_end_format);
    $("#view-notes").text(report.note);
}
function editTank(report) {
    clearfields();
    console.log('editTank');
    console.dir(report);
    $('#tank').val(report.arpa_id);
    $('#workstation').val(report.st_id);
    $('#start-date').datepicker('update', report.date_start_format);
    $('#end-date').datepicker('update', report.date_end_format);
    $('#notes').val(report.note);
}
