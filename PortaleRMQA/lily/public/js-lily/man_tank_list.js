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
    $('#attachment').fileinput({
        showUpload: false,
        showPreview: false,
        language: 'it',
        allowedFileExtensions : ['jpg', 'png', 'pdf'],
    });
    $( "#add_tank" ).hide();
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
    $( ".row" ).on( "click", ".set-tool", function(e) {
        clearfields();
        var id = $(this).parent().parent().data("cyid");
        console.log(id);
        $( "#add_tank" ).show( "slow" );
        $( "#view_tank" ).hide( "slow" );
        $('#tank-form').attr('action', 'man_tank_edit');
        $('#add_tank h5').text('Modifica bombola');
        $('#btn-tank-form').text('Modifica');
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
            title: "Elimina bombola",
            text: "Sei proprio sicuro di voler eliminare la bombola selezionata?",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Elimina",
            closeOnConfirm: false,
            cancelButtonText: "Annulla"
        }, function () {
            var jqxhr = $.ajax({
                url: 'man_tank_delete',
                type: "post",
                dataType: "json",
                data: { id: id },
            })
            .done(function(result) {
                console.dir( result );
                deleted.remove();
                if ( result ==1 )
                    swal("Eliminata", "La bombola selezionata è stato eliminata", "success");
                else
                    swal("Bombola non eliminata", "Errore durante l'eliminazione della bombola", "error");
            })
            .fail(function(xhr, err) {
                toastr.error(err, 'Errore');
            });
        });
    });
    $( "#add_tank" ).on( "click", ".btn-verify", function(e) {
        e.preventDefault();
        var id = $('#arpa-id').val();
        console.log(id);
        swal({
            title: "Verifica id",
            text: "Verificare l'arpa id: "+id,
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Verifica",
            closeOnConfirm: false,
            cancelButtonText: "Annulla"
        }, function () {
            var jqxhr = $.ajax({
                url: 'man_tank_arpa_id',
                type: "post",
                dataType: "json",
                data: { id: id },
            })
            .done(function(result) {
                console.dir( result );
                if ( result ==1 )
                    swal("Verificato", "L'arpa id è stato verificato e risulta disponibile", "success");
                else
                    swal("Id non disponibile", "Id arpa inserito è già stato utilizzato", "error");
            })
            .fail(function(xhr, err) {
                toastr.error(err, 'Errore');
            });
        });
    });
    $('#tank-date-built, #tank-date-expiry').datepicker({
        language: 'it',
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true,
    });
    $('#tank-date-built, #tank-date-expiry').datepicker('update', 'today');
    $('#values-ins').hide();
    $('#tank-instrument').on('change', function() {
        $('.show-first').show();
        $('.show-second').show();
        $('.show-third').show();
        $('.show-first input').val('');
        $('.show-second input').val('');
        $('.show-third input').val('');
        var res = $('#tank-instrument').val();
        switch(parseInt(res)) {
            case 1000:
                $('#values-ins').show();
                $('label.show-first').text('Val SO2');
                $('.show-second').hide();
                $('.show-third').hide();
                break;
            case 1010:
                $('#values-ins').show();
                $('label.show-first').text('Val NOX');
                $('label.show-second').text('Val NO');
                $('label.show-third').text('Val NO2');
                break;
            case 1020:
                $('#values-ins').show();
                $('label.show-first').text('Val CO');
                $('.show-second').hide();
                $('.show-third').hide();
                break;
            case 1070:
                $('#values-ins').show();
                $('label.show-first').text('Val BEN');
                $('label.show-second').text('Val TOL');
                $('label.show-third').text('Val XIL');
                break;
            case 1110:
                $('#values-ins').show();
                $('label.show-first').text('Val CH4');
                $('.show-second').hide();
                $('.show-third').hide();
                break;
            default:
                $('#values-ins').hide();
                break;
        }
    });
    $( "#refresh-list" ).click(function(e) {
        e.preventDefault();
        $.redirectPost( "man_tank_list", {
            startDate: startDate,
            endDate : endDate
        } );
        return false;
    });
    $( "#cancel-tank-form" ).on( "click", function() {
        $( "#add_tank" ).hide( "slow" );
        clearfields();
        return false;
    });
    $( "#btn-close-view" ).on( "click", function() {
        $( "#view_tank" ).hide( "slow" );
    });
    $( "#view_tank" ).hide();
    $( ".row" ).on( "click", ".view-tool", function(e) {
        $('#add_tank').hide( "slow" );
        $( "#view_tank" ).show( "slow" );
        var id = $(this).parent().parent().data("cyid");
        console.log('id:'+id);
        loadReport(id, 'show');
        e.preventDefault();
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
    $( "#download-csv" ).click(function(e) {
        e.preventDefault();
        $.redirectPost( "man_tank_csv", {
            startDate: startDate,
            endDate : endDate
        } );
        return false;
    });
    $("#btn-add-tank").click(function() {
        $("#pdf_current").hide();
        $("#add_tank").show( "slow" );
        $('#add_tank h5').text('Aggiungi bombola');
        $('#btn-tank-form').text('Salva');
        $('#tank-form').attr('action', 'man_tank_new');
        clearfields();
    });
    $('#tank-form').validate({
        rules: {
            'arpa-id': {
                required: true
            },
            'tank-description': {
                required: true
            },
            'tank-date-built': {
                required: true
            },
            'tank-date-expiry': {
                required: true
            },
            'tank-instrument': {
                required: true,
                min: 0
            },
            'val-first': {
                required: { depends: function(element){ return $("#tank-instrument").val() != '-1' } }
            },
            'val-second': {
                required: { depends: function(element){ return ($("#tank-instrument").val() == '1010' || $("#tank-instrument").val() == '1070') } }
            },
            'val-third': {
                required: { depends: function(element){ return ($("#tank-instrument").val() == '1010' || $("#tank-instrument").val() == '1070') } }
            },
        },
        messages: {
            'arpa-id': {
                required: "Inserire un codice Arpa ID"
            },
            'tank-description': {
                required: "Inserire il nome della bombola"
            },
            'tank-date-built': {
                required: "Inserire una data di produzione"
            },
            'tank-date-expiry': {
                required: "Inserire una data di scadenza"
            },
            'tank-instrument': {
                min: "Selezionare uno strumento"
            },
            'val-first': {
                required: "Inserire il valore del gas"
            },
            'val-second': {
                required: "Inserire il valore del gas"
            },
            'val-third': {
                required: "Inserire il valore del gas"
            }
        },
        ignore: "",
    });
    $("#tank-form").submit(function(event){
        if (! $('#tank-form').valid() ) {
            console.log('Form non valido!');
            return false;
        }
        console.log('Form valido.');
        return true;
    });
});
function clearfields(){
    $("#tank-instrument").val('-1');
    $("#arpa-id, #tank-description, #val-first, #val-second, #val-third").val('');
    $("#delivery-note, #shipment-note, #purchase-invoice, #reversal-invoice, #payment-invoice, #note").val('');
    $('#tank-date-built, #tank-date-expiry').datepicker('update', 'today');
    $('#values-ins').hide();
    $('#tank-form input').iCheck('uncheck');
};
function viewClearfields(){
    console.log('viewClearfields');
    $("#label-iszero").hide();
    $("#label-exhausted").hide();
    $("#label-returned").hide();
    $("#label-not-compliant").hide();
    $("#label-all-stations").hide();
    $(".clear-txt").text("");
};
function loadReport(id, dest) {
    console.log('loadReport(' + id + ' -> ' + dest + ')');
    var jqxhr = $.ajax({
        url: 'tank_list_get_report',
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
    $("#view-arpa-id").text(report.arpa_id);
    $("#view-tank-description").text(report.description);
    $("#view-tank-date-built").text(report.date_built);
    $("#view-tank-date-expiry").text(report.date_expiry);
    $("#view-tank-instrument").text(report.instrument_category);
    $("#view-val-first").text(report.ch1_value);
    $("#view-val-second").text(report.ch2_value);
    $("#view-val-third").text(report.ch3_value);
    $("#view-delivery-note").text(report.delivery_note);
    $("#view-shipment-note").text(report.shipment_note);
    $("#view-purchase-invoice").text(report.purchase_invoice);
    $("#view-reversal-invoice").text(report.reversal_invoice);
    $("#view-payment-invoice").text(report.payment_invoice);
    $("#view-note").text(report.note);
    if (report.attachment){
        var url = '<a href="uploads/files/tanks/'+report.attachment+'" target="_blank" class="text-danger pdf_download"><i class="fa fa-file-pdf-o" aria-hidden="true"></i> '+report.attachment+'</a>';
        $("#view-attachment").html(url);
    }
    if (report.is_zero){
        $("#label-iszero").show();
    }
    if (report.returned){
        $("#label-returned").show();
    }
    if (report.exhausted){
        $("#label-exhausted").show();
    }
    if (report.not_compliant){
        $("#label-not-compliant").show();
    }
    if (report.all_stations){
        $("#label-all-stations").show();
    }
    $('#view-label-first').hide();
    $('#view-label-second').hide();
    $('#view-label-third').hide();
    $('#view-val-first').text('');
    $('#view-val-second').text('');
    $('#view-val-third').text('');
    var res = report.in_ca_id;
    switch(parseInt(res)) {
        case 1000:
            $('#view-label-first').show();
            $('#view-label-first').text('Val SO2');
            $('#view-val-first').text(report.ch1_value);
            break;
        case 1010:
            $('#view-label-first').show();
            $('#view-label-second').show();
            $('#view-label-third').show();
            $('#view-label-first').text('Val NOX');
            $('#view-label-second').text('Val NO');
            $('#view-label-third').text('Val NO2');
            $("#view-val-first").text(report.ch1_value);
            $("#view-val-second").text(report.ch2_value);
            $("#view-val-third").text(report.ch3_value);
            break;
        case 1020:
            $('#view-label-first').show();
            $('#view-label-first').text('Val CO');
            $('#view-val-first').text(report.ch1_value);
            break;
        case 1070:
            $('#view-label-first').show();
            $('#view-label-second').show();
            $('#view-label-third').show();
            $('#view-label-first').text('Val BEN');
            $('#view-label-second').text('Val TOL');
            $('#view-label-third').text('Val XIL');
            $("#view-val-first").text(report.ch1_value);
            $("#view-val-second").text(report.ch2_value);
            $("#view-val-third").text(report.ch3_value);
            break;
        case 1110:
            $('#view-label-first').show();
            $('#view-label-first').text('Val CH4');
            $('#view-val-first').text(report.ch1_value);
            break;
    }
}
function editTank(report) {
    clearfields();
    console.log('editTank');
    console.dir(report);
    $('#tank-cy-id').val(report.cy_id);
    $('#arpa-id').val(report.arpa_id);
    $('#tank-description').val(report.description);
    $('#tank-date-built').datepicker('update', report.date_built_format);
    $('#tank-date-expiry').datepicker('update', report.date_expiry_format);
    $("#tank-instrument").val(report.in_ca_id);
    $("#note").val(report.note);
    $("#delivery-note").val(report.delivery_note);
    $("#shipment-note").val(report.shipment_note);
    $("#purchase-invoice").val(report.purchase_invoice);
    $("#reversal-invoice").val(report.reversal_invoice);
    $("#payment-invoice").val(report.payment_invoice);
    $('.show-first').show();
    $('.show-second').show();
    $('.show-third').show();
    $('.show-first input').val(report.ch1_value);
    $('.show-second input').val(report.ch2_value);
    $('.show-third input').val(report.ch3_value);
    var res = report.in_ca_id;
    switch(parseInt(res)) {
        case 1000:
            $('#values-ins').show();
            $('label.show-first').text('Val SO2');
            $('.show-second').hide();
            $('.show-third').hide();
            break;
        case 1010:
            $('#values-ins').show();
            $('label.show-first').text('Val NOX');
            $('label.show-second').text('Val NO');
            $('label.show-third').text('Val NO2');
            break;
        case 1020:
            $('#values-ins').show();
            $('label.show-first').text('Val CO');
            $('.show-second').hide();
            $('.show-third').hide();
            break;
        case 1070:
            $('#values-ins').show();
            $('label.show-first').text('Val BEN');
            $('label.show-second').text('Val TOL');
            $('label.show-third').text('Val XIL');
            break;
        case 1110:
            $('#values-ins').show();
            $('label.show-first').text('Val CH4');
            $('.show-second').hide();
            $('.show-third').hide();
            break;
        default:
            $('#values-ins').hide();
            break;
    }
    if (report.exhausted) { $('#tank-exhausted').iCheck('check'); }
    if (report.returned) { $('#tank-returned').iCheck('check'); }
    if (report.is_zero) { $('#tank-iszero').iCheck('check'); }
    if (report.not_compliant) { $('#not-compliant').iCheck('check'); }
    if (report.all_stations) { $('#all-stations').iCheck('check'); }
    $("#pdf_current").hide();
    $("#pdf_to_insert").html('');
    if (report.attachment){
        var url = '<a href="uploads/files/tanks/'+report.attachment+'" target="_blank" class="text-primary pdf_download"><i class="fa fa-file-pdf-o" aria-hidden="true"></i> '+report.attachment+'</a>';
        $("#pdf_to_insert").html(url);
        $("#pdf_current").show();
    }
}
