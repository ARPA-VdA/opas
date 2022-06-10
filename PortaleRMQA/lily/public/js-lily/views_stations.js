$(document).ready(function() {
    $('.datatables-view').dataTable({
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
            { "sWidth": "30px", "aTargets": [ 0 ] }
        ],
        "order": [[ 3, "asc" ]],
    });
    $('#from, #until').datepicker({
        language: 'it',
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true
    });
    $('#from, #until').datepicker('update', 'today');
    $(".chosen-select").chosen({disable_search_threshold: 10});
});
