var selectedPageId;
var selectedPageInfo;
var pagesData;
var chart = [];
var visibleSeries = [[]];
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
    $('#reportrange').data('daterangepicker').setEndDate( moment(date2));
    startDate = moment(date1).format('YYYY-MM-DD');
    endDate = moment(date2).format('YYYY-MM-DD');
}
$(document).ready(function() {
    $('#visualizer_map').on( 'click', '.single-image-gallery', function (event) {
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
    $('#visualizer').on( 'click', '.validate', function () {
        $(this).html('<i class="fa fa-exclamation-circle text-danger"></i>');
        $(this).prop('title', 'invalidato');
        $(this).addClass('not-valid');
        $(this).removeClass('validate');
        var code = parseInt($('#validation').val());
        setDataValidCode(code, $(this));
        $(this).closest("tr").css({color: "#ed5565", "text-decoration": "line-through"});
    });
    $('#visualizer').on( 'click', '.to-validate', function () {
        $(this).html('<i class="fa fa-exclamation-circle text-danger"></i>');
        $(this).prop('title', 'default valido');
        $(this).addClass('not-valid');
        $(this).removeClass('to-validate');
        var code = parseInt($('#validation').val());
        setDataValidCode(code, $(this));
        $(this).closest("tr").css({color: "#ed5565", "text-decoration": "line-through"});
    });
    $('#visualizer').on( 'click', '.not-valid', function () {
        $(this).html('<i class="fa fa-check-circle text-success"></i>');
        $(this).prop('title', 'validato');
        $(this).addClass('validate');
        $(this).removeClass('not-valid');
        setDataValidCode(1, $(this));
        $(this).closest("tr").css({color: "#1c84c6", "text-decoration": "none"});
    });
    $('#reportrange').daterangepicker({
        format: 'DD/MM/YYYY',
        startDate: moment().subtract(29, 'days'),
        endDate: moment(),
        minDate: moment('1995-01-01'),
        maxDate: moment(),
        showDropdowns: true,
        showWeekNumbers: true,
        timePicker: false,
        timePickerIncrement: 1,
        timePicker12Hour: true,
        ranges: {
            'Ultimi 2 Giorni': [moment().subtract(1, 'days'), moment()],
            'Ultimi 4 Giorni': [moment().subtract(3, 'days'), moment()],
            'Ultima Settimana': [moment().subtract(6, 'days'), moment()],
            'Ultime 2 Settimane': [moment().subtract(13, 'days'), moment()],
            'Ultimo Mese': [moment().subtract(29, 'days'), moment()],
            'Ultimi 2 Mesi': [moment().subtract(59, 'days'), moment()]
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
    $("#hide-download").hide();
    $("#common-bar").hide();
    $(".list-visualizer").hide();
    initMap();
    var filter = {
        chStz : visOptions.grpStat,
        chLab : visOptions.grpLabs,
        chCam : visOptions.grpCamp
    }
    refreshStations(filter);
    $( ".filter-chk" ).on( "ifChanged", function(e) {
        switch(e.target.id) {
            case 'chk-staz':
                visOptions.grpStat = e.target.checked;
                break;
            case 'chk-labs':
                visOptions.grpLabs = e.target.checked;
                break;
            case 'chk-camp':
                visOptions.grpCamp = e.target.checked;
                break;
        }
        var filter = {
            chStz : visOptions.grpStat,
            chLab : visOptions.grpLabs,
            chCam : visOptions.grpCamp
        }
        refreshStations(filter);
    });
    $(".menu-orr-visualizer").on( "click", function() {
        var gr_id = $(this).parent().data("grid");
        console.log(gr_id);
        var main_ul = $(this).next( ".list-visualizer" );
        main_ul.empty();
        var jqxhr = $.ajax({
            url: 'visualizer_pages',
            type: "post",
            dataType: "json",
            data: {
                grid: gr_id
            },
        })
        .done(function(result) {
            console.log( "success" );
            jQuery.each( result.data, function( i, val ) {
                var add_li = '<li data-pgid="'+val.pg_id+'"><a href="#" class="instrument-link">'+val.name+'</a></li>'
                main_ul.append(add_li);
            });
            main_ul.toggle( "slow");
        })
        .fail(function(xhr, err) {
            bootbox.alert({
                message: err,
            });
        });
    });
    $('#visualizer-menu').on( 'click', '.menu-visualizer li a', function () {
        $( ".menu-visualizer li a").removeClass("text-warning");
        $( this ).addClass("text-warning");
    });
    $('#visualizer').on( 'click', 'a.toggle-table', function () {
        $( this ).parent().parent().find( ".visualizer-chart" ).toggle();
        $( this ).parent().parent().find( ".visualizer-table" ).toggle();
        $( this ).children( "i" ).toggle();
    });
    $('#visualizer').on( 'click', 'a.choose-calendar', function () {
        $( this ).siblings( ".open-calendar" ).toggle();
        $( this ).toggleClass("dif-colors");
    });
    $('#visualizer').on( 'click', 'a.check-it', function () {
        var wd_id = $(this).parent().parent().parent().parent().data("wdid");
        var i = $(this).parent().parent().parent().parent().data("id");
        console.log('check-it sel wdid: '+wd_id);
        console.log('sel id: '+i);
        pagesData[i].alldata = ! $( this ).hasClass("dif-colors");
        fillPanel(i, pagesData[i], startDate, endDate);
        $( this ).toggleClass("dif-colors");
    });
    $('#visualizer').on( 'click', 'a.formula', function () {
        var wd_id = $(this).parent().parent().parent().parent().data("wdid");
        var i = $(this).parent().parent().parent().parent().data("id");
        console.log('formula sel wdid: '+wd_id);
        console.log('sel id: '+i);
        pagesData[i].useformule = ! pagesData[i].useformule;
        fillPanel(i, pagesData[i], startDate, endDate);
    });
    $('#visualizer').on( 'click', 'a.type-graphs', function () {
        $( this ).siblings( ".type-graphs" ).toggle();
        $( this ).toggleClass("dif-colors");
        $( this ).siblings( ".open-pie-chart" ).toggle();
    });
    $('#visualizer').on( 'click', 'input.change-days', function () {
        var days = $(this).siblings(".select-days").val();
        var wd_id = $(this).parent().parent().parent().parent().parent().data("wdid");
        var i = $(this).parent().parent().parent().parent().parent().data("id");
        console.log('sel day: '+days+", sel wdid: "+wd_id+", sel id: "+i);
        pagesData[i].nodays = parseInt(days);
        fillPanel(i, pagesData[i], startDate, endDate);
        $(this).parent().hide();
        $(this).parent().siblings(".choose-calendar").removeClass("dif-colors");
    });
    $('#visualizer').on( 'click', 'input.change-chart', function () {
        var type = $(this).siblings(".select-chart").val();
        var i = $(this).parent().parent().parent().parent().parent().parent().data("id");
        console.log('sel type: '+type+", sel i: "+i);
        changeChart(i, type);
        $(this).parent().parent().hide();
        $(this).parent().parent().siblings(".type-graphs").removeClass("dif-colors");
    });
    $('#visualizer').on( 'click', 'a.chart-info', function () {
        var wd_id = $(this).parent().parent().parent().parent().data('wdid');
        var i = $(this).parent().parent().parent().parent().data("id");
        console.log("view infos: "+wd_id, i);
        var classColors = $(this).hasClass("dif-colors");
        if(classColors == false){
            $(".chart-info").removeClass("dif-colors");
            $(".view-info").hide();
        }
        viewInfo(i, wd_id);
        $( this ).siblings( ".view-info" ).toggle();
        $( this ).toggleClass("dif-colors");
    });
    var dowloading = false;
    $('#visualizer').on( 'click', 'a.download-chart', function (e) {
        var i = $(this).parent().parent().parent().parent().data("id");
        $(this).addClass("dif-colors");
        $(this).css( 'cursor', 'default' );
        if (dowloading){
            return false
        };
        dowloading = true;
        chart[i].highcharts().exportChart(
            {filename: 'grafico'}, {
                chart: {
                    backgroundColor: '#FFFFFF'
            }
        });
        var me = $( this );
        setTimeout(function(){
          $(me).removeClass("dif-colors");
          $(me).css( 'cursor', 'pointer' );
          dowloading = false;
        }, 2500);
    });
    $('#visualizer').on( 'click', 'a.datatable-get-csv', function (e) {
        if (dowloading){
            return false
        };
        dowloading = true;
        $(this).addClass("dif-colors");
        $(this).css( 'cursor', 'default' );
        var idx = $(this).parent().parent().parent().parent().data("id");
        var export_filename = 'Dati-' + moment().format('YYYY.MM.DD-HH:mm:ss') + ".csv";
        exportTableToCSV.apply(this, [$('#table-added-'+idx), export_filename]);
        var me = $( this );
        setTimeout(function(){
            $(me).removeClass("dif-colors");
            $(me).css( 'cursor', 'pointer' );
            dowloading = false;
        }, 2500);
        });
    $('#visualizer').on( 'click', 'span.close-infos', function () {
        $(this).parent().hide();
        $(this).parent().siblings(".chart-info").removeClass("dif-colors");
    });
    $('.menu-visualizer').on( 'click', 'a.instrument-link', function () {
        selectedPageId = $(this).parent().data("pgid");
        console.log(selectedPageId);
        var bc = $(this).parent().parent().prev().text().trim();
        bc = bc + ' - <strong>' + $(this).html() + '</strong>';
        loadPageWrapper(selectedPageId, bc);
    });
    $('#visualizer').on( 'click', '.select-chart', function () {
        var typeChart = $('.select-chart').val();
        if(typeChart == 0){
            $('.check-options').show();
        }else{
            $('.check-options').hide();
        };
    });
    $('#visualizer').on( 'click', '.points', function () {
        var i = $(this).parent().parent().parent().parent().parent().parent().data("id");
        var value = $(this).prop('checked');
        var series = chart[i].highcharts().series.length;
        for (s = 0; s < series; s++) {
            chart[i].highcharts().series[s].update({marker: {
                enabled: value
            }});
        }
    });
    $('#visualizer').on( 'click', '.labels', function () {
        var i = $(this).parent().parent().parent().parent().parent().parent().data("id");
        var value = $(this).prop('checked');
        var series = chart[i].highcharts().series.length;
        for (s = 0; s < series; s++) {
            chart[i].highcharts().series[s].update({dataLabels: {
                enabled: value
            }});
        }
    });
    Highcharts.setOptions({
        lang: {
            months: ['Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno',
                'Luglio', 'Agosto', 'Settembre', 'Ottobre', 'Novembre', 'Dicembre'],
            shortMonths : ['Gen', 'Feb', 'Mar', 'Apr', 'Mag', 'Giu', 'Lug', 'Ago', 'Set', 'Ott', 'Nov', 'Dic'],
            weekdays: ['Domenica', 'Lunedi;', 'Martedi', 'Mercoledi', 'Giovedi', 'Venerdi', 'Sabato'],
            resetZoom: 'Indietro'
        },
        chart: {
            resetZoomButton: {
                position: {
                    x: 0,
                    y: 3
                },
                theme: {
                    fill: 'white',
                    stroke: '#1ab394',
                    r: 4,
                    states: {
                        hover: {
                            fill: '#1ab394',
                            style: {
                                color: 'white'
                            }
                        }
                    }
                }
            }
        }
    });
    $( "#refresh-range" ).click(function(e) {
        e.preventDefault();
        if (selectedPageId == null)
            return false;
        var intTimeOverride = $("#integration").val();
        loadPage(selectedPageId, startDate, endDate, -1, intTimeOverride);
        return false;
    });
});
function loadPageWrapper(pgid, info) {
    console.log('loadPageWrapper - pgId: '+pgid)
    selectedPageInfo = info;
    selectedPageId = pgid;
    $("#group_page_info").html(info);
    $("#common-bar").show();
    loadPage(pgid, null, null, null, null);
}
function loadPage(pgId, startDate, endDate, noDaysOverride, intTimeOverride) {
    console.log('loadPage - pgId: '+pgId)
    console.log('noDaysOverride: '+noDaysOverride)
    console.log('intTimeOverride: '+intTimeOverride)
    $('#visualizer').empty();
    if (intTimeOverride == null)
        $('#integration').val(visOptions.defaultIntegration);
    var jqxhr = $.ajax({
        url: 'visualizer_windows',
        type: "post",
        dataType: "json",
        data: {
            pgid: pgId
        },
    })
    .done(function(result) {
        console.log( "success ajax" );
        console.dir(result.data);
        pagesData = result.data;
        addBoxes(pagesData, startDate, endDate, noDaysOverride, intTimeOverride);
        $(".open-calendar").hide();
        $(".open-pie-chart").hide();
        $(".view-info").hide();
        $(document).scrollTop( $("#common-bar").offset().top );
    })
    .fail(function(xhr, err) {
        bootbox.alert({
            message: err,
        });
    });
}
function viewInfo(i, wdid) {
    console.log('viewInfo...');
    $('.view-info').empty();
    var wdInfo = pagesData[i];
    console.log('visualizza informazioniiii');
    var wdTable ='<h4><i class="fa fa-info-circle"></i> Informazioni parametro</h4>';
        wdTable +='<span class="close-infos">x</span>';
        wdTable +='<table class="table table-striped table-hover" >';
        wdTable +='    <tbody>';
        wdTable +='        <tr>';
        wdTable +='            <td class="wd_type">Stazioni:</td>';
        wdTable +='            <td>'+wdInfo.stationname+'</td>';
        wdTable +='        </tr>';
        wdTable +='        <tr>';
        wdTable +='            <td class="wd_type">Parametro:</td>';
        wdTable +='            <td>'+wdInfo.name+'</td>';
        wdTable +='        </tr>';
        wdTable +='        <tr>';
        wdTable +='            <td class="wd_type">Unità misura:</td>';
        wdTable +='            <td>'+wdInfo.unit+'</td>';
        wdTable +='        </tr>';
        wdTable +='        <tr>';
        wdTable +='            <td class="wd_type">Integrazione:</td>';
        wdTable +='            <td>'+wdInfo.integration+'</td>';
        wdTable +='        </tr>';
        wdTable +='        <tr>';
        wdTable +='            <td class="wd_type">Formula:</td>';
        wdTable +='            <td>'+wdInfo.formule+'</td>';
        wdTable +='        </tr>';
        wdTable +='        <tr>';
        wdTable +='            <td class="wd_type">Decimali:</td>';
        wdTable +='            <td>'+wdInfo.decimals+'</td>';
        wdTable +='        </tr>';
        wdTable +='        <tr>';
        wdTable +='            <td class="wd_type">StPrId:</td>';
        wdTable +='            <td>'+wdInfo.st_pr_id+'</td>';
        wdTable +='        </tr>';
        wdTable +='        <tr>';
        wdTable +='            <td class="wd_type">StId:</td>';
        wdTable +='            <td>'+wdInfo.st_id+'</td>';
        wdTable +='        </tr>';
        wdTable +='        <tr>';
        wdTable +='            <td class="wd_type">PrId:</td>';
        wdTable +='            <td>'+wdInfo.pr_id+'</td>';
        wdTable +='        </tr>';
        wdTable +='        <tr>';
        wdTable +='            <td class="wd_type">Id | [WdId]:</td>';
        wdTable +='            <td>'+wdInfo.id+' | ['+wdInfo.view_id+']</td>';
        wdTable +='        </tr>';
        wdTable +='        <tr>';
        wdTable +='            <td class="wd_type">Tabella:</td>';
        wdTable +='            <td>'+wdInfo.tablename+'</td>';
        wdTable +='        </tr>';
        wdTable +='        <tr>';
        wdTable +='            <td class="wd_type">WdId:</td>';
        wdTable +='            <td>'+wdInfo.wd_id+'</td>';
        wdTable +='        </tr>';
        wdTable +='    </tbody>';
        wdTable +='</table>';
    $('#visualizer #view-info-'+i).append(wdTable);
};
function addBoxes(pagesData, startDate, endDate, noDaysOverride, intTimeOverride) {
    console.log('addBoxes');
    chart = [];
    row = 1;
    jQuery.each( pagesData, function(i, pageData) {
        if (noDaysOverride != null)
            pageData.nodays = noDaysOverride;
        if (intTimeOverride != null)
            pageData.inttime = intTimeOverride;
        var pluv = '';
        if (pageData.pr_id == 7 && pageData.heated){
            console.log('pluv riscaldato');
            pluv = '<span class="hot-pluv" data-toggle="tooltip" data-placement="bottom" title="Pluviometro riscaldato"><i class="fa fa-lightbulb-o"></i></span>';
        }
        var htmlPanel = ' <div class="col-lg-4" id="panel-'+i+'" data-wdid="'+pageData.wd_id+'" data-stprid="'+pageData.st_pr_id+'" data-id="'+i+'"> ';
            htmlPanel += '     <div class="ibox float-e-margins"> ';
            htmlPanel += '         <div class="ibox-title"> ';
            if (visOptions.fullTitle) {
                htmlPanel += '             <h5>'+pageData.name+' - '+selectedPageInfo+'</h5> ';
            } else {
                htmlPanel += '             <h5>'+pageData.name+'</h5> ';
            }
            htmlPanel += '             <div class="ibox-tools"> ';
            htmlPanel += '                 <a class="collapse-link collapse-live"><i class="fa fa-chevron-up"></i></a> ';
            htmlPanel += '                 <a class="fullscreen-link fullscreen-live"><i class="fa fa-expand"></i></a> ';
            htmlPanel += '                 <a class="close-link close-live"><i class="fa fa-times"></i></a> ';
            htmlPanel += '             </div> ';
            htmlPanel += '         </div> ';
            htmlPanel += '         <div class="ibox-content">'+pluv;
            htmlPanel += '             <div class="topbar row"> ';
            htmlPanel += '                 <div class="col-lg-4"><strong>min:</strong> <span class="min-val"></span></div> ';
            htmlPanel += '                 <div class="col-lg-4"><strong>max:</strong> <span class="max-val"></span></div> ';
            htmlPanel += '                 <div class="col-lg-4 text-right"><strong>unit:</strong><span class="unit-val"></span></div> ';
            htmlPanel += '             </div> ';
            htmlPanel += '             <div id="chart-'+i+'" class="visualizer-chart"></div> ';
            htmlPanel += '             <div id="table-'+i+'" class="visualizer-table" style="display:none;"></div> ';
            htmlPanel += '             <div class="bottombar" id="bottombar-'+i+'"> ';
            htmlPanel += '                 <a href="javascript:void(0)" class="toggle-table" data-toggle="tooltip" data-placement="bottom" title="Tabella/Grafico"><i class="fa fa-th"></i><i class="fa fa-line-chart" style="display:none;"></i></a> ';
            htmlPanel += '                 <div class="open-calendar"><h4>Arco temporale:</h4><select class="select-days" id="select-'+i+'">';
            htmlPanel += '                      <option value="1">1 giorno</option>';
            htmlPanel += '                      <option value="2">2 giorni</option>';
            htmlPanel += '                      <option value="4">4 giorni</option>';
            htmlPanel += '                      <option value="8">8 giorni</option>';
            htmlPanel += '                      <option value="16">16 giorni</option>';
            htmlPanel += '                      <option value="31">1 mese</option>';
            htmlPanel += '                      <option value="60">2 mesi</option>';
            htmlPanel += '                      <option value="90">3 mesi</option>';
            htmlPanel += '                 </select><input type="button" value="vai" class="btn btn-warning btn-xs change-days" /></div>';
            htmlPanel += '                 <a href="javascript:void(0)" class="choose-calendar" data-toggle="tooltip" data-placement="bottom" title="Tot giorni"><i class="fa fa-calendar"></i></a>';
            htmlPanel += '                 <a href="javascript:void(0)" class="check-it" data-toggle="tooltip" data-placement="bottom" title="Tutti i dati"><i class="fa fa-check-square-o"></i></a>';
            htmlPanel += '                 <a href="javascript:void(0)" class="formula" data-toggle="tooltip" data-placement="bottom" title="Formula"><i class="fa fa-superscript"></i></a>';
            htmlPanel += '                 <div class="open-pie-chart"><h4>Opzioni grafico:</h4>';
            htmlPanel += '                      <span class="type-chart"><select class="select-chart"><option value="0">Linee</option><option value="1">Barre</option><option value="2">Area</option></select>';
            htmlPanel += '                      <input type="button" value="vai" class="btn btn-warning btn-xs change-chart" /></span>';
            htmlPanel += '                      <span class="check-options"><input type="checkbox" name="points" class="points"> <label for="points">Punti</label> <input type="checkbox" name="labels" class="labels">  <label for="labels">Etichette</label></span>';
            htmlPanel += '                 </div>';
            htmlPanel += '                 <a href="javascript:void(0)" class="type-graphs" data-toggle="tooltip" data-placement="bottom" title="Opzioni grafico"><i class="fa fa-pie-chart"></i></a>';
            htmlPanel += '                 <a href="javascript:void(0)" class="download-chart" data-toggle="tooltip" data-placement="bottom" title="Scarica PNG"><i class="fa fa-file-image-o"></i></a>';
            htmlPanel += '                 <a href="javascript:void(0)" class="datatable-get-csv" data-toggle="tooltip" data-placement="bottom" title="Scarica CSV"><i class="fa fa-file-excel-o"></i></a>';
            htmlPanel += '                 <a href="javascript:void(0)" class="chart-info" data-toggle="tooltip" data-placement="bottom" title="Informazioni"><i class="fa fa-info"></i></a>';
            htmlPanel += '                 <div class="view-info" id="view-info-'+i+'"></div>';
            htmlPanel += '             </div> ';
            htmlPanel += '         </div> ';
            htmlPanel += '     </div> ';
            htmlPanel += ' </div> ';
        $('#visualizer').append(htmlPanel);
        if(row % 3 == 0){
            $('#visualizer').append('<div class="clear_both"></div>');
        }
        row+=1;
        var typeChart = $('.select-chart').val();
        if(typeChart == 0){
            $('.check-options').show();
        }else{
            $('.check-options').hide();
        };
        $('#visualizer #select-'+i).val(pageData.nodays);
        $('.bottombar, .ibox-content').tooltip({
            selector: "[data-toggle=tooltip]",
            container: "body"
        });
        pageData.alldata = false;
        fillPanel(i, pageData, startDate, endDate);
    });
};
function fillPanel(panelid, paneldata, startDate, endDate) {
    console.log("fillPanel, panelid: "+panelid);
    console.dir(paneldata);
    visibleSeries[panelid] = [true, paneldata.showminvalues==1, paneldata.showmaxvalues==1];
    if (chart.length >= (panelid+1)) {
        var series = chart[panelid].highcharts().series.length;
        for (s = 0; s < series; s++) {
            visibleSeries[panelid][s] = (chart[panelid].highcharts().series[s].visible);
        }
    }
    $("#panel-"+panelid).find(".formula").removeClass("dif-colors");
    if ( paneldata.useformule ){
        $("#panel-"+panelid).find(".formula").addClass("dif-colors");
    }
    var jqxhr = $.ajax({
        url: 'visualizer_data',
        type: "post",
        dataType: "json",
        data: {
            stprid : paneldata.st_pr_id,
            inttime : paneldata.inttime,
            days : paneldata.nodays,
            date1 : startDate,
            date2 : endDate,
            viewid : paneldata.view_id,
            useview : paneldata.useview,
            formule : paneldata.formule,
            useform : paneldata.useformule,
            alldata : paneldata.alldata,
            decimals : paneldata.decimals,
        },
    })
    .done(function(result) {
        console.log( "success" );
        createChart(panelid, paneldata, result.data);
        createTable(panelid, paneldata, result.data);
    })
    .fail(function(xhr, err) {
        bootbox.alert({
            message: err,
        });
    });
};
function createChart(i, paneldata, data) {
    console.log('createChart...');
    $('#chart-'+i).empty();
    var dataSeries = analyseData(data);
    if (dataSeries == null)
        return;
    var pointInterval;
    var tooltipFormatter;
    switch (parseInt(paneldata.inttime)) {
        case 2:
            pointInterval = 1800 * 1000;
            tooltipFormatter = '%a, %e %b %Y. %H:%M';
            break;
        case 4:
            pointInterval = 3600 * 1000;
            tooltipFormatter = '%a, %e %b %Y. %H:%M';
            break;
        case 6:
            pointInterval = 3600 * 1000 * 24;
            tooltipFormatter = '%a, %e %b %Y';
            break;
        case 8:
            pointInterval = 3600 * 1000 * 24 * 31;
            tooltipFormatter = '1 %b %Y';
            break;
        default:
            pointInterval = 3600 * 1000;
            tooltipFormatter = '%a, %e %b %Y. %H:%M';
    }
    var plotLines = [];
    if ( paneldata.linegreen != null && parseFloat(paneldata.linegreen) != 0 ) {
        plotLines.push(
            {
                color: 'green',
                width: 2,
                value: parseFloat(paneldata.linegreen),
                dashStyle: 'longdashdot'
            }
        );
    }
    if ( paneldata.lineorange != null && paneldata.lineorange != 0 ) {
        plotLines.push(
            {
                color: 'orange',
                width: 2,
                value: paneldata.lineorange,
                dashStyle: 'longdashdot'
            }
        );
    }
    if ( paneldata.linered != null && paneldata.linered != 0 ) {
        plotLines.push(
            {
                color: 'red',
                width: 2,
                value: paneldata.linered,
                dashStyle: 'longdashdot'
            }
        );
    }
    var plotOptions;
    var chartType;
    var showMarks = (paneldata.marks==1);
    var showPoints = (paneldata.points==1);
    plotOptions = {
        area: { animation: false, enableMouseTracking: false, stickyTracking: true, shadow: false, dataLabels: { style: { textShadow: false } } },
        bar: { animation: false, enableMouseTracking: false, stickyTracking: true, shadow: false, dataLabels: { style: { textShadow: false } } },
        column: { animation: false, enableMouseTracking: false, stickyTracking: true, shadow: false, dataLabels: { style: { textShadow: false } } },
        line: { animation: false, enableMouseTracking: false, stickyTracking: true, shadow: false, dataLabels: { style: { textShadow: false } } },
        line: {
            marker: {
               enabled: showPoints
            },
            dataLabels: {
                enabled: showMarks
            }
        },
        chart: {
            reflow: true,
            events: {
                redraw: function() {
                    $('body').addClass('rendering-done');
                }
            },
            animation: false
        },
    };
    switch (paneldata.charttype) {
        case 0:
            chartType = 'line';
            break;
        case 1:
            chartType = 'column';
            break;
        case 4:
            chartType = 'area';
            break;
        default:
            chartType = 'line';
    }
    var ymax, ymin;
    switch (paneldata.autoscale) {
        case 0:
            ymin = null;
            ymax = null;
            break;
        case 1:
            ymin = 0;
            ymax = null;
            break;
        case 2:
            dataSeries.min
            ymin = paneldata.scalemin;
            if (dataSeries.min < paneldata.scalemin)
                ymin = null;
            ymax = paneldata.scalemax;
            if (dataSeries.max > paneldata.scalemax)
                ymax = null;
            break;
        case 3:
            ymin = paneldata.scalemin;
            ymax = paneldata.scalemax;
            break;
    }
    var series;
    var yAxis;
    if ( paneldata.pr_id == 7 || paneldata.pr_id == 80 ) {
        series = [
            {
                name: 'Somma',
                color: '#'+paneldata.color,
                pointInterval: pointInterval,
                pointStart: dataSeries.pointStart,
                data: dataSeries.dataAvg,
                visible: visibleSeries[i][0],
                yAxis: 0,
            },
            {
                name: 'Cumulata',
                type: 'line',
                color: 'blue',
                marker: {
                    enabled: false
                },
                yAxis: 1,
                pointInterval: pointInterval,
                pointStart: dataSeries.pointStart,
                data: dataSeries.dataCum,
                visible: true
            }
        ];
        yAxis = [{
                title: {
                    text: 'mm'
                },
                minRange: 0.6,
                startOnTick: false,
                showFirstLabel: true,
                min: 0,
            },
            {
                title: {
                    text: 'Cumulata (mm)'
                },
                minRange: 0.6,
                min: 0,
                startOnTick: false,
                showFirstLabel: true,
                opposite: true
            }];
    } else {
        series = [
            {
                name: 'Media',
                color: '#'+paneldata.color,
                pointInterval: pointInterval,
                pointStart: dataSeries.pointStart,
                data: dataSeries.dataAvg,
                visible: visibleSeries[i][0]
            },
            {
                name: 'Max',
                color: '#0072b4',
                dashStyle: 'ShortDash',
                pointInterval: pointInterval,
                pointStart: dataSeries.pointStart,
                data: dataSeries.dataMax,
                visible: visibleSeries[i][1]
            },
            {
                name: 'Min',
                color: '#cf6600',
                dashStyle: 'ShortDash',
                pointInterval: pointInterval,
                pointStart: dataSeries.pointStart,
                data: dataSeries.dataMin,
                visible: visibleSeries[i][2]
            }
        ];
        yAxis = {
            title: {
                text: null
            },
            min: ymin,
            max: ymax,
            plotLines: plotLines
        };
    }
    chart[i] = $('#chart-'+i).highcharts({
        exporting: {
            enabled: false
        },
        chart: {
            type: chartType,
            backgroundColor: null,
            zoomType: 'xy'
        },
        title: {
            text: null
        },
        subtitle: {
            text: null
        },
        tooltip:{
            formatter: function() {
                return '<span style="font-size: 10px">' +
                Highcharts.dateFormat(tooltipFormatter, new Date(this.x))
                + '</span><br/>' + '<span style="color:' + this.series.color
                + '">\u25CF</span> ' + this.series.name + ': <b>'
                + this.y + '</b><br/>';
            },
            crosshairs: true
        },
        xAxis: {
            type: 'datetime',
        },
        yAxis: yAxis,
        legend: {
            enabled: true
        },
        plotOptions: plotOptions,
        series: series,
        credits: {
            enabled: false
        }
    });
    $('#chart-'+i).siblings(".topbar").find(".min-val").html(dataSeries.min);
    $('#chart-'+i).siblings(".topbar").find(".max-val").html(dataSeries.max);
    var unitStr = paneldata.unit;
    if (paneldata.useformule)
        unitStr = paneldata.unitconv;
    $('#chart-'+i).siblings(".topbar").find(".unit-val").html(unitStr);
    if(paneldata.alertmin != null && dataSeries.min < paneldata.alertmin){
        $('#chart-'+i).siblings(".topbar").find(".min-val").append("&nbsp;<i class='fa fa-exclamation-triangle text-warning'></i>");
    }
    if(paneldata.alertmin != null && dataSeries.max > paneldata.alertmax){
        $('#chart-'+i).siblings(".topbar").find(".max-val").append('&nbsp;<i class="fa fa-exclamation-circle text-danger"></i>');
    }
};
function changeChart(i, type) {
    console.log('changeChart...');
    var serieType;
    switch (parseInt(type)) {
        case 0:
            serieType = 'line';
            break;
        case 1:
            serieType = 'bar';
            break;
        case 2:
            serieType = 'area';
            break;
    }
    var series = chart[i].highcharts().series.length;
    for (s = 0; s < series; s++) {
        console.log('series: '+s, serieType);
        chart[i].highcharts().series[s].update({
            type: serieType
        });
    }
};
function createTable(i, paneldata, data) {
    console.log('createTable...');
    $('#table-'+i).empty();
    $('#menuoptionbar-'+i).empty();
    var lbl = 'Media';
    if ( paneldata.pr_id == 7 || paneldata.pr_id == 80 ) {
        lbl = 'Somma';
    }
    var addTable = '<table class="table table-striped table-bordered table-hover table-boxed" id="table-added-'+i+'">';
        addTable += '    <thead>';
        addTable += '        <tr>';
        if (visOptions.location == 'arpa' && userGroup == 300 && paneldata.inttime == 4){
            addTable += '            <th></th>';
        }
        addTable += '            <th>Data e ora</th>';
        addTable += '            <th>'+lbl+'</th>';
        addTable += '            <th>Min</th>';
        addTable += '            <th>Max</th>';
        addTable += '            <th>Door</th>';
        addTable += '        </tr>';
        addTable += '    </thead>';
        addTable += '    <tbody class="visualizer-table-body">';
        jQuery.each( data, function( index, val ) {
            addTable += '        <tr>';
            if (visOptions.location == 'arpa' && userGroup == 300 && paneldata.inttime == 4){
                var titleTool = 'default valido';
                var classA = 'validate';
                var classI = 'fa fa-circle text-warning';
                if ( val.calccode > 0 ) {
                    titleTool = 'validato';
                    classA = 'to-validate';
                    classI = 'fa fa-check-circle text-success style="color:green"';
                }
                if ( val.calccode > 4 ) {
                    titleTool = 'invalidato';
                    classA = 'not-valid';
                    classI = 'fa fa-exclamation-circle text-danger';
                }
                addTable += '            <td data-date="'+val.fulldate+'">';
                addTable += '               <a href="javascript:void(0);" title="'+titleTool+'" class="'+classA+'">';
                addTable += '               <i class="'+classI+'"></i></a>';
                addTable += '            </td>';
            }
            var dateStr;
            switch (parseInt(paneldata.inttime)) {
                case 6:
                    dateStr = val.fulldate.substring(0, 10);
                    break;
                case 8:
                    dateStr = val.fulldate.substring(0, 7);
                    break;
                default:
                    dateStr = val.fulldate.substring(0, 16);
            }
            addTable += '            <td>'+dateStr+'</td>';
            if (val.avg_value != null)
                addTable += '            <td>'+val.avg_value+'</td>';
            else
                addTable += '            <td></td>';
            if (val.min_value != null)
                addTable += '            <td>'+val.min_value+'</td>';
            else
                addTable += '            <td></td>';
            if (val.max_value != null)
                addTable += '            <td>'+val.max_value+'</td>';
            else
                addTable += '            <td></td>';
            if (val.door != null)
                addTable += '            <td>'+val.door+'</td>';
            else
                addTable += '            <td></td>';
            addTable += '        </tr>';
        });
        addTable += '    </tbody>';
        addTable += '</table>';
    $('#table-'+i).append(addTable);
};
function analyseData(obj, key){
    var series = {
        dataAvg: null,
        dataMax: null,
        dataMin: null,
        dataCum: null,
        max : null,
        min : null
    }
    var dataAvg = [];
    var dataMax = [];
    var dataMin = [];
    var dataCum = [];
    var max = -99999;
    var min = 99999;
    var pointStart = null;
    var cumulate = null;
    var dateStr = obj[0].fulldate;
    var re = new RegExp(/(\d\d\d\d)-(\d\d)-(\d\d)\s(\d\d):(\d\d):(\d\d)/);
    var m = re.exec(dateStr);
    if (m == null) {
        console.log("No match");
        return series;
    } else {
        pointStart = Date.UTC(m[1], m[2]-1, m[3], m[4], m[5], m[6]);
    }
    for(var i=0; i<obj.length; i++){
        if ( ! obj[i].avg_value ) {
            dataAvg.push(null);
        } else {
            var v = parseFloat( obj[i].avg_value ) ;
            dataAvg.push(v);
            if (v > max)
                max = v;
            if (v < min)
                min = v;
            cumulate = Math.round( (cumulate + v) * 100) / 100;
        }
        dataCum.push(cumulate);
        if ( ! obj[i].max_value ) {
            dataMax.push(null);
        } else {
            dataMax.push( parseFloat( obj[i].max_value ) );
        }
        if ( ! obj[i].min_value ) {
            dataMin.push(null);
        } else {
            dataMin.push( parseFloat( obj[i].min_value ) );
        }
    }
    series.dataAvg = dataAvg;
    series.dataMax = dataMax;
    series.dataMin = dataMin;
    series.dataCum = dataCum;
    if (max > -99999)
        series.max = max;
    if (min < 99999)
        series.min = min;
    series.pointStart = pointStart;
    return series;
}
function exportTableToCSV($table, filename) {
    var tmpColDelim = String.fromCharCode(11);
    var tmpRowDelim = String.fromCharCode(0);
    var colDelim = ';';
    var rowDelim = '\r\n';
    var $rows = $table.find('tr:has(th)');
    var csv = $rows.map(function (i, row) {
        var $row = $(row),
            $cols = $row.find('th');
        return $cols.map(function (j, col) {
            var $col = $(col),
                text = $col.text();
            return text;
        }).get().join(tmpColDelim);
    }).get().join(tmpRowDelim)
        .split(tmpRowDelim).join(rowDelim)
        .split(tmpColDelim).join(colDelim);
    csv = csv + rowDelim;
    $rows = $table.find('tr:has(td)');
    csv = csv + $rows.map(function (i, row) {
        var $row = $(row),
            $cols = $row.find('td');
        return $cols.map(function (j, col) {
            var $col = $(col),
                text = $col.text();
            return text.replace(/\./g, ',');
        }).get().join(tmpColDelim);
    }).get().join(tmpRowDelim)
        .split(tmpRowDelim).join(rowDelim)
        .split(tmpColDelim).join(colDelim);
    csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);
    $(this)
        .attr({
        'download': filename,
            'href': csvData,
            'target': '_blank'
    });
}
var map;
var stations_layer;
var stations_list = {};
var markerArray = new Array();
var blueIcon;
var selIcon;
var greIcon;
var yelIcon;
function initMap() {
    var latlngCenterMap = new L.LatLng(visOptions.map.latitude, visOptions.map.longitude);
    var southWest = new L.LatLng(45.307, 6.475);
    var northEast = new L.LatLng(46.111, 8.371);
    var bounds = new L.LatLngBounds(southWest, northEast);
    stations_layer = new L.LayerGroup();
    var osmAttrib = '';
    var osm1 = new L.TileLayer(visOptions.map.osmUrl, {minZoom: 5, maxZoom: 19});
    var aree_allertamento = new L.TileLayer.WMS("http://presidi.regione.vda.it/geoserver/wms", {
        layers: 'vda:aree_allertamento',
        format: 'image/png',
        transparent: true,
        attribution: "Aree di allertamento"
    });
    map = L.map('visualizer_map', {
        minZoom: 9,
        layers: [osm1, stations_layer],
        visualClickEvents: 'click contextmenu'
    });
    map.setView(latlngCenterMap, visOptions.map.zoom);
    map.touchZoom.disable();
    map.doubleClickZoom.disable();
    map.scrollWheelZoom.disable();
    var baseLayers = {
      "Colori": osm1
    };
    var overlays;
    overlays = {
      "Stazioni": stations_layer,
    };
    var control = L.control.zoomBox({
        modal: true,
    });
    map.addControl(control);
    customMarker = L.Marker.extend({
       options: {
          net: null
       }
    });
    var blueIconObj = L.Icon.Default.extend({
        options: { iconUrl: 'js-lily/plugins/leaflet/markers/marker-icon-def.png' }
    });
    blueIcon = new blueIconObj();
    var selIconObj = L.Icon.Default.extend({
        options: { iconUrl: 'js-lily/plugins/leaflet/markers/marker-icon-red.png' }
    });
    selIcon = new selIconObj();
    var greIconObj = L.Icon.Default.extend({
        options: { iconUrl: 'js-lily/plugins/leaflet/markers/marker-icon-green.png' }
    });
    greIcon = new greIconObj();
    var yelIconObj = L.Icon.Default.extend({
        options: { iconUrl: 'js-lily/plugins/leaflet/markers/marker-icon-yellow.png' }
    });
    yelIcon = new yelIconObj();
    var azIconObj = L.Icon.Default.extend({
        options: { iconUrl: 'js-lily/plugins/leaflet/markers/marker-icon-azure.png' }
    });
    azIcon = new azIconObj();
    var oraIconObj = L.Icon.Default.extend({
        options: { iconUrl: 'js-lily/plugins/leaflet/markers/marker-icon-orange.png' }
    });
    oraIcon = new oraIconObj();
    var vioIconObj = L.Icon.Default.extend({
        options: { iconUrl: 'js-lily/plugins/leaflet/markers/marker-icon-violet.png' }
    });
    vioIcon = new vioIconObj();
    $(window).load(function() {
        map.invalidateSize();
    });
    $(window).resize(function(){
        map.invalidateSize();
    });
}
var createMarkerList = function( stations ){
    console.log('createMarkerList()');
    selectedPageId = null;
    $("#markers-count").html(stations.length);
    $.each(stations, function(i,item){
        var p = new L.LatLng(item.lat_wgs84, item.lon_wgs84);
        var m = new customMarker( p,
        {
            alt: item.stid,
            icon: markerGetIconByNet(item.network_id),
            net: item.network_id
        }).addTo(stations_layer);
        m.on('click', function(e) {
            resetMarkersColor();
            m.setIcon(selIcon);
        });
        var html = '<div>' +
        '<h3>'+item.station_name+'</h3>' +
        '<div>Rete : '+item.network_type+'<br /><br />' +
        '<a href="#" onclick="loadPageWrapper('+item.pg_id+', \''+item.station_name+'\');return false;">Visualizza pagina</a>';
        if (visOptions.location == 'arpa' && userGroup == 304){
            var imgSrc = 'uploads/webcams/'+item.st_id+'/image.jpg?'+Math.random();
            html += '<br/><a href="'+imgSrc+'" title="'+item.station_name+'" class="single-image-gallery" >Visualizza webcam</a>';
        }
        html += '</div>';
        m.bindPopup(html);
        markerArray.push(m);
    });
}
function resetMarkersColor() {
    $.each(markerArray, function( index, item ) {
        item.setIcon( markerGetIconByNet(item.options.net) );
    });
}
function markerGetIconByNet(net) {
    var icon;
    switch (net) {
        case 0:
            icon = greIcon;
            break;
        case 1:
            icon = yelIcon;
            break;
        case 2:
            icon = azIcon;
            break;
        case 3:
            icon = blueIcon;
            break;
        case 4:
            icon = vioIcon;
            break;
        default:
            icon = oraIcon;
    }
    return icon;
}
function refreshStations(filter) {
    console.log('refreshStations');
    console.log('clear overlay');
    markerArray = new Array();
    stations_list = {};
    stations_layer.clearLayers();
    var jqxhr = $.ajax({
        url: 'visualizer_map_stations',
        type: "post",
        dataType: "json",
        data: {
            filter: filter
        },
    })
    .done(function(result) {
        if (result.res != 'OK') {
            bootbox.alert({
                message: 'Nessun dato ricevuto',
            });
            return false;
        }
        createMarkerList( result.stations );
    })
    .fail(function(xhr, err) {
        bootbox.alert({
            message: err,
        });
    });
}
function setDataValidCode(code, element) {
    console.log('setDataValidCode');
    var date = element.closest( "td" ).data( "date" );
    var stprid = element.closest( "div.col-lg-4" ).data( "stprid" );
    var jqxhr = $.ajax({
        url: 'visualizer_update_data_code',
        type: "post",
        dataType: "json",
        data: {
            date : date,
            stprid: stprid,
            code : code
        },
    })
    .done(function(result) {
    })
    .fail(function(xhr, err) {
        bootbox.alert({
            message: err,
        });
    });
}
