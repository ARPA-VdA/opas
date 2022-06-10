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
        $.redirectPost( "man_statroam_match", {
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
            { 'bSortable': false, 'aTargets': [ 0, 6 ] },
            { "sWidth": "50px", "aTargets": [ 0 ] }
        ],
        "order": [[ 1, "asc" ]]
    });
    $('#start-date, #end-date').datepicker({
        language: 'it',
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true,
    });
    $('#start-date, #end-date').datepicker('update', 'today');
    $( "#view_statroam_match" ).hide();
    $( "#add_statroam_match" ).hide();
    $( "#btn-close-view" ).on( "click", function() {
        $( "#view_statroam_match" ).hide( "slow" );
    });
    $( "#cancel-statroam-match-form" ).on( "click", function() {
        $( "#add_statroam_match" ).hide( "slow" );
        clearfields();
        return false;
    });
    $( "#btn-add-statroam-match" ).click(function() {
        $( "#add_statroam_match" ).show( "slow" );
        $('#add_statroam_match h5').text('Aggiungi bombola');
        $('#btn-statroam-match-form').text('Salva');
        $('#statroam-match-form').attr('action', 'man_statroam_match_new');
        $('#add_statroam_match h5').text('Aggiungi stanziamento staz. mobile');
        $('#btn-statroam-match-form').text('Salva');
        clearfields();
    });
    $( ".row" ).on( "click", ".set-tool", function(e) {
        clearfields();
        var id = $(this).parent().parent().data("id");
        console.log(id);
        $( "#add_statroam_match" ).show( "slow" );
        $( "#view_statroam_match" ).hide( "slow" );
        $('#statroam-match-form').attr('action', 'man_statroam_match_edit');
        $('#add_statroam_match h5').text('Modifica stanziamento strumento');
        $('#btn-statroam-match-form').text('Modifica');
        loadReport(id, 'edit');
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".view-tool", function(e) {
        viewClearfields();
        $('#add_statroam_match').hide( "slow" );
        $( "#view_statroam_match" ).show( "slow" );
        var id = $(this).parent().parent().data("id");
        console.log('id:'+id);
        loadReport(id, 'show');
        e.preventDefault();
        return false;
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
                url: 'man_statroam_match_delete',
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
    $('#statroam-match-form').validate({
        rules: {
            'st_mob': {
                required: true,
                min: 0
            },
            'st_sito': {
                required: true,
                min: 0
            },
            'start-date': {
                required: true
            },
            'end-date': {
                required: true
            },
        },
        messages: {
            'st_mob': {
                min: "Selezionare stazione"
            },
            'st_sito': {
                min: "Selezionare strumento"
            },
            'start-date': {
                required: "Selezionare data inizio"
            },
            'end-date': {
                required: "Selezionare data fine"
            },
        },
        ignore: "",
    });
});
function viewClearfields(){
    $(".clear-txt").text("");
};
function clearfields(){
    $('#start-date').datepicker('update', 'today');
    $('#end-date' ).datepicker('update', moment().add(1, 'month').format('DD/MM/YYYY'));
    $('#notes').val('');
    $("#st_mob, #st_sito").val('-1');
};
function loadReport(id, dest) {
    console.log('loadReport(' + id + ' -> ' + dest + ')');
    var jqxhr = $.ajax({
        url: 'man_statroam_get_match',
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
    $("#view-st_mob").text(report.stationname);
    $("#view-st_sito").text(report.stationnameoverride);
    $("#view-start-date").text(report.datefrom_format);
    $("#view-end-date").text(report.dateto_format);
    $("#view-duration").text(report.durata);
    $("#view-notes").text(report.note);
}
function editMatch(report) {
    clearfields();
    console.log('editMatch');
    console.dir(report);
    $('#st_mob').val(report.st_id);
    $('#st_sito').val(report.st_id_override);
    $('#start-date').datepicker('update', report.datefrom_format);
    $('#end-date').datepicker('update', report.dateto_format);
    $('#notes').val(report.note);
    $('#st-match-id').val(report.id);
}
