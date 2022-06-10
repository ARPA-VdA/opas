function openPopup( url ){
    console.log('openPopup: '+url);
    $.magnificPopup.open({
        items: {
            src: url,
            type:'ajax',
            closeOnContentClick: false,
            closeBtnInside: false,
        },
        callbacks: {
            open: function() {
            },
                close: function() {
                editor = null;
            }
        }
    });
}
var editor;
function createCodeMirror(){
    console.log('createCodeMirror');
    if (editor==null) {
        editor = CodeMirror.fromTextArea(document.getElementById("file1"), {
            lineNumbers: true,
            matchBrackets: true,
            styleActiveLine: true,
            theme:"ambiance"
        });
        editor.setSize(800, 500);
    }
}
$(function () {
    $(document).on( 'shown.bs.tab', 'a[data-toggle="tab"]', function (e) {
        createCodeMirror();
    })
});
