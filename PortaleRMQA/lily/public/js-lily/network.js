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
                console.log('popup is closed');
                editor1 = null;
                editor2 = null;
            }
        }
    });
}
var editor1;
var editor2;
function createCodeMirror1(){
    console.log('createCodeMirror1');
    if (editor1==null) {
        var item = document.getElementById("file1");
        if (item==null)
            return;
        console.log('createCodeMirror file1');
        editor1 = CodeMirror.fromTextArea(item, {
            lineNumbers: true,
            matchBrackets: true,
            styleActiveLine: true,
            theme:"ambiance",
        });
        editor1.setSize(800, 500);
    }
}
function createCodeMirror2(){
    console.log('createCodeMirror2');
    if (editor2==null) {
        var item = document.getElementById("file2");
        if (item==null)
            return;
        console.log('createCodeMirror file2');
        editor2 = CodeMirror.fromTextArea(item, {
            lineNumbers: true,
            matchBrackets: true,
            styleActiveLine: true,
            theme:"ambiance",
        });
        editor2.setSize(800, 500);
    }
}
$(function () {
    $(document).on( 'shown.bs.tab', 'a[data-toggle="tab"]', function (e) {
        console.dir(e)
        console.log(e.target)
        if ( e.target.hash == "#tab-2") {
            createCodeMirror1();
        }
        if ( e.target.hash == "#tab-3") {
            createCodeMirror2();
        }
    })
});
