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
        "order": [[ 2, "asc" ]],
    });
});
