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
Dropzone.autoDiscover = false;
Dropzone.options.reportAddAttach = {
    init: function() {
        this.on("sending", function(file, xhr, formData) {
            formData.append("suid", suid);
        });
    }
}
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
    $("#add-survey").hide();
    $("#view-survey").show("slow");
}
var attachname = [];
var suid;
var userid;
$(document).ready(function() {
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
    $( "#refresh-list" ).click(function(e) {
        e.preventDefault();
        $.redirectPost( "report_survey", {
            startDate: startDate,
            endDate : endDate
        } );
        return false;
    });
    $( "#download-csv" ).click(function(e) {
        e.preventDefault();
        $.redirectPost( "report_survey_csv", {
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
        "order": [[ 1, "desc" ]],
    });
    $('#add-survey').hide();
    $('#report-date').datepicker({
        language: 'it',
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true
    });
    $('#report-date').datepicker('update', 'today');
    $('#sur_time_start input, #sur_time_end input').timepicker({
        minuteStep: 5,
        showInputs: false,
        disableFocus: true,
        showMeridian: false
    });
    $( "#btn-add-survey" ).click(function() {
        $('#survey-form').attr('action', 'report_survey_new');
        $('#report-operator option[value="' + userid + '"]').prop('selected',true);
        clearfields();
        if ( $( "#add-survey" ).is(":visible") )
            return false;
        $( "#report-place" ).val('');
        $( "#report-note" ).val('');
        var jqxhr = $.ajax({
            url: 'report_survey_new_next_id',
            type: "post",
            dataType: "json",
            data: {},
        })
        .done(function(result) {
            console.dir( result );
            suid = result.suid;
            $('#report-suid').val(suid);
            $( "#add-survey" ).show( "slow" );
            $( "#view-survey" ).hide( "slow" );
        })
        .fail(function(xhr, err) {
            bootbox.alert({
                message: err,
            });
        });
    });
    $.validator.addMethod("time24", function(value, element) {
        return /^([01]?[0-9]|2[0-3])(:[0-5][0-9]){1}$/.test(value);
    }, "Formato ora non valido [HH:mm].");
    $('#survey-form').validate({
        rules: {
            "report-place": {
                required: true,
            },
            "report-note": {
                required: true,
            },
            "report-date": {
                required: true,
            },
            "report-time-start": {
                required: true,
                time24: true
            },
            "report-time-end": {
                required: true,
                time24: true
            },
            "report-operator": {
                required: true,
                min: 1
            }
        },
        messages: {
            "report-place": {
                required: "Inserire una località",
            },
            "report-note": {
                required: "Inserire una nota",
            },
            "report-date": {
                required: "Inserire una data",
            },
            "report-time-start": {
                required: "Inserire ora inizio report",
                time24: "Formato ora non valido [HH:mm]"
            },
            "report-time-end": {
                required: "Inserire ora fine report",
                time24: "Formato ora non valido [HH:mm]"
            },
            "report-operator": {
                min: "Selezionare un rilievo"
            }
        },
        ignore: "",
    });
    $("#survey-form").submit(function(event){
        if (! $('#survey-form').valid() ) {
            console.log('Form non valido!');
            return false;
        }
        console.log('Form valido.');
        return true;
    });
    $('.lightBoxGallery .single-image-gallery').on('click', function(event) {
        event = event || window.event;
        var target = event.target || event.srcElement,
            link = target.src ? target.parentNode : target,
            options = {
                index: link,
                event: event,
                hidePageScrollbars: false
            },
            links = $('a.single-image-gallery');
        blueimp.Gallery(links, options);
    });
    $('#survey-form').submit(function(){
        var isValid = $("#survey-form").valid();
        if (!isValid)
            return false;
        $('#btn-survey-form').val('invio in corso...');
        $('#btn-survey-form').prop('disabled', true);
        console.log('form submitting ...');
    });
    $( "#cancel-survey-form" ).click(function() {
        clearfields();
        $( "#add-survey" ).hide( "slow" );
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
                url: 'report_survey_delete',
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
    $( ".row" ).on( "click", ".pdf-tool", function(e) {
        var id = $(this).parent().parent().data("id");
        console.log('download del pdf: '+id);
        $.redirectPost( "report_survey_pdf", {
            id: id
        });
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".set-tool", function(e) {
        console.log('"click", ".set-tool"');
        var id = $(this).parent().parent().data("id");
        loadReport(id, 'edit');
        $( "#add-survey" ).show( "slow" );
        $( "#view-survey" ).hide( "slow" );
        e.preventDefault();
        return false;
    });
    $( "#view-survey" ).hide();
    $( ".row" ).on( "click", ".view-tool", function(e) {
        $("#view_loc" ).text('');
        $("#view_date" ).text('');
        $("#view_start").text('');
        $("#view_end" ).text('');
        $("#view_op" ).text('');
        $("#view_note" ).text('');
        var id = $(this).parent().parent().data("id");
        loadReport(id, 'show');
        $("#add-survey").hide();
        $("#view-survey").show("slow");
        e.preventDefault();
        return false;
    });
    $("#btn-close-view").click(function() {
        $( "#view-survey" ).hide( "slow" );
    });
    console.log('initialize dropzone');
    $("#report-add-attach").dropzone({
        url: "report_survey_new_upload_file",
        paramName: "file",
        acceptedFiles: "video/*,image/*,.pdf",
        maxFilesize: 75,
        addRemoveLinks : true,
        clickable: true,
        autoProcessQueue: true,
        dictDefaultMessage:
        '<span class="bigger-150 bolder"><i class="ace-icon fa fa-caret-right red"></i> Trascina qui i file</span> per caricarli         <span class="smaller-80 grey"><br />(o clicca qui)</span> <br />         <i class="upload-icon ace-icon fa fa-cloud-upload blue fa-3x"></i>',
        dictResponseError: 'Errore nel caricamento dei file!',
        previewTemplate: "<div class=\"dz-preview dz-file-preview\">\n  <div class=\"dz-details\">\n    <div class=\"dz-filename\"><span data-dz-name></span></div>\n    <div class=\"dz-size\" data-dz-size></div>\n    <img data-dz-thumbnail />\n  </div>\n  <div class=\"progress progress-small progress-striped active\"><div class=\"progress-bar progress-bar-success\" data-dz-uploadprogress></div></div>\n  <div class=\"dz-success-mark\"><span></span></div>\n  <div class=\"dz-error-mark\"><span></span></div>\n  <div class=\"dz-error-message\"><span data-dz-errormessage></span></div>\n</div>",
        headers: { "My-Awesome-Header": "header value" },
        success: function(file, response) {
            file.serverId = response.id;
        },
        removedfile: function(file) {
            var jqxhr = $.ajax({
                url: 'report_survey_new_delete_file',
                type: "post",
                dataType: "json",
                data: {
                    suid: suid,
                    fiid: file.serverId
                },
            })
            .done(function(result) {
                var found = jQuery.inArray(file.name, attachname);
                if (found >= 0) {
                    attachname.splice(found, 1);
                }
                var _ref;
                return (_ref = file.previewElement) != null ? _ref.parentNode.removeChild(file.previewElement) : void 0;
            })
            .fail(function(xhr, err) {
                bootbox.alert({
                    message: err,
                });
            });
        },
        accept: function(file, done) {
            if(jQuery.inArray(file.name, attachname) > -1) {
                attachname.push(file.name);
                done("File già inserito.");
            } else {
                done();
                attachname.push(file.name)
            }
        }
    });
    $.fn.datepicker.defaults.language = 'it';
});
function clearfields(){
    $( "#add-survey .ibox-title h5" ).text("Aggiungi sopralluogo");
    $( "#add-survey #btn-survey-form" ).text("Salva");
    $("#report-place, #report-note").val('');
    $('#report-date').datepicker('update', 'today');
    $('#sur_time_start input, #sur_time_end input').timepicker({
        minuteStep: 5,
        showInputs: false,
        disableFocus: true,
        showMeridian: false,
        scrollDefault: 'now'
    });
};
function loadReport(id, dest) {
    console.log('loadReport() ' + id);
    var jqxhr = $.ajax({
        url: 'report_survey_get_report',
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
    $("#view_loc").text(report.survey_place);
    $("#view_date").text(report.survey_date_format);
    $("#view_start").text(report.survey_start_time_format);
    $("#view_end").text(report.survey_end_time_format);
    $("#view_op").text(report.user_fullname);
    $("#view_note").text(report.survey_desc);
    $( "#attach" ).empty();
    $( "#attach-img" ).empty();
    var stored_attachments = report.stored_attachments;
    var attachments = report.attachments;
    if (stored_attachments != ''){
        var arr1 = stored_attachments.split(',');
        var arr2 = attachments.split(',');
        var patt1 = /^.*\.png|\.jpg|\.jpeg|\.gif$/i;
        var patt2 = /^.*\.mp4|\.ogg|\.webm$/i;
        for ( var i = 0, l = arr1.length; i < l; i++ ) {
            var url = '/uploads/sopralluoghi/allegati_'+report.path_id+'/'+$.trim(arr1[i]);
            var thumb = '/uploads/sopralluoghi/allegati_'+report.path_id+'/thumb_'+$.trim(arr1[i]);
            if ( patt1.test(url) ) {
                $( "#attach-img" ).append( "<a href="+url+" title='' class='single-image-gallery' data-gallery=''><img src="+thumb+"></a>" );
            } else if ( patt2.test(url) ) {
                $( "#attach-img" ).append( '<video width="270" controls><source src="'+url+'" type="video/mp4">Il browser non supporta i tag video.</video>');
            } else {
                $( "#attach-file" ).append( "<a href="+url+" title='' class='pdf-attacch text-info' target='_blank'><i class='fa fa-file-pdf-o'></i> "+arr2[i]+"</a>&nbsp;&nbsp;&nbsp;" );
            }
        };
    }
    return false;
}
function editReport(report) {
    clearfields();
    $( "#add-survey .ibox-title h5" ).text("Modifica sopralluogo");
    $( "#add-survey #btn-survey-form" ).text("Modifica");
    suid = report.su_id;
    $('#survey-form').attr('action', 'report_survey_edit');
    $("#report-suid").val(report.su_id);
    $("#report-place").val(report.survey_place);
    $("#report-date").val(report.survey_date_cal);
    $("#sur_time_start input").val(report.survey_start_time_format);
    $("#sur_time_end input").val(report.survey_end_time_format);
    $("#report-note").val(report.survey_desc);
    $('#report-operator option[value="' + report.us_id + '"]').prop('selected',true);
    return false;
}
