$(document).ready(function() {
    $('.dataTables-desc').dataTable({
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
        "order": [[ 0, "asc" ]],
    });
});
