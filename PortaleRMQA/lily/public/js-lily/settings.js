$(document).ready(function() {
    $('#change-psw').submit(function(e) {
        console.log('*--- modifica password ---*');
        var oldpsw = $('#change-psw #old-psw').val();
        console.log('vecchia psw: '+ oldpsw);
        var newpsw = $('#change-psw #new-psw').val();
        console.log('nuova psw: '+ newpsw);
        var jqxhr = $.ajax({
            url: 'settings_psw',
            type: "post",
            data: {
                old_psw: oldpsw,
                new_psw: newpsw
            },
        })
        .done(function(result) {
            console.log( "success" );
            toastr.info(result.desc, 'Info')
        })
        .fail(function(xhr, err) {
            console.log( "error" );
            toastr.error(err, 'Errore')
        });
        e.preventDefault();
    });
    $("#save-setting-hp").on( "click", function() {
        var a = [];
        $('#sortable').children().each(function (i) {
            var pos = $(this).attr('id');
            a.push(pos);
        });
        var b = [];
        $('#sortable').children().find("input").each(function (i) {
            b.push($(this).prop('checked'));
        });
        console.log(a.join());
        console.log(b.join());
        var jqxhr = $.ajax({
            url: 'settings_homepage',
            type: "post",
            data: {
                array_pos : a,
                array_onoff: b
            },
        })
        .done(function(result) {
            console.log( "success" );
            toastr.info(result.desc, 'Info')
        })
        .fail(function(xhr, err) {
            console.log( "error" );
            toastr.error(err, 'Errore')
        });
    });
    $("#reset-setting-hp").on( "click", function() {
        var jqxhr = $.ajax({
            url: 'settings_homepage_reset',
            type: "post",
            data: {},
        })
        .done(function(result) {
            console.log( "success" );
            toastr.info(result.desc, 'Info')
        })
        .fail(function(xhr, err) {
            console.log( "error" );
            toastr.error(err, 'Errore')
        });
    });
    $('#sortable').sortable({
    }).disableSelection();
});
