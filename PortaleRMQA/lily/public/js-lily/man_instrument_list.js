   $(document).ready(function() {
    $( "#view_instrument" ).hide();
    $( "#add_instrument" ).hide();
    $( "#btn-add-instrument" ).click(function() {
        $( "#add_instrument" ).show( "slow" );
        $('#add_instrument h5').text('Aggiungi bombola');
        $('#btn-instrument-form').text('Salva');
        $('#instrument-form').attr('action', 'man_instrument_new');
        $('#add_instrument h5').text('Aggiungi strumento');
        $('#btn-instrument-form').text('Salva');
        clearfields();
    });
    $( "#cancel-instrument-form" ).on( "click", function() {
        $( "#add_instrument" ).hide( "slow" );
        clearfields();
        return false;
    });
    $( "#btn-close-view" ).on( "click", function() {
        $( "#view_instrument" ).hide( "slow" );
    });
    $( ".row" ).on( "click", ".view-tool", function(e) {
        viewClearfields();
        $('#add_instrument').hide( "slow" );
        $( "#view_instrument" ).show( "slow" );
        var id = $(this).parent().parent().data("id");
        console.log('id:'+id);
        loadReport(id, 'show');
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".set-tool", function(e) {
        clearfields();
        var id = $(this).parent().parent().data("id");
        console.log(id);
        $( "#add_instrument" ).show( "slow" );
        $( "#view_instrument" ).hide( "slow" );
        $('#instrument-form').attr('action', 'man_instrument_edit');
        $('#add_instrument h5').text('Modifica strumento');
        $('#btn-instrument-form').text('Modifica');
        loadReport(id, 'edit');
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".delete-tool", function(e) {
        var deleted = $(this).parent().parent();
        var id = $(this).parent().parent().data("id");
        console.log("MY ID: "+id);
        console.log("deleted: "+deleted);
        swal({
            title: "Elimina lo strumento",
            text: "Sei proprio sicuro di voler eliminare lo strumento selezionato?",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Elimina",
            closeOnConfirm: false,
            cancelButtonText: "Annulla"
        }, function () {
            var jqxhr = $.ajax({
                url: 'man_instrument_delete',
                type: "post",
                dataType: "json",
                data: { id: id },
            })
            .done(function(result) {
                console.dir( result );
                deleted.remove();
                if ( result ==1 )
                    swal("Eliminato", "Lo strumento selezionato è stato eliminato", "success");
                else
                    swal("Strumento non eliminato", "Errore durante l'eliminazione dello strumento", "error");
            })
            .fail(function(xhr, err) {
                toastr.error(err, 'Errore');
            });
        });
        e.preventDefault();
        return false;
    });
    $( "#add_instrument" ).on( "click", ".btn-verify", function(e) {
        e.preventDefault();
        var id = $('#arpa-id').val();
        console.log(id);
        swal({
            title: "Verifica id",
            text: "Verificare l'arpa id: "+id,
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Verifica",
            closeOnConfirm: false,
            cancelButtonText: "Annulla"
        }, function () {
            var jqxhr = $.ajax({
                url: 'man_instrument_arpa_id',
                type: "post",
                dataType: "json",
                data: { id: id },
            })
            .done(function(result) {
                console.dir( result );
                if ( result ==1 )
                    swal("Verificato", "L'arpa id è stato verificato e risulta disponibile", "success");
                else
                    swal("Id non disponibile", "Id arpa inserito è già stato utilizzato", "error");
            })
            .fail(function(xhr, err) {
                toastr.error(err, 'Errore');
            });
        });
    });
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
        "aoColumnDefs": [
            { 'bSortable': false, 'aTargets': [ 0 ] },
            { "sWidth": "50px", "aTargets": [ 0 ] }
        ],
    });
    $('#date-delivery').datepicker({
        language: 'it',
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true,
    });
    $('#instrument-form').validate({
        rules: {
            'arpa-id': {
                required: true
            },
            'name': {
                required: true
            },
            'in-ty-id': {
                required: true,
                min: 0
            },
            'serial-numb': {
                required: true
            },
            'date-delivery': {
                required: true
            },
        },
        messages: {
            'arpa-id': {
                required: "Inserire un codice Arpa ID"
            },
            'name': {
                required: "Inserire nome strumento"
            },
            'in-ty-id': {
                min: "Selezionare tipo strumento"
            },
            'serial-numb': {
                required: "Inserire un numero di serie"
            },
            'date-delivery': {
                required: "Inserire data di consegna strumento"
            },
        },
        ignore: "",
    });
    $("#instrument-form").submit(function(event){
        if (! $('#instrument-form').valid() ) {
            console.log('Form non valido!');
            return false;
        }
        console.log('Form valido.');
        return true;
    });
});
function clearfields(){
    $('#date-delivery, #arpa-id, #name, #serial-numb').val('');
    $("#in-ty-id").val('-1');
};
function viewClearfields(){
    $(".clear-txt").text("");
};
function loadReport(id, dest) {
    console.log('loadReport(' + id + ' -> ' + dest + ')');
    var jqxhr = $.ajax({
        url: 'man_instrument_get',
        type: "post",
        dataType: "json",
        data: { id: id },
    })
    .done(function(result) {
        console.dir( result );
        if (dest == 'show')
            viewIns(result.instrument);
        if (dest == 'edit')
            editIns(result.instrument);
    })
    .fail(function(xhr, err) {
        return null;
    });
}
function viewIns(report) {
    viewClearfields();
    console.log('viewIns');
    console.dir(report);
    $("#view-arpa-id").text(report.arpa_id);
    $("#view-name").text(report.strumento);
    $("#view-in-ty-id").text(report.marca+" ("+report.modello+")");
    $("#view-serial-numb").text(report.numero_serie);
    $("#view-date-delivery").text(report.data_consegna_format);
}
function editIns(report) {
    clearfields();
    console.log('editIns');
    console.dir(report);
    $('#in-id').val(report.in_id);
    $('#arpa-id').val(report.arpa_id);
    $('#name').val(report.strumento);
    $('#in-ty-id').val(report.in_ty_id);
    $('#serial-numb').val(report.numero_serie);
    $('#date-delivery').datepicker('update', report.data_consegna_format);
}
