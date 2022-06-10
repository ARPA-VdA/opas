$(document).ready(function() {
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
        "order": [[ 0, "asc" ]]
    });
    $('.input-group.date').datepicker({
        language: 'it',
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true,
        format: "dd/mm/yyyy",
        endDate: "today",
        language: "it"
    });
    $('.input-group.date').datepicker('update', 'today');
});
