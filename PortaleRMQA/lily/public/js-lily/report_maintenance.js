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
    $('#reportrange').data('daterangepicker').setEndDate(moment(date2));
    startDate = moment(date1).format('YYYY-MM-DD');
    endDate = moment(date2).format('YYYY-MM-DD');
}
function showReportFromGet(id) {
    $('#add-maintenance').hide();
    $( "#view-maintenance" ).show( "slow" );
    loadReport(id, 'show');
}
var userLoggedMainId;
$(document).ready(function() {
    loadMaintenanceData();
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
    $( "#refresh-list" ).click(function(e) {
        e.preventDefault();
        var selStation = $('#filter_station').val();
        $.redirectPost( "report_maintenance", {
            startDate : startDate,
            endDate : endDate,
            selStation: selStation
        } );
        return false;
    });
    $( "#download-csv" ).click(function(e) {
        e.preventDefault();
        $.redirectPost( "report_maintenance_csv", {
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
        "columns": [
            { "width": "66px" },
            { "width": "80px" },
            null,
            null,
            null,
            null,
            null,
            null,
            null
        ],
        "order": [[ 1, "desc" ]],
    });
    $('#add-maintenance').hide();
    $(".chosen-select").chosen({
        width: "100%!important",
        no_results_text: "Nessun elemento trovato!"
    });
    $('#report-date').datepicker({
        language: 'it',
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true
    });
    $('#report-date').datepicker('update', 'today');
    $('#report-time').timepicker({
        minuteStep: 5,
        showInputs: false,
        disableFocus: true,
        showMeridian: false
    });
    $('#report-time').timepicker('setTime', moment().format('HH:mm:00'));
    $( "#btn-add-maintenance" ).click(function() {
        clearFieldsEdit();
        setFieldsNewMaintenance();
        $( "#add-maintenance" ).show( "slow" );
        $( "#view-maintenance" ).hide( "slow" );
        $( "#add-maintenance .ibox-title h5" ).text("Aggiungi manutenzione");
        $( "#add-maintenance #save-report" ).text("Salva");
        $('#maintenance-form').attr('action', 'report_maintenance_new');
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
                url: 'report_maintenance_delete',
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
    $( "#table-maintenance" ).on( "click", ".set-tool", function(e) {
        e.preventDefault();
        $( "#add-maintenance" ).show( "slow" );
        $( "#view-maintenance" ).hide( "slow" );
        $('#maintenance-form').attr('action', 'report_maintenance_edit');
        $( "#add-maintenance .ibox-title h5" ).text("Modifica manutenzione");
        $( "#add-maintenance #save-report" ).text("Modifica");
        var id = $(this).parent().parent().data("id");
        console.log(id);
        loadReport(id, 'edit');
    });
    $( ".row" ).on( "click", ".pdf-tool", function(e) {
        var id = $(this).parent().parent().data("id");
        console.log('download del pdf: '+id);
        $.redirectPost( "report_maintenance_pdf", {
            id: id
        });
        e.preventDefault();
        return false;
    });
    $('#report-stations').on('change', function() {
        var stid = this.value;
        console.log(stid);
        $('#instruments-operations, #instruments-spareparts')
            .find('option')
            .remove()
            .end()
        ;
        $('#report-operations')
            .find('option')
            .remove()
            .end()
            .trigger("chosen:updated")
        ;
        $('#report-spareparts')
            .find('option')
            .remove()
            .end()
            .trigger("chosen:updated")
        ;
        var jqxhr = $.ajax({
            url: 'report_maintenance_instrument',
            type: "post",
            dataType: "json",
            data: {
                stid: stid
            },
        })
        .done(function(result) {
            console.log( "success" );
            console.dir(result.data);
            fillSelectIntruments(result.data);
        })
        .fail(function(xhr, err) {
            bootbox.alert({
                message: err,
            });
        });
    });
    $('#instruments-operations').on('change', function() {
        var arpaid = this.value;
        console.log(arpaid);
        $('#report-operations')
            .find('option')
            .remove()
            .end()
            .trigger("chosen:updated")
        ;
        var jqxhr = $.ajax({
            url: 'report_maintenance_instrument_operations',
            type: "post",
            dataType: "json",
            data: {
                arpaid: arpaid
            },
        })
        .done(function(result) {
            console.log( "success" );
            console.dir(result.data);
            fillSelectIntrumentOperations(result.data);
        })
        .fail(function(xhr, err) {
            bootbox.alert({
                message: err,
            });
        });
    });
    $('#instruments-spareparts').on('change', function() {
        var arpaid = this.value;
        console.log(arpaid);
        $('#report-spareparts')
            .find('option')
            .remove()
            .end()
            .trigger("chosen:updated")
        ;
        var jqxhr = $.ajax({
            url: 'report_maintenance_instrument_spareparts',
            type: "post",
            dataType: "json",
            data: {
                arpaid: arpaid
            },
        })
        .done(function(result) {
            console.log( "success" );
            console.dir(result.data);
            fillSelectIntrumentSpareParts(result.data);
        })
        .fail(function(xhr, err) {
            bootbox.alert({
                message: err,
            });
        });
    });
    $( "#cancel-report" ).click(function() {
        setFieldsNewMaintenance();
        $( "#add-maintenance" ).hide( "slow" );
        return false;
    });
    $( "#add-spareparts" ).click(function() {
        var instrArpaID = $("#instruments-spareparts").val();
        var instrName = $("#instruments-spareparts option:selected").text();
        var spArray = $("#report-spareparts").val();
        if ( spArray != null ) {
            $.each(spArray, function(index, value) {
                console.log(index + ': ' + value);
                var t = $("#report-spareparts option[value='"+value+"']").text();
                var r = '<tr data-arpaid="'+instrArpaID+'" data-spid="'+value+'">';
                r += '    <td class="actions">';
                r += '        <a href="" class="text-danger delete-tool"><i class="fa fa-trash"></i></a>';
                r += '        <!-- <a href=""><i class="fa fa-pencil"></i></a> -->';
                r += '    </td>';
                r += '    <td>'+instrName+'</td>';
                r += '    <td>'+t+'</td>';
                r += '    <td><a href="#" class="editor-quan" data-type="number" data-title="Quantità ricambio">1</a></td>';
                r += '</tr>';
                $("#table-spareparts tbody").append(r);
            });
        }
        updateTableSparepartsXeditables();
        return false;
    });
    $( "#delete-spareparts" ).click(function() {
        $('#table-spareparts tbody > tr').remove();
        return false;
    });
    $( "#add-operations" ).click(function() {
        var instrArpaID = $("#instruments-operations").val();
        var instrName = $("#instruments-operations option:selected").text();
        var spArray = $("#report-operations").val();
        if ( spArray == null )
            return false;
        $.each(spArray, function(index, value) {
            console.log(index + ': ' + value);
            var t = $("#report-operations option[value='"+value+"']").text();
            var r = '<tr data-arpaid="'+instrArpaID+'" data-opid="'+value+'" data-calid="">';
            r += '    <td class="actions">';
            r += '        <a href="#" class="text-danger delete-tool"><i class="fa fa-trash"></i></a>';
            r += '        <!-- <a href=""><i class="fa fa-pencil"></i></a> -->';
            r += '    </td>';
            r += '    <td>'+instrName+'</td>';
            r += '    <td>'+t+'</td>';
            r += '    <td></td>';
            r += '    <td><a href="#" class="editor-cali" data-type="select"    data-title="Inserisci ID Taratura"></a></td>';
            r += '    <td><a href="#" class="editor-date" data-type="combodate" data-title="Inserisci Scadenza Filtri"></a></td>';
            r += '    <td><a href="#" class="editor-note" data-type="textarea"  data-title="Inserisci note"></a></td>';
            r += '</tr>';
            $("#table-operations tbody").append(r);
        });
        updateTableOperationsXeditables();
        return false;
    });
    $( "#delete-operations" ).click(function() {
        $('#table-operations tbody > tr').remove();
        return false;
    });
    $( "#table-operations" ).on( "click", ".delete-tool", function(e) {
        e.preventDefault();
        var deleted = $(this).parent().parent();
        var id = $(this).parent().parent().data("id");
        console.log(id);
        console.log(deleted);
        swal({
            title: "Elimina operazione",
            text: "Sei proprio sicuro di voler eliminare l'operazione selezionata?",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Elimina",
            closeOnConfirm: false,
            cancelButtonText: "Annulla"
        }, function () {
            deleted.remove();
            swal("Eliminata", "L'operazione selezionata è stata eliminata", "success");
        });
    });
    $( "#table-spareparts" ).on( "click", ".delete-tool", function(e) {
        e.preventDefault();
        var deleted = $(this).parent().parent();
        var id = $(this).parent().parent().data("id");
        console.log(id);
        console.log(deleted);
        swal({
            title: "Elimina parte di ricambio",
            text: "Sei proprio sicuro di voler eliminare la parte di ricambio selezionata?",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Elimina",
            closeOnConfirm: false,
            cancelButtonText: "Annulla"
        }, function () {
            deleted.remove();
            swal("Eliminata", "La parte di ricambio selezionata è stata eliminata", "success");
        });
    });
    $('#view-maintenance').hide();
    $('#maintenance-form').validate({
        rules: {
            'report-stations': {
                min: 0
            },
        },
        messages: {
            'report-stations': {
                min: "Selezionare una stazione"
            },
        },
        ignore: "",
    });
    $("#maintenance-form").submit(function(event){
        if (! $('#maintenance-form').valid() ) {
            console.log('Form non valido!');
            return false;
        }
        var operationsData = JSON.stringify(getTableOperationsData());
        var input = $("<input>").attr({"type":"hidden","name":"operations"}).val(operationsData);
        $(this).append(input);
        var sparepartsData = JSON.stringify(getTableSparePartsData());
        var input = $("<input>").attr({"type":"hidden","name":"spareparts"}).val(sparepartsData);
        $(this).append(input);
        return true;
    });
    $( "#btn-close-view" ).click(function() {
        $( "#view-maintenance" ).hide( "slow" );
        return false;
    });
    $( "#table-maintenance" ).on( "click", ".view-tool", function(e) {
        var id = $(this).parent().parent().data("id");
        console.log(id);
        $('#add-maintenance').hide();
        $( "#view-maintenance" ).show( "slow" );
        loadReport(id, 'show');
        e.preventDefault(id);
        return false;
    });
    $.fn.datepicker.defaults.language = 'it';
});
function loadMaintenanceData() {
        var jqxhr = $.ajax({
            url: 'report_maintenance_data',
            type: "post",
            dataType: "json",
            data: {},
        })
        .done(function(result) {
            console.log( "success" );
            console.dir(result.data);
            fillSelectOperatorsStations(result.data);
        })
        .fail(function(xhr, err) {
            bootbox.alert({
                message: err,
            });
        });
}
function loadReport(id, dest) {
    console.log('loadReport(' + id + ' -> ' + dest + ')');
    var jqxhr = $.ajax({
        url: 'report_maintenance_get_report',
        type: "post",
        dataType: "json",
        data: { id: id },
    })
    .done(function(result) {
        if (dest == 'show')
            viewReport(result);
        if (dest == 'edit')
            editReport(result);
    })
    .fail(function(xhr, err) {
        return null;
    });
}
function viewReport(data) {
    console.log('viewReport');
    console.dir(data);
    clearFieldsView();
    $( "#view-operations-lines" ).show();
    $( "#view-spareparts-lines" ).show();
    $("#view_date_maint").html(data.report.date_format);
    $("#view_time_maint").html(data.report.time_format);
    $("#view_operator_maint").html(data.report.user_fullname);
    $("#view_station_maint").html(data.report.station_name);
    $.each(data.operations, function(key, value) {
        var ope = '<tr>';
            ope += '<td>'+value.arpa_id+'</td>';
            ope += '<td>'+value.instrument+'</td>';
            ope += '<td>'+value.description+'</td>';
            ope += '<td>'+value.frequency+'</td>';
            if (value.ca_id == null) {
                ope += '<td></td>';
            } else {
                var link = '/report_calibration?id='+value.ca_id;
                ope += '<td><a href="'+link+'" target="_blank">'+value.ca_id+'</a></td>';
            }
            if (value.filters_expdate == null)
                ope += '<td></td>';
            else
                ope += '<td>'+value.filters_expdate+'</td>';
            if (value.note == null)
                ope += '<td></td>';
            else
                ope += '<td>'+value.note+'</td>';
            ope += '</tr>';
        $( "#view_operaz_table" ).append( ope );
    });
    if( data.operations.length == 0){
        $( "#view-operations-lines" ).hide();
    }
    $.each(data.spareparts, function(key, value) {
        var parts = '<tr>';
            parts += '<td>'+value.arpa_id+'</td>';
            parts += '<td>'+value.instrument+'</td>';
            parts += '<td>'+value.description+'</td>';
            parts += '<td>'+value.quantity+'</td>';
            parts += '</tr>';
        $( "#view_parts_table" ).append( parts );
    });
    if( data.spareparts.length == 0){
        $( "#view-spareparts-lines" ).hide();
    }
    $("#view_note_maint").html(data.report.note);
}
function editReport(data) {
    console.log('editReport');
    console.dir(data);
    clearFieldsEdit();
    $('#report-maid').val(data.report.ma_id);
    $("#add-maintenance #report-date").val(data.report.date_cal);
    $("#add-maintenance #report-time").val(data.report.time_format);
    $('#add-maintenance #report-operators option[value='+data.report.us_id+']').prop('selected','selected');
    $('#add-maintenance #report-stations option[value='+data.report.st_id+']').prop('selected','selected');
    $('#report-stations').trigger('change');
    if ( data.operations != null ) {
        $.each(data.operations, function(index, value) {
            var d1 = '';
            var d2 = '';
            var d3 = '';
            if ( value.arpa_id )
                d1 = value.arpa_id;
            if ( value.op_id )
                d2 = value.op_id;
            if ( value.ca_id )
                d3 = value.ca_id;
            var r = '<tr data-arpaid="'+d1+'" data-opid="'+d2+'" data-calid="'+d3+'">';
            r += '    <td class="actions">';
            r += '        <a href="#" class="text-danger delete-tool"><i class="fa fa-trash"></i></a>';
            r += '        <!-- <a href=""><i class="fa fa-pencil"></i></a> -->';
            r += '    </td>';
            var s = '';
            if ( value.instrument )
                s = value.instrument;
            r += '    <td>'+s+'</td>';
            r += '    <td>'+value.description+'</td>';
            r += '    <td>'+value.frequency+'</td>';
            s = '';
            if ( value.calibration )
                s = value.calibration;
            r += '    <td><a href="#" class="editor-cali" data-type="select" data-title="Inserisci ID Taratura">'+s+'</a></td>';
            s = '';
            if ( value.filters_expdate )
                s = moment(value.filters_expdate).format('DD/MM/YYYY');
            r += '    <td><a href="#" class="editor-date" data-type="combodate" data-title="Inserisci Scadenza Filtri">'+s+'</a></td>';
            s = '';
            if ( value.note )
                s = value.note;
            r += '    <td><a href="#" class="editor-note" data-type="textarea"  data-title="Inserisci note">'+s+'</a></td>';
            r += '</tr>';
            $("#table-operations tbody").append(r);
        });
    }
    if ( data.spareparts != null ) {
        $.each(data.spareparts, function(index, value) {
            var d1 = '';
            var d2 = '';
            if ( value.arpa_id )
                d1 = value.arpa_id;
            if ( value.sp_id )
                d2 = value.sp_id;
            var r = '<tr data-arpaid="'+d1+'" data-spid="'+d2+'">';
            r += '    <td class="actions">';
            r += '        <a href="" class="text-danger delete-tool"><i class="fa fa-trash"></i></a>';
            r += '        <!-- <a href=""><i class="fa fa-pencil"></i></a> -->';
            r += '    </td>';
            var s = '';
            if ( value.instrument )
                s = value.instrument;
            r += '    <td>'+s+'</td>';
            s = '';
            if ( value.description )
                s = value.description;
            r += '    <td>'+s+'</td>';
            s = '';
            if ( value.quantity )
                s = value.quantity;
            r += '    <td><a href="#" class="editor-quan" data-type="number" data-title="Quantità ricambio">'+s+'</a></td>';
            r += '</tr>';
            $("#table-spareparts tbody").append(r);
        });
    }
    updateTableOperationsXeditables();
    updateTableSparepartsXeditables();
    $("#note-maintenance").html(data.report.note);
    return false;
}
function fillSelectOperatorsStations(data) {
    $.each(data.operators, function(key, value) {
        var selected = false;
        if ( value.user_logged == true ) {
            selected = true;
            userLoggedMainId = value.user_main_id;
        }
        $('#report-operators')
            .append($("<option></option>")
            .attr("value",value.user_main_id)
            .prop("selected", selected)
            .text(value.user_fullname));
    });
    $('#report-stations').append("<option value='-1'>Seleziona...</option>");
    $.each(data.stations, function(key, value) {
        $('#report-stations')
            .append($("<option></option>")
            .attr("value",value.st_id)
            .text(value.stationname));
    });
};
function fillSelectIntruments(data) {
    $('#instruments-operations').append("<option value='-1'>Seleziona...</option>");
    $('#instruments-spareparts').append("<option value='-1'>Seleziona...</option>");
    $.each(data.instruments, function(key, value) {
        var testo = value.arpa_id+" - "+value.strumento+" ["+value.costruttore+"]"+" {"+value.in_ca_id+"}";
        $('#instruments-operations')
            .append($("<option></option>")
            .attr("value",value.arpa_id)
            .attr("data-id",value.in_ca_id)
            .text(testo));
        $('#instruments-spareparts')
            .append($("<option></option>")
            .attr("value",value.arpa_id)
            .attr("data-id",value.in_ca_id)
            .text(testo));
    });
};
function fillSelectIntrumentOperations(data) {
    console.dir(data);
    $.each(data.operations, function(key, value) {
        $('#report-operations')
            .append($("<option></option>")
            .attr("value",value.op_id)
            .text(value.description));
    });
    $('#report-operations').trigger("chosen:updated");
};
function fillSelectIntrumentSpareParts(data) {
    $.each(data.spareparts, function(key, value) {
        $('#report-spareparts')
            .append($("<option></option>")
            .attr("value",value.sp_id)
            .text(value.description));
    });
    $('#report-spareparts').trigger("chosen:updated");
};
function setFieldsNewMaintenance(){
    $( "#add-maintenance .ibox-title h5" ).text("Aggiungi manutenzione");
    $( "#add-maintenance #save_calib" ).text("Salva");
};
function clearFieldsEdit(){
    $('#report-date').datepicker('update', 'today');
    $('#report-time').timepicker('setTime', moment().format('HH:mm:00'));
    $('#report-operators option[value='+userLoggedMainId+']').prop('selected','selected');
    $('#report-stations option[value="-1"]').prop('selected','selected');
    $('#instruments-operations')
        .find('option')
        .remove()
        .end()
    ;
    $('#instruments-spareparts option[value="-1"]').prop('selected','selected');
    $('#instruments-spareparts')
        .find('option')
        .remove()
        .end()
    ;
    $('#instruments-spareparts option[value="-1"]').prop('selected','selected');
    $('#report-operations')
        .find('option')
        .remove()
        .end()
        .trigger("chosen:updated")
    ;
    $('#report-spareparts')
        .find('option')
        .remove()
        .end()
        .trigger("chosen:updated")
    ;
    $('#table-operations tbody > tr').remove();
    $('#table-spareparts tbody > tr').remove();
}
function clearFieldsView(){
    $('#view_operaz_table > tr').remove();
    $('#view_parts_table > tr').remove();
    $('#view_date_maint').text('');
    $('#view_time_maint').text('');
    $('#view_operator_maint').text('');
    $('#view_station_maint').text('');
}
function getTableOperationsData() {
    var tableObject = $('#table-operations tbody tr').map(function(i) {
        var $row = $(this);
        return {
            arid: $row.data('arpaid'),
            opid: $row.data('opid'),
            caid: $row.data('calid'),
            date: $row.find(':nth-child(6)').text(),
            note: $row.find(':nth-child(7)').text()
        };
    }).get();
    console.dir(tableObject);
    return tableObject;
}
function getTableSparePartsData() {
    var tableObject = $('#table-spareparts tbody tr').map(function(i) {
        var $row = $(this);
        return {
            arid: $row.data('arpaid'),
            spid: $row.data('spid'),
            quan: $row.find(':nth-child(4)').text()
        };
    }).get();
    console.dir(tableObject);
    return tableObject;
}
function updateTableSparepartsXeditables() {
    $("#report-spareparts").val('');
    $("#report-spareparts").trigger("chosen:updated");
    $('.editor-quan').editable({
        placement: 'left',
        inputclass: 'editor-quan-css',
        emptytext: 'Vuoto'
    });
}
function updateTableOperationsXeditables() {
    $("#report-operations").val('');
    $("#report-operations").trigger("chosen:updated");
    $('#table-operations').on('change keyup blur', ".editor-cali-css", function(){
        var calibid = $(this).val();
        console.log(calibid);
        $(this).closest( "tr" ).attr('data-calid', calibid);
    }).blur();
    $('.editor-cali').editable({
        placement: 'left',
        inputclass: 'editor-cali-css',
        emptytext: 'Vuoto',
        source: function() {
            var result;
            var stid = $("#report-stations").val();
            console.log('source: '+stid);
            $.ajax({
                url: 'report_maintenance_calibrations_latest',
                data: {
                    stid: stid
                },
                type: 'POST',
                global: false,
                async: false,
                dataType: 'json',
                success: function(data) {
                    console.dir(data);
                    var calibrations = jQuery.parseJSON(data.data);
                    result = calibrations;
                }
            });
            return result;
        }
    });
    $('.editor-date').editable({
        placement: 'left',
        inputclass: 'editor-date-css',
        emptytext: 'Vuoto',
        format: 'YYYY-MM-DD',
        viewformat: 'DD/MM/YYYY',
        template: 'DD / MM / YYYY',
        combodate: {
            minYear: moment().subtract(1, 'year').format('YYYY'),
            maxYear: moment().add(1, 'year').format('YYYY')
        }
    });
    $('.editor-note').editable({
        placement: 'left',
        inputclass: 'editor-note-css',
        emptytext: 'Vuoto'
    });
}
