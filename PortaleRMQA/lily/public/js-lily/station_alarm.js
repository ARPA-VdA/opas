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
    $('#reportrange').daterangepicker({
        format: 'DD/MM/YYYY',
        startDate: moment().subtract(29, 'days'),
        endDate: moment(),
        minDate: moment().subtract(8, 'years'),
        showDropdowns: true,
        showWeekNumbers: true,
        timePicker: false,
        timePickerIncrement: 1,
        timePicker12Hour: true,
        ranges: {
            'Oggi': [moment(), moment()],
            'Ieri': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            'Ultimi 7 Giorni': [moment().subtract(6, 'days'), moment()],
            'Ultimi 30 Giorni': [moment().subtract(29, 'days'), moment()],
            'Questo Mese': [moment().startOf('month'), moment().endOf('month')],
            'Mese Scorso': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
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
        var stId = $("#account").val();
        $.redirectPost( "station_alarm", {
            stId : stId,
            startDate: startDate,
            endDate : endDate
        } );
        return false;
    });
    $.fn.dataTable.moment( 'DD.MM.YYYY [h] HH.mm' );
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
        "order": [[ 0, "desc" ]]
    });
});
