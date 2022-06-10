var group_sel;
var page_sel;
$(document).ready(function() {
    $("#list-groups").sortable({
           start: function(event, ui) {
            ui.item.startPos = ui.item.index();
        },
        stop: function(event, ui) {
            var po = ui.item.index();
            var id = ui.item.data("grid");
            console.log("New position: " + ui.item.index());
            console.log("Id: " + ui.item.data( "grid" ));
            setItemPosition('visualizer_update_group_pos',po,id,null);
        }
    }).disableSelection();
    $("#list-pages").sortable({
           start: function(event, ui) {
            ui.item.startPos = ui.item.index();
        },
        stop: function(event, ui) {
            var po = ui.item.index();
            var id = ui.item.data("pgid");
            console.log("New position: " + ui.item.index());
            console.log("Id: " + ui.item.data( "pgid" ));
            console.log("Group sel: "+group_sel);
            setItemPosition('visualizer_update_page_pos',po,id,group_sel);
        }
    }).disableSelection();
    $("#list-windows").sortable({
           start: function(event, ui) {
            ui.item.startPos = ui.item.index();
        },
        stop: function(event, ui) {
            var po = ui.item.index();
            var id = ui.item.data("wdid");
            console.log("New position: " + ui.item.index());
            console.log("Id: " + ui.item.data( "wdid" ));
            console.log("Page sel: "+page_sel);
            setItemPosition('visualizer_update_window_pos',po,id,page_sel);
        }
    }).disableSelection();
    setEditTable();
    $( ".ibox-content" ).on( "click", ".trash-group", function(e) {
        e.preventDefault();
        var deleted = $(this).parent();
        var id = $(this).parent().data("grid");
        console.log(id);
        console.log(deleted);
        swal({
            title: "Elimina elemento",
            text: "Sei proprio sicuro di voler eliminare il elemento?",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Elimina",
            closeOnConfirm: false,
            cancelButtonText: "Annulla"
        }, function () {
            deleted.remove();
            swal("Eliminato", "Il elemento selezionato è stato eliminato", "success");
        });
    });
    $( ".ibox-content" ).on( "click", ".trash-param", function(e) {
        e.preventDefault();
        var deleted = $(this).parent().parent();
        console.log(deleted);
        swal({
            title: "Elimina parametro",
            text: "Sei proprio sicuro di voler eliminare il parametro?",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Elimina",
            closeOnConfirm: false,
            cancelButtonText: "Annulla"
        }, function () {
            deleted.remove();
            swal("Eliminato", "Il parametro selezionato è stato eliminato", "success");
        });
    });
    $( "#open-popup" ).on( "click", "#param-cancel", function(e) {
        $.magnificPopup.close();
    });
    $("#sub-groups").hide();
    $("#param-groups").hide();
    $( "#groups" ).on( "click", ".view-groups", function(e) {
        $("#param-groups").hide();
        $(".list_groups li").removeClass("sel-group");
        group_sel = $(this).parent().data("grid");
        getPagesByGroup(group_sel);
        $("#sub-groups").show();
        $(this).parent().addClass("sel-group");
        var txt = $(this).parent().children().eq(0).text();
        console.log("ecco: "+txt);
        $("#sub-groups-title strong").text(txt);
    });
    var txtStat ;
    $( "#sub-groups" ).on( "click", ".view-params", function(e) {
        $(".list_pages li").removeClass("sel-group");
        page_sel = $(this).parent().data("pgid");
        getWindowsByPage(page_sel);
        $("#param-groups").show();
        $(this).parent().addClass("sel-group");
        txtStat = $(this).parent().children().eq(0).text();
        console.log("ecco: "+txtStat);
        $("#param-groups-title strong").text(txtStat);
        setTimeout(function(){
            $(document).scrollTop( $("#param-groups").offset().top );
        }, 100);
    });
    $( "#param-groups" ).on( "click", ".open-popup-link", function(e) {
        var wdid = $(this).parent().data("wdid");
        var paramTxt = $(this).parent().text();
        $("#txt-param").text(paramTxt);
        $("#txt-stat").text(txtStat);
        console.log("paramTxt: "+paramTxt);
        editWindowById(wdid);
    });
    setMagnificPopup();
    $("#form_update_window").submit(function(event){
        $.ajax({
            type: "POST",
            url: 'visualizer_update_window',
            data: $("#form_update_window").serialize(),
            success: function(data) {
                console.dir(data);
                if (data.res == "OK"){
                    toastr.info('Parametro modificato correttamente', 'Info');
                    $.magnificPopup.close();
                }else{
                    toastr.warning('Modifica Parametro non riuscita', 'Info');
                }
            }
        });
        return false;
    });
    $('#groups .editor-group').on('save', function(e, params) {
        console.dir(e);
        console.dir(e.target.parentElement.attributes[1].value);
        console.log('Saved value: ' + params.newValue);
        var name = params.newValue;
        var id = e.target.parentElement.attributes[1].value;
        var jqxhr = $.ajax({
            url: 'visualizer_update_group_name',
            type: "post",
            dataType: "json",
            data: {
                name: name,
                id: id
            },
        })
        .done(function(result) {
            console.log( "success" );
        })
        .fail(function(xhr, err) {
            bootbox.alert({
                message: err,
            });
        });
    });
    $('#sub-groups').on( "click", ".editable-submit", function(e) {
        var name = e.target.parentElement.parentElement.previousElementSibling.firstChild.value;
        var id = (e.target).closest( "li" ).attributes[1].value;
        var jqxhr = $.ajax({
            url: 'visualizer_update_page_name',
            type: "post",
            dataType: "json",
            data: {
                name: name,
                id: id
            },
        })
        .done(function(result) {
            console.log( "success" );
        })
        .fail(function(xhr, err) {
            bootbox.alert({
                message: err,
            });
        });
    });
    $('#param-groups').on( "click", ".editable-submit", function(e) {
        console.dir(e);
        console.dir((e.target).closest( "li" ).attributes[1].value);
        console.dir(e.target.parentElement.parentElement.previousElementSibling.firstChild.value);
        var name = e.target.parentElement.parentElement.previousElementSibling.firstChild.value;
        var id = (e.target).closest( "li" ).attributes[1].value;
        var jqxhr = $.ajax({
            url: 'visualizer_update_window_name',
            type: "post",
            dataType: "json",
            data: {
                name: name,
                id: id
            },
        })
        .done(function(result) {
            console.log( "success" );
        })
        .fail(function(xhr, err) {
            bootbox.alert({
                message: err,
            });
        });
    });
});
function setItemPosition(url,po,id,sel){
    var jqxhr = $.ajax({
        url: url,
        type: "post",
        dataType: "json",
        data: {
            po: po,
            id: id,
            se: sel
        },
    })
    .done(function(result) {
        console.log( "success" );
    })
    .fail(function(xhr, err) {
        bootbox.alert({
            message: err,
        });
    });
}
function setEditTable() {
    $('.editor-group').editable({
        placement: 'top',
        inputclass: 'editor-group-css',
        emptytext: 'Vuoto',
        validate: function(value) {
            if($.trim(value) == '')
                return 'Parametro richiesto';
            else if($.trim(value).length>30)
                return 'Only 30 charateres are allowed';
        }
    });
}
function setMagnificPopup() {
    $('.open-popup-link').magnificPopup({
      callbacks: {
        open: function(e) {
            console.log('magnificPopup open');
            $('#param-color').colorpicker({
            }).on('changeColor', function(ev) {
                console.log('changeColor');
                console.log('hexString: '+ev.color.toHex());
                $('#param-color').css("background-color", ev.color.toHex());
                $('#param-color-hex').val(ev.color.toHex());
            });
        },
        close: function() {
        }
      }
    });
}
function getPagesByGroup(grid) {
    console.log('getPagesByGroup:' + grid);
    var list = $(".list_pages");
    list.empty();
    var jqxhr = $.ajax({
        url: 'visualizer_pages',
        type: "post",
        dataType: "json",
        data: {
            grid: grid
        },
    })
    .done(function(result) {
        console.log( "success" );
        console.dir(result.data);
        jQuery.each( result.data, function( i, val ) {
            var add_li = '<li class="info-element" data-pgid="'+val.pg_id+'">';
                add_li +='<a href="#" class="editor-group" data-type="text" data-title="Cambia nome sotto-gruppo">'+val.name+'</a>';
                add_li +='<a href="#" class="pull-right btn btn-xs btn-white mrl view-params"><i class="fa fa-bars"></i></a>';
                add_li +='</li>';
            list.append(add_li);
        });
        setEditTable();
    })
    .fail(function(xhr, err) {
        bootbox.alert({
            message: err,
        });
    });
}
function getWindowsByPage(pgid) {
    console.log('getWindowsByPage:' + pgid);
    var list = $(".list_windows");
    list.empty();
    var jqxhr = $.ajax({
        url: 'visualizer_windows',
        type: "post",
        dataType: "json",
        data: {
            pgid: pgid
        },
    })
    .done(function(result) {
        console.log( "success" );
        jQuery.each( result.data, function( i, val ) {
            var add_li = '<li class="warning-element" data-wdid="'+val.wd_id+'">';
                add_li +='    <a href="#" class="editor-group" data-type="text" data-title="Cambia nome parametro">'+val.name+'</a>';
                add_li +='        <a href="#open-popup" class="pull-right btn btn-xs btn-white mrl open-popup-link"><i class="fa fa-wrench"></i></a>';
                add_li +='</li>';
            list.append(add_li);
        });
        setEditTable();
        setMagnificPopup()
    })
    .fail(function(xhr, err) {
        bootbox.alert({
            message: err,
        });
    });
}
function editWindowById(wdid) {
    console.log('editWindowById:' + wdid);
    clearFields();
    var jqxhr = $.ajax({
        url: 'visualizer_window',
        type: "post",
        dataType: "json",
        data: {
            wdid: wdid
        },
    })
    .done(function(result) {
        console.log( "success" );
        console.dir(result.data);
        $( "#param-wdid" ).val(result.data.wd_id);
        $( "#param-label" ).val(result.data.name);
        $( "#param-dec" ).val(result.data.decimals);
        $( "#param-days" ).val(result.data.nodays);
        if (result.data.showmaxvalues) { $('#param-maxval').iCheck('check'); }
        if (result.data.showminvalues) { $('#param-minval').iCheck('check'); }
        $( "#param-y" ).val(result.data.autoscale);
        if (result.data.points) { $('#param-points').iCheck('check'); }
        if (result.data.marks) { $('#param-values').iCheck('check'); }
        $( "#param-min" ).val(result.data.scalemin);
        $( "#param-max" ).val(result.data.scalemax);
        $( "#param-almin" ).val(result.data.alertmin);
        $( "#param-almax" ).val(result.data.alertmax);
        $( "#param-red" ).val(result.data.linered);
        $( "#param-orange" ).val(result.data.lineorange);
        $( "#param-green" ).val(result.data.linegreen);
        $( "#param-formule" ).val(result.data.formule);
        if (result.data.useformule) { $('#param-formule-correction').iCheck('check'); }
        $( "#param-idtable" ).val(result.data.view_id);
        if (result.data.useview) { $('#param-vision').iCheck('check'); }
        var color = result.data.color;
        var hexString = '#' + color.toString(16);
        console.log('hexString: '+hexString);
        $( "#param-color" ).colorpicker('setValue', hexString);
    })
    .fail(function(xhr, err) {
        bootbox.alert({
            message: err,
        });
    });
}
function clearFields() {
    $( "#param-wdid" ).val("");
    $( "#param-label" ).val("");
    $( "#param-dec" ).val("");
    $( "#param-days" ).val(-1);
    $( "#param-color" ).val("");
    $( "#param-color-hex" ).val("");
    $( "#param-y" ).val(-1);
    $( "#param-min" ).val("");
    $( "#param-max" ).val("");
    $( "#param-almin" ).val("");
    $( "#param-almax" ).val("");
    $( "#param-red" ).val("");
    $( "#param-orange" ).val("");
    $( "#param-green" ).val("");
    $( "#param-formule" ).val("");
    $( "#param-idtable" ).val("");
    $('#param-maxval').iCheck('uncheck');
    $('#param-minval').iCheck('uncheck');
    $('#param-points').iCheck('uncheck');
    $('#param-values').iCheck('uncheck');
    $('#param-formule-correction').iCheck('uncheck');
    $('#param-vision').iCheck('uncheck');
};
