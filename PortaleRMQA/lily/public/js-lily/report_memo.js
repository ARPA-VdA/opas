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
    console.log(date1, date2);
    $('#reportrange span').html(moment(date1).format('DD.MM.YY') + ' - ' + moment(date2).format('DD.MM.YY'));
    $('#reportrange').data('daterangepicker').setStartDate(moment(date1));
    $('#reportrange').data('daterangepicker').setEndDate( moment(date2));
    startDate = moment(date1).format('YYYY-MM-DD');
    endDate = moment(date2).format('YYYY-MM-DD');
}
function showReportFromGet(id) {
    loadReport(id, 'show');
    $("#add-memo").hide();
    $("#view-memo").show("slow");
}
$(document).ready(function() {
    $( "#refresh-list" ).click(function(e) {
        e.preventDefault();
        $.redirectPost( "report_memo", {
            startDate: startDate,
            endDate : endDate
        } );
        return false;
    });
    $('#add-memo').hide();
    $('#view-memo').hide();
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
            { "sWidth": "66px", "aTargets": [ 0 ] }
        ],
        "order": [[ 1, "desc" ]],
    });
    $('#reportrange').daterangepicker({
        format: 'DD/MM/YYYY',
        startDate: moment().subtract(59, 'days'),
        endDate: moment(),
        minDate: moment("2015-01-01", "YYYY-MM-DD"),
        maxDate: moment(),
        dateLimit: { days: 744 },
        showDropdowns: true,
        showWeekNumbers: true,
        timePicker: false,
        timePickerIncrement: 1,
        timePicker12Hour: true,
        ranges: {
            'Questo Mese': [moment().startOf('month'), moment().endOf('month')],
            'Mese Scorso': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
            'Ultimo Mese': [moment().subtract(29, 'days'), moment()],
            'Ultimi 2 Mesi': [moment().subtract(59, 'days'), moment()],
            'Ultimi 6 Mesi': [moment().subtract(179, 'days'), moment()]
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
    $('#memo-date').datepicker({
        language: 'it',
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true
    });
    $('#memo-date').datepicker('update', 'today');
    $('#memo_time_start input, #memo_time_end input').timepicker({
        minuteStep: 5,
        showInputs: false,
        disableFocus: true,
        showMeridian: false
    });
    $('.summernote').summernote({
        lang: 'it-IT',
        height: 250,
        toolbar: [
            ['style', ['bold', 'italic', 'underline', 'clear']],
            ['para', ['ul', 'ol', 'paragraph']],
        ]
    });
    var edit = function() {
        $('.click2edit').summernote({focus: true});
    };
    var save = function() {
        var aHTML = $('.click2edit').code();
        $('.click2edit').destroy();
    };
    $("#memo-participant").chosen({
        width: "100%!important",
        no_results_text: "Nessun risultato con "
    });
    $( "#btn-add-memo" ).click(function() {
        $('#add-memo').show("slow");
        $('#memo-form').attr('action', 'report_memo_new');
        $('#memo-form').trigger("chosen:updated");
        $( "#add-memo .ibox-title h5" ).text("Aggiungi verbale");
        $( "#add-memo #btn-memo-form" ).text("Salva");
        clearfields();
    });
    $( ".row" ).on( "click", ".view-tool", function(e) {
        $("#add-memo").hide();
        $("#view-memo").show("slow");
        var id = $(this).parent().parent().data("id");
        loadReport(id, 'show');
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".pdf-tool", function(e) {
        var id = $(this).parent().parent().data("id");
        console.log('download del pdf: '+id);
        $.redirectPost( "report_memo_pdf", {
            id: id
        });
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".set-tool", function(e) {
        $('#memo-form').attr('action', 'report_memo_edit');
        $( "#add-memo" ).show( "slow" );
        $( "#view-memo" ).hide( "slow" );
        $( "#add-memo .ibox-title h5" ).text("Modifica verbale");
        $( "#add-memo #btn-memo-form" ).text("Modifica");
        var id = $(this).parent().parent().data("id");
        loadReport(id, 'edit');
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".delete-tool", function(e) {
        e.preventDefault();
        var deleted = $(this).parent().parent();
        var id = $(this).parent().parent().data("id");
        console.log(id);
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
                url: 'report_memo_delete',
                type: "post",
                dataType: "json",
                data: { id: id },
            })
            .done(function(result) {
                console.dir( result );
                deleted.remove();
                swal("Eliminato", "Il report selezionato è stato eliminato", "success");
            })
            .fail(function(xhr, err) {
                swal("Report non eliminato", "Errore durante l'eliminazione del report", "error");
            });
        });
    });
    $( "#cancel-memo-form" ).click(function() {
        clearfields();
        $( "#add-memo" ).hide( "slow" );
        return false;
    });
    $("#btn-close-view").click(function() {
        $( "#view-memo" ).hide( "slow" );
    });
    $.validator.addMethod("time24", function(value, element) {
        return /^([01]?[0-9]|2[0-3])(:[0-5][0-9]){1}$/.test(value);
    }, "Formato ora non valido [HH:mm].");
    $('#memo-form').validate({
        rules: {
            "memo-place": {
                required: true,
            },
            "memo-date": {
                required: true,
            },
            "memo-time-start": {
                required: true,
                time24: true
            },
            "memo-time-end": {
                required: true,
                time24: true
            },
            "memo-verbalize": {
                required: true,
                min: 1
            },
            "memo-title": {
                required: true
            },
            "memo-body": {
                required: true,
            }
        },
        messages: {
            "memo-place": {
                required: "Inserire una località",
            },
            "memo-date": {
                required: "Inserire una data",
            },
            "memo-time-start": {
                required: "Inserire ora inizio report",
                time24: "Formato ora non valido [HH:mm]"
            },
            "memo-time-end": {
                required: "Inserire ora fine report",
                time24: "Formato ora non valido [HH:mm]"
            },
            "memo-verbalize": {
                min: "Selezionare un verbalizzante"
            },
            "memo-title": {
                required: "Inserire un titolo",
            },
            "memo-body": {
                required: "Inserire testo verbale",
            }
        },
        ignore: "",
    });
    $("#memo-form").submit(function(event){
        if (! $('#memo-form').valid() ) {
            console.log('Form non valido!');
            return false;
        }
        console.log('Form valido.');
        return true;
    });
});
function loadReport(id, dest) {
    console.log('loadReport() ' + id);
    var jqxhr = $.ajax({
        url: 'report_memo_get_report',
        type: "post",
        dataType: "json",
        data: { id: id },
    })
    .done(function(result) {
        if (result.report == null)
            return;
        if (dest == 'show')
            showReport(result.report);
        if (dest == 'edit')
            editReport(result.report);
    })
    .fail(function(xhr, err) {
        return null;
    });
}
function showReport(report) {
    viewClearfields();
    console.dir(report);
    $("#view_loc").text(report.memo_place);
    $("#view_date").text(report.memo_date);
    $("#view_start").text(report.memo_start_time);
    $("#view_end").text(report.memo_end_time);
    $("#view_verbalize").text(report.memo_username);
    $("#view_participant").text(report.participant_names);
    $("#view_title").text(report.memo_title);
    $("#view_body").html(report.memo_body);
}
function editReport(report) {
    clearfields();
    console.dir(report);
    $("#memo-meid").val(report.me_id);
    $("#memo-place").val(report.memo_place);
    $('#memo-date').datepicker('update', report.memo_date_format);
    $('#memo-time-start').timepicker('setTime', report.memo_start_time);
    $('#memo-time-end').timepicker('setTime', report.memo_end_time);
    $("#memo-verbalize").val(report.us_id);
    var array = report.participant_ids.replace(/ /g,'').split(",");
    console.dir(array);
    $("#memo-participant").val(array).trigger('chosen:updated');
    $("#memo-title").val(report.memo_title);
    $('.summernote').code(report.memo_body);
}
function viewClearfields(){
    $(".clear-txt").text("");
}
function clearfields(){
    $('#memo-place, #memo-title').val('');
    $('#memo-date').datepicker('update', 'today');
    $('#memo-time-start, #memo-time-end').timepicker('setTime', moment().format('HH:00:00'));
    $("#memo-participant").val('');
    $('#memo-participant').trigger("chosen:updated");
    $('.summernote').code('');
};
