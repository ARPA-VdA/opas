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
    $('#reportrange span').html(moment(date1).format('DD.MM.YY') + ' - ' + moment(date2).format('DD.MM.YY'));
    $('#reportrange').data('daterangepicker').setStartDate(moment(date1));
    $('#reportrange').data('daterangepicker').setEndDate( moment(date2));
    startDate = moment(date1).format('YYYY-MM-DD');
    endDate = moment(date2).format('YYYY-MM-DD');
}
function showReportFromGet(id) {
    loadReport(id, 'show');
    $('#add-calibration').hide();
    $( "#view-calibration" ).show( "slow" );
}
var editIntrumentID;
var editZeroTankID;
var editSpanTankID;
var userLoggedMainId;
$(document).ready(function() {
    $('#add-calibration').hide();
    $('#view-calibration').hide();
    $('#reportrange').daterangepicker({
        format: 'DD/MM/YYYY',
        startDate: moment().subtract(29, 'days'),
        endDate: moment(),
        minDate: moment("2010-10-01", "YYYY-MM-DD"),
        maxDate: moment(),
        dateLimit: { days: 744 },
        showDropdowns: true,
        showWeekNumbers: true,
        timePicker: false,
        timePickerIncrement: 1,
        timePicker12Hour: true,
        ranges: {
            'Oggi': [moment(), moment()],
            'Ieri': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            'Ultimi 7 Giorni': [moment().subtract(6, 'days'), moment()],
            'Ultimo Mese': [moment().subtract(29, 'days'), moment()],
            'Ultimi 2 Mesi': [moment().subtract(58, 'days'), moment()],
            'Ultimi 6 Mesi': [moment().subtract(174, 'days'), moment()],
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
    jQuery.validator.addMethod("greaterThanZero", function(value, element) {
        return this.optional(element) || (value != '-1');
    });
    $('#calibration-form').validate({
        rules: {
            station_calib: {
                required: true,
                min: 0
            },
            instrument_calib: {
                required: true,
                greaterThanZero: true
            },
        },
        messages: {
            station_calib: {
                min: "Selezionare una stazione"
            },
            instrument_calib: {
                greaterThanZero: "Selezionare uno strumento"
            },
        },
        ignore: "",
    });
    $("#calibration-form").submit(function(event){
        if (! $('#calibration-form').valid() ) {
            console.log('Form non valido!');
            return false;
        }
        var id = 0;
        switch ( parseInt(id) ) {
            case 1000:
                break;
            case 1010:
                break;
            case 1020:
                break;
            case 1030:
                break;
            case 1070:
                break;
            case 1040:
            case 1090:
            case 1100:
                break;
            case 1110:
                break;
        }
        return true;
    });
    loadCalibrationData();
    $( "#refresh-list" ).click(function(e) {
        e.preventDefault();
        var selStation = $('#filter_station').val();
        var selInstrument = $('#filter_instrument').val();
        $.redirectPost( "report_calibration", {
            startDate : startDate,
            endDate : endDate,
            selStation : selStation,
            selInstrument: selInstrument
        } );
        return false;
    });
    $( "#download-csv" ).click(function(e) {
        e.preventDefault();
        $.redirectPost( "report_calibration_csv", {
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
            { 'bSortable': false, 'aTargets': [ 2 ] },
            { "sWidth": "66px", "aTargets": [ 0 ] }
        ],
        "order": [[ 1, "desc" ]]
    });
    $( "#btn-add-calibration" ).click(function() {
        $('#view-calibration').hide();
        clearFieldsEdit();
        setFieldsNewCalibration();
        hideInstruments();
        $( "#add-calibration" ).show( "slow" );
        $('#calibration-form').attr('action', 'report_calibration_new');
        $('#report-caid').val('');
    });
    $('#date_calib').datepicker({
        language: 'it',
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true
    });
    $('#date_calib').datepicker('update', 'today');
    $('#time_calib').timepicker({
        minuteStep: 5,
        showInputs: false,
        disableFocus: true,
        showMeridian: false
    });
    $('#time_calib').timepicker('setTime', moment().format('HH:mm:00'));
    $( "#add-calibration" ).on( "click", "#api200_add", function(e) {
        $('#api200_multiple_cal').toggle("slow");
        $('#api200_add i').toggleClass( "fa-plus-circle" );
        $('#api200_add i').toggleClass( "fa-minus-circle" );
    });
    $( "#add-calibration" ).on( "click", "#api400_add", function(e) {
        $('#api400_multiple_cal').toggle("slow");
        $('#api400_add i').toggleClass( "fa-plus-circle" );
        $('#api400_add i').toggleClass( "fa-minus-circle" );
        if($('#limit-value-label b').text() == "400"){
            $('#limit-value-label b').text("100");
        }else{
            $('#limit-value-label b').text("400");
        };
    });
    $('#station_calib').on('change', function() {
        var stid = this.value;
        console.log(stid);
        $('#instrument_calib')
            .find('option')
            .remove()
            .end()
        ;
        var jqxhr = $.ajax({
            url: 'report_calibration_instrument',
            type: "post",
            dataType: "json",
            data: {
                stid: stid
            },
        })
        .done(function(result) {
            console.log( "success" );
            console.dir(result.data);
            fillSelectStationIntrumentsTanks(result.data);
            if (editIntrumentID != null)
                selectInstrumentEditMode();
            editIntrumentID = null;
        })
        .fail(function(xhr, err) {
            bootbox.alert({
                message: err,
            });
        });
    });
    $('#instrument_calib').on('change', function() {
        var arpa_id = $(this).value;
        console.log(arpa_id);
        var in_ca_id = $(this).find(':selected').data('id');
        console.log(in_ca_id);
        hideInstruments();
        showInstrument(in_ca_id);
    });
    $('.tanks_span').on('change', function() {
        var ch1 = $(this).find(':selected').data('ch1');
        var ch2 = $(this).find(':selected').data('ch2');
        var ch3 = $(this).find(':selected').data('ch3');
        var in_ca_id = $("#instrument_calib").find(':selected').data('id');
        switch ( parseInt(in_ca_id) ) {
            case 1000:
                $("#theory_span_api100").val(ch1);
                break;
            case 1010:
                $("#l1_theory_nox_span_api200").val(ch1);
                $("#l1_theory_no_span_api200").val(ch2);
                $("#l1_theory_no2_span_api200").val(ch3);
                break;
            case 1020:
                $("#theory_span_api300").val(ch1);
                break;
            case 1030:
                break;
            case 1070:
                $("#theory_ben_span_gc955").val(ch1);
                $("#theory_tol_span_gc955").val(ch2);
                $("#theory_xil_span_gc955").val(ch3);
                break;
            case 1040:
            case 1090:
            case 1100:
                break;
            case 1110:
                $("#theory_span_ch4").val(ch1);
                break;
        }
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
                url: 'report_calibration_delete',
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
    $( ".row" ).on( "click", ".set-tool", function(e) {
        console.log('"click", ".set-tool"');
        var id = $(this).parent().parent().data("id");
        $('#view-calibration').hide();
        $( "#add-calibration" ).show( "slow" );
        setFieldsEditCalibration()
        $('#calibration-form').attr('action', 'report_calibration_edit');
        loadReport(id, 'edit');
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".pdf-tool", function(e) {
        var id = $(this).parent().parent().data("id");
        console.log('download del pdf: '+id);
        $.redirectPost( "report_calibration_pdf", {
            id: id
        });
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".view-tool", function(e) {
        console.log('"click", ".view-tool"');
        $('#add-calibration').hide();
        $( "#view-calibration" ).show( "slow" );
        setFieldsEditCalibration()
        var id = $(this).parent().parent().data("id");
        loadReport(id, 'show');
        e.preventDefault();
        return false;
    });
    $( "#cancel_calib" ).click(function() {
        setFieldsNewCalibration();
        $( "#add-calibration" ).hide( "slow" );
        return false;
    });
    $( "#btn-close-view" ).click(function() {
        $( "#view-calibration" ).hide( "slow" );
        return false;
    });
    $.fn.datepicker.defaults.language = 'it';
});
function loadCalibrationData() {
    var jqxhr = $.ajax({
        url: 'report_calibration_data',
        type: "post",
        dataType: "json",
        data: {},
    })
    .done(function(result) {
        fillCalibrationData(result.data);
    })
    .fail(function(xhr, err) {
        bootbox.alert({
            message: err,
        });
    });
}
function fillCalibrationData(data) {
    console.log( "fillCalibrationData" );
    $('#operator_calib, #station_calib, #reason_calib, .methods_zero, .methods_span')
        .find('option')
        .remove()
        .end()
    ;
    $('#station_calib').append("<option value='-1'>Seleziona...</option>");
    $.each(data.operators, function(key, value) {
        var selected = false;
        if ( value.user_logged == true ) {
            selected = true;
            userLoggedMainId = value.user_main_id;
        }
        $('#operator_calib')
            .append($("<option></option>")
            .attr("value",value.user_main_id)
            .prop("selected", selected)
            .text(value.user_fullname));
    });
    $.each(data.stations, function(key, value) {
        $('#station_calib')
            .append($("<option></option>")
            .attr("value",value.st_id)
            .text(value.stationname));
    });
    $.each(data.reasons, function(key, value) {
        $('#reason_calib')
            .append($("<option></option>")
            .attr("value",value.re_id)
            .text(value.reason_desc));
    });
    $.each(data.methods_zero, function(key, value) {
        $('.methods_zero')
            .append($("<option></option>")
            .attr("value",value.me_id)
            .text(value.method_desc));
    });
    $.each(data.methods_span, function(key, value) {
        $('.methods_span')
            .append($("<option></option>")
            .attr("value",value.me_id)
            .text(value.method_desc));
    });
    $.each(data.calibrators, function(key, value) {
        var testo = value.arpa_id+" - "+value.strumento+" ["+value.costruttore+"]";
        $('.calibrators')
            .append($("<option></option>")
            .attr("value",value.arpa_id)
            .text(testo));
    });
};
function fillSelectStationIntrumentsTanks(data) {
    console.log( "fillSelectStationIntrumentsTanks" );
    $('#instrument_calib, #tank_zero_api100, .tanks_span')
        .find('option')
        .remove()
        .end()
    ;
    $('#instrument_calib').append("<option value='-1'>Seleziona...</option>");
    $.each(data.instruments, function(key, value) {
        var testo = value.arpa_id+" - "+value.strumento+" ["+value.costruttore+"]"+" {"+value.in_ca_id+"}";
        $('#instrument_calib')
            .append($("<option></option>")
            .attr("value",value.arpa_id)
            .attr("data-id",value.in_ca_id)
            .text(testo));
    });
    $('#tank_zero_api100').append("<option value='-1'>Seleziona...</option>");
    $.each(data.tanks_zero, function(key, value) {
        var testo = value.description+", ["+value.arpa_id+"], {"+value.tank_values+"}";
        $('#tank_zero_api100')
            .append($("<option></option>")
            .attr("value",value.arpa_id)
            .text(testo));
    });
    $('.tanks_span').append("<option value='-1'>Seleziona...</option>");
    $.each(data.tanks_span, function(key, value) {
        var testo = value.description+", ["+value.arpa_id+"], {"+value.tank_values+"}";
        $('.tanks_span')
            .append($("<option></option>")
            .attr("value",value.arpa_id)
            .attr("data-ch1",value.ch1_value)
            .attr("data-ch2",value.ch2_value)
            .attr("data-ch3",value.ch3_value)
            .text(testo));
    });
};
function loadReport(id, dest) {
    console.log('loadReport(' + id + ' -> ' + dest + ')');
    var jqxhr = $.ajax({
        url: 'report_calibration_get_report',
        type: "post",
        dataType: "json",
        data: { id: id },
    })
    .done(function(result) {
        if (dest == 'show')
            viewReport(result.report);
        if (dest == 'edit')
            editReport(result.report);
    })
    .fail(function(xhr, err) {
        return null;
    });
}
function setFieldsNewCalibration(){
    $( "#add-calibration .ibox-title h5" ).text("Aggiungi taratura");
    $( "#add-calibration #save_calib" ).text("Salva");
};
function hideInstruments() {
    $("#api100").hide();
    $("#api200").hide();
    $("#api300").hide();
    $("#api400").hide();
    $("#syntechgc955").hide();
    $("#sampler").hide();
    $("#ch4").hide();
}
function showInstrument( id ) {
    switch ( parseInt(id) ) {
        case 1000:
            $("#api100").show();
            break;
        case 1010:
            $("#api200").show();
            break;
        case 1020:
            $("#api300").show();
            break;
        case 1030:
            $("#api400").show();
            break;
        case 1070:
            $("#syntechgc955").show();
            break;
        case 1040:
        case 1090:
        case 1100:
            $("#sampler").show();
            break;
        case 1110:
            $("#ch4").show();
            break;
    }
}
function setFieldsEditCalibration(){
    $( "#add-calibration .ibox-title h5" ).text("Modifica taratura");
    $( "#add-calibration #save_calib" ).text("Modifica");
}
function hideBlocksEdit() {
    $("#api100").hide();
    $("#api200").hide();
    $("#api300").hide();
    $("#api400").hide();
    $("#syntechgc955").hide();
    $("#sampler").hide();
    $("#ch4").hide();
}
function clearFieldsEdit(){
    $('#date_calib').datepicker('update', 'today');
    $('#time_calib').timepicker('setTime', moment().format('HH:mm:00'));
    $('#operator_calib option[value='+userLoggedMainId+']').prop('selected','selected');
    $('#station_calib option[value="-1"]').prop('selected','selected');
    $('#instrument_calib')
        .find('option')
        .remove()
        .end()
    ;
    $('#instrument_calib option[value="-1"]').prop('selected','selected');
    $('#reason_calib option[value="-1"]').prop('selected','selected');
    $("#notes_calib").empty();
    $('.i-checks').iCheck('uncheck');
    $("#find_zero_api100").val('');
    $('#tank_zero_api100 option[value="-1"]').prop('selected','selected');
    $('#method_zero_api100 option[value="-1"]').prop('selected','selected');
    $('#tank_span_api100 option[value="-1"]').prop('selected','selected');
    $('#method_span_api100 option[value="-1"]').prop('selected','selected');
    $("#read_span_api100").val('');
    $("#theory_span_api100").val('');
    $("#nox_zero_api200").val('');
    $("#no_zero_api200").val('');
    $("#no2_zero_api200").val('');
    $('#method_zero_api200 option[value="-1"]').prop('selected','selected');
    $('#tank_span_api200 option[value="-1"]').prop('selected','selected');
    $('#method_span_api200 option[value="-1"]').prop('selected','selected');
    $("#l1_read_nox_span_api200").val('');
    $("#l1_read_no_span_api200").val('');
    $("#l1_read_no2_span_api200").val('');
    $("#l1_theory_nox_span_api200").val('');
    $("#l1_theory_no_span_api200").val('');
    $("#l1_theory_no2_span_api200").val('');
    $("#find_zero_api300").val('');
    $('#method_zero_api300 option[value="-1"]').prop('selected','selected');
    $('#tank_span_api300 option[value="-1"]').prop('selected','selected');
    $('#method_span_api300 option[value="-1"]').prop('selected','selected');
    $("#read_span_api300").val('');
    $("#theory_span_api300").val('');
    $("#find_zero_api400").val('');
    $('#method_zero_api400 option[value="-1"]').prop('selected','selected');
    $('#calib_span_api400 option[value="-1"]').prop('selected','selected');
    $('#method_span_api400 option[value="-1"]').prop('selected','selected');
    $("#100_read_span_api400").val('');
    $("#100_theory_span_api400").val('');
    $("#200_read_span_api400").val('');
    $("#200_theory_span_api400").val('');
    $("#300_read_span_api400").val('');
    $("#300_theory_span_api400").val('');
    $("#400_read_span_api400").val('');
    $("#400_theory_span_api400").val('');
    $("#500_read_span_api400").val('');
    $("#500_theory_span_api400").val('');
    $('#tank_span_gc955 option[value="-1"]').prop('selected','selected');
    $('#method_span_gc955 option[value="-1"]').prop('selected','selected');
    $("#read_ben_span_gc955").val('');
    $("#read_tol_span_gc955").val('');
    $("#read_xil_span_gc955").val('');
    $("#theory_ben_span_gc955").val('');
    $("#theory_tol_span_gc955").val('');
    $("#theory_xil_span_gc955").val('');
    $("#read_flow_sampler").val('');
    $("#reference_flow_sampler").val('');
    $("#temp_flow_sampler").val('');
    $("#press_flow_sampler").val('');
    $("#find_zero_ch4").val('');
    $('#method_zero_ch4 option[value="-1"]').prop('selected','selected');
    $('#tank_span_ch4 option[value="-1"]').prop('selected','selected');
    $('#method_span_ch4 option[value="-1"]').prop('selected','selected');
    $("#read_span_ch4").val('');
    $("#theory_span_ch4").val('');
};
function selectInstrumentEditMode() {
    console.log('selectInstrumentEditMode -> '+editIntrumentID);
    $('#instrument_calib option[value='+editIntrumentID+']').prop('selected','selected')
    $('#instrument_calib').trigger('change');
    $('#tank_zero_api100 option[value="'+editZeroTankID+'"]').prop('selected','selected');
    $('#tank_span_api100 option[value="'+editSpanTankID+'"]').prop('selected','selected');
    $('#tank_span_api200 option[value="'+editSpanTankID+'"]').prop('selected','selected');
    $('#tank_span_api300 option[value="'+editSpanTankID+'"]').prop('selected','selected');
    $('#tank_span_ch4 option[value="'+editSpanTankID+'"]').prop('selected','selected');
    $('#tank_span_gc955 option[value="'+editSpanTankID+'"]').prop('selected','selected');
}
function editReport(report) {
    console.log('editReport');
    console.dir(report);
    hideBlocksEdit();
    clearFieldsEdit();
    $('#report-caid').val(report.ca_id);
    $('#date_calib').val(report.date_cal);
    $('#time_calib').val(report.time_format);
    $('#operator_calib option[value='+report.us_id+']').prop('selected','selected');
    $('#station_calib option[value='+report.st_id+']').prop('selected','selected');
    $('#station_calib').trigger('change');
    editIntrumentID = report.instrument_arpa_id;
    editZeroTankID = report.tank_zero_cyl_arpa_id;
    editSpanTankID = report.tank_span_cyl_arpa_id;
    $('#reason_calib option[value='+report.re_id+']').prop('selected','selected');
    $("#notes_calib").html(report.note);
    switch ( parseInt(report.instrument_in_ca_id) ) {
        case 1000:
            console.log('api100');
            $("#api100").show();
            $("#find_zero_api100").val(report.zero_found);
            if (report.zero_changed) { $('#mod_zero_api100').iCheck('check'); }
            $('#method_zero_api100 option[value="'+report.zero_me_id+'"]').prop('selected','selected');
            $('#method_span_api100 option[value="'+report.span_me_id+'"]').prop('selected','selected');
            $("#read_span_api100").val(report.span_found);
            $("#theory_span_api100").val(report.span_set);
            if (report.span_changed) { $('#mod_span_api100').iCheck('check'); }
            break;
        case 1010:
            $("#api200").show();
            $("#nox_zero_api200").val(report.zero_found);
            $("#no_zero_api200").val(report.zero_found2);
            $("#no2_zero_api200").val(report.zero_found3);
            if (report.zero_changed) { $('#mod_zero_api200').iCheck('check'); }
            $('#method_zero_api200 option[value="'+report.zero_me_id+'"]').prop('selected','selected');
            $('#method_span_api200 option[value="'+report.span_me_id+'"]').prop('selected','selected');
            $("#l1_read_nox_span_api200").val(report.span_found);
            $("#l1_read_no_span_api200").val(report.span_found2);
            $("#l1_read_no2_span_api200").val(report.span_found3);
            $("#l1_theory_nox_span_api200").val(report.span_set);
            $("#l1_theory_no_span_api200").val(report.span_set2);
            $("#l1_theory_no2_span_api200").val(report.span_set3);
            if (report.span_changed) { $('#mod_span_api200').iCheck('check'); }
            break;
        case 1020:
            $("#api300").show();
            $("#find_zero_api300").val(report.zero_found);
            $('#method_zero_api300 option[value="'+report.zero_me_id+'"]').prop('selected','selected');
            if (report.zero_changed) { $('#mod_zero_api300').iCheck('check'); }
            $('#method_span_api300 option[value="'+report.span_me_id+'"]').prop('selected','selected');
            $("#read_span_api300").val(report.span_found);
            $("#theory_span_api300").val(report.span_set);
            if (report.span_changed) { $('#mod_span_api300').iCheck('check'); }
            break;
        case 1030:
            $("#api400").show();
            $("#find_zero_api400").val(report.zero_found);
            $('#method_zero_api400 option[value="'+report.zero_me_id+'"]').prop('selected','selected');
            if (report.zero_changed) { $('#mod_zero_api400').iCheck('check'); }
            $('#calib_span_api400 option[value="'+report.calibrator_arpa_id+'"]').prop('selected','selected');
            $('#method_span_api400 option[value="'+report.span_me_id+'"]').prop('selected','selected');
            $("#100_read_span_api400").val(report.span_found);
            $("#100_theory_span_api400").val(report.span_set);
            if (report.span_changed) { $('#mod_span_api400').iCheck('check'); }
            break;
        case 1070:
            $("#syntechgc955").show();
            $('#method_span_gc955 option[value="'+report.span_me_id+'"]').prop('selected','selected');
            $("#read_ben_span_gc955").val(report.span_found);
            $("#read_tol_span_gc955").val(report.span_found2);
            $("#read_xil_span_gc955").val(report.span_found3);
            $("#theory_ben_span_gc955").val(report.span_set);
            $("#theory_tol_span_gc955").val(report.span_set2);
            $("#theory_xil_span_gc955").val(report.span_set3);
            if (report.span_changed) { $('#mod_span_gc955').iCheck('check'); }
            break;
        case 1040:
        case 1090:
        case 1100:
            $("#sampler").show();
            $("#read_flow_sampler").val(report.span_found);
            $("#reference_flow_sampler").val(report.span_set);
            $("#temp_flow_sampler").val(report.temperature);
            $("#press_flow_sampler").val(report.presssure);
            if (report.flux_changed) { $('#mod_flow_sampler').iCheck('check'); }
            break;
        case 1110:
            $("#ch4").show();
            $("#find_zero_ch4").val(report.zero_found);
            $('#method_zero_ch4 option[value="'+report.zero_me_id+'"]').prop('selected','selected');
            if (report.zero_changed) { $('#mod_zero_ch4').iCheck('check'); }
            $('#method_span_ch4 option[value="'+report.span_me_id+'"]').prop('selected','selected');
            $("#read_span_ch4").val(report.span_found);
            $("#theory_span_ch4").val(report.span_set);
            if (report.span_changed) { $('#mod_span_ch4').iCheck('check'); }
            break;
    }
    return false;
}
function hideBlocksView() {
    $("#view-api100").hide();
    $("#view-api200").hide();
    $("#view-api300").hide();
    $("#view-api400").hide();
    $("#view-syntechgc955").hide();
    $("#view-sampler").hide();
    $("#view-ch4").hide();
}
function clearFieldsView(){
    $("#view_date_calib").empty();
    $("#view_time_calib").empty();
    $("#view_operator_calib").empty();
    $("#view_station_calib").empty();
    $("#view_instrument_calib").empty();
    $("#view_reason_calib").empty();
    $("#view_notes_calib").empty();
    $("#view_find_zero_api100").empty();
    $("#view_mod_zero_api100").empty();
    $("#view_tank_zero_api100").empty();
    $("#view_method_zero_api100").empty();
    $("#view_tank_span_api100").empty();
    $("#view_method_span_api100").empty();
    $("#view_read_span_api100").empty();
    $("#view_theory_span_api100").empty();
    $("#view_mod_span_api100").empty();
    $("#view_nox_zero_api200").empty();
    $("#view_no_zero_api200").empty();
    $("#view_no2_zero_api200").empty();
    $("#view_mod_zero_api200").empty();
    $("#view_method_zero_api200").empty();
    $("#view_tank_span_api200").empty();
    $("#view_method_span_api200").empty();
    $("#view_l1_read_nox_span_api200").empty();
    $("#view_l1_read_no_span_api200").empty();
    $("#view_l1_read_no2_span_api200").empty();
    $("#view_l1_theory_nox_span_api200").empty();
    $("#view_l1_theory_no_span_api200").empty();
    $("#view_l1_theory_no2_span_api200").empty();
    $("#view_mod_span_api200").empty();
    $("#view_find_zero_api300").empty();
    $("#view_method_zero_api300").empty();
    $("#view_mod_zero_api300").empty();
    $("#view_tank_span_api300").empty();
    $("#view_method_span_api300").empty();
    $("#view_read_span_api300").empty();
    $("#view_theory_span_api300").empty();
    $("#view_mod_span_api300").empty();
    $("#view_find_zero_api400").empty();
    $("#view_method_zero_api400").empty();
    $("#view_mod_zero_api400").empty();
    $("#view_calib_span_api400").empty();
    $("#view_method_span_api400").empty();
    $("#view_100_read_span_api400").empty();
    $("#view_100_theory_span_api400").empty();
    $("#view_200_read_span_api400").empty();
    $("#view_200_theory_span_api400").empty();
    $("#view_300_read_span_api400").empty();
    $("#view_300_theory_span_api400").empty();
    $("#view_400_read_span_api400").empty();
    $("#view_400_theory_span_api400").empty();
    $("#view_500_read_span_api400").empty();
    $("#view_500_theory_span_api400").empty();
    $("#view_mod_span_api400").empty();
    $("#view_tank_span_gc955").empty();
    $("#view_method_span_gc955").empty();
    $("#view_read_ben_span_gc955").empty();
    $("#view_read_tol_span_gc955").empty();
    $("#view_read_xil_span_gc955").empty();
    $("#view_theory_ben_span_gc955").empty();
    $("#view_theory_tol_span_gc955").empty();
    $("#view_theory_xil_span_gc955").empty();
    $("#view_mod_span_syntechgc955").empty();
    $("#view_read_flow_sampler").empty();
    $("#view_reference_flow_sampler").empty();
    $("#view_temp_flow_sampler").empty();
    $("#view_press_flow_sampler").empty();
    $("#view_mod_flow_sampler").empty();
    $("#view_find_zero_ch4").empty();
    $("#view_method_zero_ch4").empty();
    $("#view_mod_zero_ch4").empty();
    $("#view_tank_span_ch4").empty();
    $("#view_method_span_ch4").empty();
    $("#view_read_span_ch4").empty();
    $("#view_theory_span_ch4").empty();
    $("#view_mod_span_ch4").empty();
};
function viewReport(report) {
    console.log('viewReport');
    console.dir(report);
    hideBlocksView();
    clearFieldsView();
    $("#view_date_calib").html(report.date_format);
    $("#view_time_calib").html(report.time_format);
    $("#view_operator_calib").html(report.user_fullname);
    $("#view_station_calib").html(report.station_name);
    $("#view_instrument_calib").html(report.instrument_name);
    $("#view_reason_calib").html(report.reason_description);
    $("#view_notes_calib").html(report.note);
    switch ( parseInt(report.instrument_in_ca_id) ) {
        case 1000:
            $("#view-api100").show();
            $("#view_find_zero_api100").html(report.zero_found);
            $("#view_mod_zero_api100").html(report.zero_changed);
            $("#view_tank_zero_api100").html(report.tank_zero_description);
            $("#view_method_zero_api100").html(report.zero_method_description);
            $("#view_tank_span_api100").html(report.tank_span_description);
            $("#view_method_span_api100").html(report.span_method_description);
            $("#view_read_span_api100").html(report.span_found);
            $("#view_theory_span_api100").html(report.span_set);
            $("#view_mod_span_api100").html(report.span_changed);
            break;
        case 1010:
            $("#view-api200").show();
            $("#view_nox_zero_api200").html(report.zero_found);
            $("#view_no_zero_api200").html(report.zero_found2);
            $("#view_no2_zero_api200").html(report.zero_found3);
            $("#view_mod_zero_api200").html(report.zero_changed);
            $("#view_method_zero_api200").html(report.zero_method_description);
            $("#view_tank_span_api200").html(report.tank_span_description);
            $("#view_method_span_api200").html(report.span_method_description);
            $("#view_l1_read_nox_span_api200").html(report.span_found);
            $("#view_l1_read_no_span_api200").html(report.span_found2);
            $("#view_l1_read_no2_span_api200").html(report.span_found3);
            $("#view_l1_theory_nox_span_api200").html(report.span_set);
            $("#view_l1_theory_no_span_api200").html(report.span_set2);
            $("#view_l1_theory_no2_span_api200").html(report.span_set3);
            $("#view_mod_span_api200").html(report.span_changed);
            break;
        case 1020:
            $("#view-api300").show();
            $("#view_find_zero_api300").html(report.zero_found);
            $("#view_method_zero_api300").html(report.zero_method_description);
            $("#view_mod_zero_api300").html(report.zero_changed);
            $("#view_tank_span_api300").html(report.tank_span_description);
            $("#view_method_span_api300").html(report.span_method_description);
            $("#view_read_span_api300").html(report.span_found);
            $("#view_theory_span_api300").html(report.span_set);
            $("#view_mod_span_api300").html(report.span_changed);
            break;
        case 1030:
            $("#view-api400").show();
            $("#view_find_zero_api400").html(report.zero_found);
            $("#view_method_zero_api400").html(report.zero_method_description);
            $("#view_mod_zero_api400").html(report.zero_changed);
            $("#view_calib_span_api400").html(report.calibrator_name);
            $("#view_method_span_api400").html(report.span_method_description);
            $("#view_100_read_span_api400").html(report.span_found);
            $("#view_100_theory_span_api400").html(report.span_set);
            $("#view_200_read_span_api400").html(report.span_found1);
            $("#view_200_theory_span_api400").html(report.span_set1);
            $("#view_300_read_span_api400").html(report.span_found2);
            $("#view_300_theory_span_api400").html(report.span_set2);
            $("#view_400_read_span_api400").html(report.span_found3);
            $("#view_400_theory_span_api400").html(report.span_set3);
            $("#view_500_read_span_api400").html(report.span_found4);
            $("#view_500_theory_span_api400").html(report.span_set4);
            $("#view_mod_span_api400").html(report.span_changed);
            break;
        case 1070:
            $("#view-syntechgc955").show();
            $("#view_tank_span_gc955").html(report.tank_span_description);
            $("#view_method_span_gc955").html(report.span_method_description);
            $("#view_read_ben_span_gc955").html(report.span_found);
            $("#view_read_tol_span_gc955").html(report.span_found2);
            $("#view_read_xil_span_gc955").html(report.span_found3);
            $("#view_theory_ben_span_gc955").html(report.span_set);
            $("#view_theory_tol_span_gc955").html(report.span_set2);
            $("#view_theory_xil_span_gc955").html(report.span_set3);
            $("#view_mod_span_syntechgc955").html(report.span_changed);
            break;
        case 1040:
        case 1090:
        case 1100:
            $("#view-sampler").show();
            $("#view_read_flow_sampler").html(report.span_found);
            $("#view_reference_flow_sampler").html(report.span_set);
            $("#view_temp_flow_sampler").html(report.temperature);
            $("#view_press_flow_sampler").html(report.presssure);
            $("#view_mod_flow_sampler").html(report.flux_changed);
            break;
        case 1110:
            $("#view-ch4").show();
            $("#view_find_zero_ch4").html(report.zero_found);
            $("#view_method_zero_ch4").html(report.zero_method_description);
            $("#view_mod_zero_ch4").html(report.zero_changed);
            $("#view_tank_span_ch4").html(report.tank_span_description);
            $("#view_method_span_ch4").html(report.span_method_description);
            $("#view_read_span_ch4").html(report.span_found);
            $("#view_theory_span_ch4").html(report.span_set);
            $("#view_mod_span_ch4").html(report.span_changed);
            break;
    }
    return false;
}
