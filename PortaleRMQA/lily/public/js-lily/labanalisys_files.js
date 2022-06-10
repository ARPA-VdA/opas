$(document).ready(function() {
    $("#input-file").fileinput({
        language: "it",
        uploadAsync: true,
        maxFileSize: 1000,
        maxFilePreviewSize: 1000,
        showPreview: false,
        uploadUrl: "labanalisys_file",
        allowedFileExtensions: ["xls"],
        initialCaption: "Seleziona un file (xls)",
        uploadExtraData:function(previewId, index) {
            var data = {
                id : $("#type_analysis").val()
            };
            return data;
        },
    });
    $('#input-file').fileinput('disable');
    $('#input-file').on('fileuploaded', function(event, data, previewId, index) {
        console.log('File uploaded triggered');
        location.reload();
    });
    $( "#type_analysis" ).change(function() {
        var idx = $("#type_analysis").val();
        console.log('type_analysis change, idx:'+idx);
        if (idx < 0) {
            $('#input-file').fileinput('disable');
        } else {
            $('#input-file').fileinput('enable');
        }
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
        "aoColumnDefs": [],
    });
});
