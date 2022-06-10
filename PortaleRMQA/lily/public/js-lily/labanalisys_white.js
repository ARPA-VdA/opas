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
var formule, volume;
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
    $( "#btn-close-view" ).on( "click", function() {
        $( "#view_sample" ).hide( "slow" );
    });
    $( "#refresh-list" ).click(function(e) {
        e.preventDefault();
        var selAnalysis = $('#filter_analysis').val();
        var selStations = $('#filter_stations').val();
        $.redirectPost( "labanalisys_white", {
            startDate : startDate,
            endDate : endDate,
            selAnalysis : selAnalysis,
            selStations : selStations
        } );
        return false;
    });
    $('.footable').footable();
    $('a[data-toggle="tab"]').on('shown.bs.tab', function(e){
        if ( e.target.id == '1' ) {
            var cd = $('#chart-cd').highcharts();
            if (cd != null) {
                cd.reflow();
            } else {
                createChart("chart-cd", "Cd Cadmio", 1, 0.004, 0.001);
            }
            var cr = $('#chart-cr').highcharts();
            if (cr != null){
                cr.reflow();
            } else {
                createChart("chart-cr", "Cr Cromo", 2, 1.45, 1.74);
            }
            var fe = $('#chart-fe').highcharts();
            if (fe != null){
                fe.reflow();
            } else {
                createChart("chart-fe", "Fe Ferro", 3, 15.77, 15.51);
            }
            var mn = $('#chart-mn').highcharts();
            if (mn != null){
                mn.reflow();
            } else {
                createChart("chart-mn", "Mn Manganese", 4, 0.43, 0.85);
            }
            var ni = $('#chart-ni').highcharts();
            if (ni != null){
                ni.reflow();
            } else {
                createChart("chart-ni", "Ni Nichel", 5, 2.48, 2.78);
            }
            var cu = $('#chart-cu').highcharts();
            if (cu != null){
                cu.reflow();
            } else {
                createChart("chart-pb", "Pb Piombo", 7, 0.50, 0.29);
            }
            var zn = $('#chart-zn').highcharts();
            if (zn != null){
                zn.reflow();
            } else {
                createChart("chart-cu", "Cu Rame", 8, 0.99, 0.79);
            }
            var as = $('#chart-as').highcharts();
            if (as != null){
                as.reflow();
            } else {
                createChart("chart-zn", "Zn Zinco", 9, 10.20 , 8.73);
            }
            var mo = $('#chart-mo').highcharts();
            if (mo != null){
                mo.reflow();
            } else {
                createChart("chart-as", "As Arsenico", 10, 0.17, 0.04);
            }
            var co = $('#chart-co').highcharts();
            if (co != null){
                co.reflow();
            } else {
                createChart("chart-mo", "Mo Molibdeno", 114, 0.46, 0.42);
            }
            var pb = $('#chart-pb').highcharts();
            if (pb != null){
                pb.reflow();
            } else {
                createChart("chart-co", "Co Cobalto", 116, 0.09, 0.40);
            }
        }
    });
});
function viewClearfields(){
    $(".clear-txt").text("");
    $("#table-data-sample").empty();
};
function createChart(id, title, labprid, lr, white){
    console.log('createChart - id:' + id);
    var jqxhr = $.ajax({
        url: 'labanalisys_white_chart_data',
        type: "post",
        dataType: "json",
        data: { labprid: labprid }
    })
    .done(function(result) {
        console.dir( result );
        if (!result) {
            if (!result.data){
                swal("Nessun dato", "Nessun dato trovato!", "error");
                return false;
            }
        }
        var categories = [];
        var series1 = [];
        var series2 = [];
        var series3 = [];
        var series4 = [];
        $.each( result.data, function( index, record ){
            categories.push(record.fulldate);
            series1.push(parseFloat(record.plouves_conc));
            series2.push(parseFloat(record.liconi_conc));
            series3.push(parseFloat(record.col_du_mont_conc));
            series4.push(parseFloat(record.lab2_conc));
        });
        Highcharts.setOptions({
            colors: ['#0c5c4c', '#ffa13a', '#0abe89', '#1c84c6', '#ed5666', '#f8ac5a', '#aaaaaa']
        });
        Highcharts.chart(id, {
            chart: {
                type: 'column'
            },
            credits: {
                enabled: true,
                href: '',
                text: 'Source: arpa vda'
            },
            title: {
                text: title
            },
            xAxis: {
                categories: categories,
                crosshair: true
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'µg/m³'
                },
                plotLines: [{
                    value: lr,
                    color: '#ff4822',
                    width: 2,
                    label: {
                        text: 'Valore lr: '+lr,
                        align: 'left',
                        style: {
                            color: 'gray'
                        }
                    }
                },{
                    value: white,
                    color: '#f62a7a',
                    width: 2,
                    label: {
                        text: 'Valore bianco: '+white,
                        align: 'right',
                        style: {
                            color: 'gray'
                        }
                    }
                }]
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                    '<td style="padding:0"><b>{point.y:.3f} mm</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: [{
                name: 'Plouves',
                data: series1
            }, {
                name: 'Liconi',
                data: series2
            }, {
                name: 'Col du mont',
                data: series3
            }, {
                name: 'Lab mobile',
                data: series4
            }]
        });
    })
    .fail(function(xhr, err) {
        toastr.error(err, 'Errore');
    });
};
