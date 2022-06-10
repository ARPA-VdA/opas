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
            { 'bSortable': false, 'aTargets': [ 0 , 6 ] },
            { "sWidth": "50px", "aTargets": [ 0 ] }
        ],
    });
    $( "#refresh-list" ).click(function(e) {
        e.preventDefault();
        var selPrel = $('#filter_prel').val();
        var selAnalysis = $('#filter_analysis').val();
        var selStations = $('#filter_stations').val();
        var sampleFrom = $('#sample-id-from').val();
        var sampleTo = $('#sample-id-to').val();
        $.redirectPost( "labanalisys_sample", {
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
        $.redirectPost( "labanalisys_sample", {
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
    $( "#add_sample" ).hide();
    $( "#view_sample" ).hide();
    $( "#btn-close-view" ).on( "click", function() {
        $( "#view_sample" ).hide( "slow" );
    });
    $( "#btn-add-sample" ).click(function() {
        $( "#add_sample" ).show( "slow" );
        $( "#view_sample" ).hide( "slow" );
        $('#add_sample h5').text('Aggiungi campione');
        $('#btn-sample-form').text('Salva');
        $('#sample-form').attr('action', 'sample_new');
        clearfields();
    });
    $( "#cancel-sample-form" ).on( "click", function() {
        $( "#add_sample" ).hide( "slow" );
        clearfields();
        return false;
    });
    $('#start-date').datepicker({
        language: 'it',
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true,
    });
    $('#start-date').datepicker('update', '');
    $( ".row" ).on( "click", ".view-tool", function(e) {
        viewClearfields();
        $('#add_sample').hide( "slow" );
        $( "#view_sample" ).show( "slow" );
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
        $( "#add_sample" ).show( "slow" );
        $( "#view_sample" ).hide( "slow" );
        $('#sample-form').attr('action', 'sample_edit');
        $('#add_sample h5').text('Modifica campione');
        $('#btn-sample-form').text('Modifica');
        loadReport(id, 'edit');
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".delete-tool", function(e) {
        var deleted = $(this).parent().parent();
        var id = $(this).parent().parent().data("id");
        console.log("MY ID: "+id);
        console.log("deleted: "+deleted);
        swal({
            title: "Elimina il campione",
            text: "Sei proprio sicuro di voler eliminare il campione selezionato?",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Elimina",
            closeOnConfirm: false,
            cancelButtonText: "Annulla"
        }, function () {
            var jqxhr = $.ajax({
                url: 'sample_delete',
                type: "post",
                dataType: "json",
                data: { id: id },
            })
            .done(function(result) {
                console.dir( result );
                deleted.remove();
                if ( result ==1 )
                    swal("Eliminato", "Il campione selezionato è stato eliminato", "success");
                else
                    swal("Campione non eliminato", "Errore durante l'eliminazione del campione", "error");
            })
            .fail(function(xhr, err) {
                toastr.error(err, 'Errore');
            });
        });
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".lock-tool", function(e) {
        var locked = $(this).parent().parent();
        var id = $(this).parent().parent().data("id");
        console.log("MY ID: "+id);
        console.log("locked: "+locked);
        swal({
            title: "Blocca il campione",
            text: "Sei proprio sicuro di voler bloccare il campione selezionato?",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Blocca",
            closeOnConfirm: false,
            cancelButtonText: "Annulla"
        }, function () {
            var jqxhr = $.ajax({
                url: 'sample_locked',
                type: "post",
                dataType: "json",
                data: { id: id },
            })
            .done(function(result) {
                console.dir( locked );
                locked.children().last().html('<i class="fa fa-lock"></i>');
                locked.children().first().empty();
                locked.children().first().html('<a href="javascript:void(0)" class="table-tool blue view-tool"><i class="fa fa-search-plus"></i></a>');
                if ( result ==1 )
                    swal("Bloccato", "Il campione selezionato è stato bloccato", "success");
                else
                    swal("Campione non bloccato", "Errore durante il blocco del campione", "error");
            })
            .fail(function(xhr, err) {
                toastr.error(err, 'Errore');
            });
        });
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".unlock-tool", function(e) {
        var unlocked = $(this).parent().parent();
        var id = $(this).parent().parent().data("id");
        console.log("MY ID: "+id);
        console.log("unlocked: "+unlocked);
        swal({
            title: "Sblocca il campione",
            text: "Sei proprio sicuro di voler sbloccare il campione selezionato?",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Sblocca",
            closeOnConfirm: false,
            cancelButtonText: "Annulla"
        }, function () {
            var jqxhr = $.ajax({
                url: 'sample_unlocked',
                type: "post",
                dataType: "json",
                data: { id: id },
            })
            .done(function(result) {
                console.dir( unlocked );
                unlocked.children().last().empty();
                unlocked.children().first().empty();
                unlocked.children().first().html('<a href="javascript:void(0)" class="table-tool blue view-tool"><i class="fa fa-search-plus"></i></a> <a href="javascript:void(0)" class="table-tool blue set-tool"><i class="fa fa-wrench"></i></a> <a href="javascript:void(0)" class="table-tool blue lock-tool"><i class="fa fa-unlock-alt"></i></a> <a href="javascript:void(0)" class="table-tool light-blue delete-tool"><i class="fa fa-trash"></i></a>');
                if ( result ==1 )
                    swal("Sbloccato", "Il campione selezionato è stato sbloccato", "success");
                else
                    swal("Campione non sbloccato", "Errore durante lo sblocco del campione", "error");
            })
            .fail(function(xhr, err) {
                toastr.error(err, 'Errore');
            });
        });
        e.preventDefault();
        return false;
    });
    $( "#add_sample" ).on( "click", ".btn-verify", function(e) {
        e.preventDefault();
        var id = $('#sample-id').val();
        console.log(id);
        swal({
            title: "Verifica id",
            text: "Verificare l'id del campione: "+id,
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Verifica",
            closeOnConfirm: false,
            cancelButtonText: "Annulla"
        }, function () {
            var jqxhr = $.ajax({
                url: 'labanalisys_sample_id',
                type: "post",
                dataType: "json",
                data: { id: id },
            })
            .done(function(result) {
                console.dir( result );
                if ( result ==1 )
                    swal("Verificato", "L'id campione è stato verificato e risulta disponibile", "success");
                else
                    swal("Id campione non disponibile", "Id campione inserito è già stato utilizzato", "error");
            })
            .fail(function(xhr, err) {
                toastr.error(err, 'Errore');
            });
        });
    });
    $('#sample-form').validate({
        rules: {
            'sample-id': {
                required: true,
                number: true,
                minlength: 9,
                maxlength: 9
            },
            'vol-sample': {
                required: true,
                pattern: /^[1-9]\d*(\.\d+)?$/
            },
            'prel': {
                required: true,
                min: 0
            },
            'analysis': {
                required: true,
                min: 0
            },
            'start-date': {
                required: true
            },
            'days': {
                required: true,
                number: true
            },
            'station': {
                required: true,
                min: 0
            },
        },
        messages: {
            'sample-id': {
                required: "Inserire ID Campione",
                number: "inserire un numero valido"
            },
            'vol-sample': {
                required: "Inserire Volume campionamento",
                pattern: "inserire un numero valido con separatore punto"
            },
            'prel': {
                min: "Selezionare Prelievo"
            },
            'analysis': {
                min: "Selezionare Analisi"
            },
            'start-date': {
                required: "Inserire data inizio campionamento"
            },
            'days': {
                required: "Inserire numero dei giorni",
                number: "inserire un numero valido"
            },
            'station': {
                min: "Inserire stazione"
            },
        },
        ignore: "",
    });
    $("#instrument-form").submit(function(event){
        if (! $('#instrument-form').valid() ) {
            console.log('Form non valido!');
            return false;
        }
        console.log('Form valido.');
        return true;
    });
});
function clearfields(){
    $('#start-date').datepicker('update', '');
    $('#sample-id, #vol-sample, #days, #white-numb, #notes').val('');
    $("#prel, #analysis, #station").val('-1');
    $('.i-checks').iCheck('uncheck');
};
function viewClearfields(){
    $(".clear-txt").text("");
    $("#table-data-sample").empty();
};
function loadReport(id, dest) {
    console.log('loadReport(' + id + ' -> ' + dest + ')');
    var jqxhr = $.ajax({
        url: 'sample_get',
        type: "post",
        dataType: "json",
        data: { id: id },
    })
    .done(function(result) {
        console.dir( result );
        if (dest == 'show')
            viewSample(result);
        if (dest == 'edit')
            editSample(result.sample);
    })
    .fail(function(xhr, err) {
        return null;
    });
}
function viewSample(report) {
    viewClearfields();
    console.log('viewSample');
    console.dir(report);
    $("#view-sample-id").text(report.sample.sp_id);
    $("#view-vol-sample").text(report.sample.volume);
    $("#view-prel").text(report.sample.filter_name);
    $("#view-analysis").text(report.sample.analysis_name);
    $("#view-start-date").text(report.sample.date_start);
    $("#view-days").text(report.sample.no_days);
    $("#view-station").text(report.sample.stationname);
    $("#view-notes").text(report.sample.note);
    if(report.data && report.data.length){
        $( "#table-all-data" ).show();
        $.each(report.data, function(key, value) {
            var mass = value.mass;
            console.log('mass:'+mass)
            mass = mass.toString().replace("-", "< ");
            var conc = value.conc;
            conc = conc.toString().replace("-", "< ");
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
function editSample(report) {
    clearfields();
    console.log('editSample');
    console.dir(report);
    $('#sp-id').val(report.id);
    $('#sample-id').val(report.sp_id);
    $('#vol-sample').val(report.volume);
    $('#prel').val(report.fi_id);
    $('#analysis').val(report.an_id);
    $('#start-date').datepicker('update', report.date_start_format);
    $('#days').val(report.no_days);
    $('#station').val(report.st_id);
    $('#notes').val(report.note);
}
