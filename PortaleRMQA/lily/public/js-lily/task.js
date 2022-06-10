$(document).ready(function() {
    $(".check-link").on( "click", function() {
        var button = $(this).find('i');
        var label = $(this).next('span');
        var id = $(this).parent().parent().data('id');
        var appendto = $(this).parent().parent().find('.task-ouverture');
        console.log(appendto);
        if ($(button).hasClass("fa-check-square")){
            bootbox.confirm({
                message: "Sei sicuro di voler chiudere questo task? Questa azione non è annullabile!",
                buttons: {
                    confirm: {
                        label: "Si, chiudi",
                        className: "btn-primary btn-sm",
                    },
                   cancel: {
                        label: "Annulla",
                        className: "btn-sm",
                    }
                },
                callback: function(result) {
                    if(result) {
                        var jqxhr = $.ajax({
                            url: 'task_set_done',
                            type: "post",
                            data: {
                                id: id
                            },
                        })
                        .done(function(result) {
                            console.log( "success" );
                            toastr.info(result.desc, 'Info')
                            var closed;
                            closed = '<div class="col-lg-6 text-right text-success">CHIUSO:&nbsp;'+user+'</div>';
                            $(appendto).append(closed);
                        })
                        .fail(function(xhr, err) {
                            console.log( "error" );
                            toastr.error(err, 'Errore')
                        });
                    } else {
                        button.toggleClass('fa-check-square').toggleClass('fa-square-o');
                        label.toggleClass('todo-completed');
                    }
                }
            });
        }else{
            toastr.error('Task già chiuso', 'Attenzione')
            button.toggleClass('fa-check-square').toggleClass('fa-square-o');
            label.toggleClass('todo-completed');
        }
    });
    $('#insert-task').submit(function(e) {
        console.log('*--- aggiungi task ---*');
        var tag = $("#tag option").filter(":selected").val();
        console.log('tag: '+ tag);
        var sid = $("#sid option").filter(":selected").val();
        console.log('sid: '+ sid);
        var station = $("#sid option").filter(":selected").text();
        var msg = $('#description').val();
        console.log('msg: '+ msg);
        var rec = $('input[type="radio"]:checked').val();
        console.log('rec: '+ rec);
        var addtag;
        if (tag == 1) {
            addtag = ' fa-tag ';
        } else if (tag == 2) {
            addtag = ' fa-sign-in ';
        } else if (tag == 3) {
            addtag = ' fa-wrench ';
        } else if (tag == 4) {
            addtag = ' fa-magic ';
        } else {
            addtag = ' fa-map-marker ';
        };
        var color;
        if (rec == 'Arpa') {
            color = ' label-warning ';
        } else {
            color = ' label-info ';
        };
        var jqxhr = $.ajax({
            url: 'task_new',
            type: "post",
            data: {
                tag: tag,
                msg: msg,
                rec: rec,
                sid: sid,
            },
        })
        .done(function(result) {
            console.dir( result );
            toastr.info(result.desc, 'Info')
            var box;
            box = '<li data-id="">';
            box += '   <small class="always-right label '+color+'"><i class="fa fa-times"></i> '+rec+'</small>';
            box += '    <div class="task-details">';
            box += '        <a href="#" class="check-link"><i class="fa fa-square-o"></i></a>';
            box += '        <span class="m-l-xs">&nbsp;<i class="fa '+addtag+' ico-label"></i>&nbsp;<strong>'+station+'</strong>&nbsp;'+msg+'</span>';
            box += '    </div>';
            box += '    <div class="row task-ouverture">';
            box += '        <div class="col-lg-6 text-muted">APERTO:&nbsp;'+user+'</div>';
            box += '    </div>';
            box += '</li>';
            console.log(box);
            $("#all-tasks").prepend(box);
            $('#description').val('');
            $("#sid").val(0);
            $("#tag").val(0);
        })
        .fail(function(xhr, err) {
            console.log( "error" );
            toastr.error(err, 'Errore')
        });
        e.preventDefault();
    });
});
