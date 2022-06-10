$.extend(
{
    redirectPost: function(location, args)
    {
        var form = '';
        $.each( args, function( key, value ) {
            form += '<input type="hidden" name="'+key+'" value="'+value+'">';
        });
        $('<form action="' + location + '" method="POST">' + form + '</form>').appendTo($(document.body)).submit();
    }
});
$(document).ready(function() {
    $( "#add_equipment" ).hide();
    $( ".row" ).on( "click", ".set-tool", function(e) {
        clearfields();
        var id = $(this).parent().parent().data("eqid");
        console.log(id);
        $( "#add_equipment" ).show( "slow" );
        $( "#view_equipment" ).hide( "slow" );
        $('#equipment-form').attr('action', 'man_allocation_edit_equipment');
        $('#add_equipment h5').text('Modifica dotazione');
        $('#btn-equipment-form').text('Modifica');
        loadEquipment(id, 'edit');
        e.preventDefault();
        return false;
    });
    $( ".row" ).on( "click", ".delete-tool", function(e) {
        e.preventDefault();
        var deleted = $(this).parent().parent();
        var id = $(this).parent().parent().data("eqid");
        console.log(id);
        swal({
            title: "Elimina dotazione",
            text: "Sei proprio sicuro di voler eliminare la dotazione selezionata?",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Elimina",
            closeOnConfirm: false,
            cancelButtonText: "Annulla"
        }, function () {
            var jqxhr = $.ajax({
                url: 'man_allocation_delete_equipment',
                type: "post",
                dataType: "json",
                data: { id: id },
            })
            .done(function(result) {
                console.dir( result );
                deleted.remove();
                if ( result ==1 )
                    swal("Eliminata", "La dotazione selezionata è stato eliminata", "success");
                else
                    swal("Dotazione non eliminata", "Errore durante l'eliminazione della dotazione", "error");
            })
            .fail(function(xhr, err) {
                toastr.error(err, 'Errore');
            });
        });
    });
    $( "#add_equipment" ).on( "click", ".btn-verify", function(e) {
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
                url: 'man_allocation_arpa_id',
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
    $('#equipment-date-built, #equipment-date-expiry').datepicker({
        language: 'it',
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true,
    });
    $('#equipment-date-built, #equipment-date-expiry').datepicker('update', 'today');
    $('#values-ins').hide();
    $( "#refresh-list" ).click(function(e) {
        e.preventDefault();
        $.redirectPost( "man_equipment_list", {
        } );
        return false;
    });
    $( "#cancel-equipment-form" ).on( "click", function() {
        $( "#add_equipment" ).hide( "slow" );
        clearfields();
        return false;
    });
    $( "#btn-close-view" ).on( "click", function() {
        $( "#view_equipment" ).hide( "slow" );
    });
    $( "#view_equipment" ).hide();
    $( ".row" ).on( "click", ".view-tool", function(e) {
        $('#add_equipment').hide( "slow" );
        $( "#view_equipment" ).show( "slow" );
        var id = $(this).parent().parent().data("eqid");
        console.log('id:'+id);
        loadEquipment(id, 'show');
        e.preventDefault();
        return false;
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
        "order": [[ 1, "asc" ]],
    });
    $( "#download-csv" ).click(function(e) {
        e.preventDefault();
        $.redirectPost( "man_allocation_csv", {
        } );
        return false;
    });
    $("#btn-add-equipment").click(function() {
        $("#pdf_current").hide();
        $("#add_equipment").show( "slow" );
        $('#add_equipment h5').text('Aggiungi dotazione');
        $('#btn-equipment-form').text('Salva');
        $('#equipment-form').attr('action', 'man_allocation_new_equipment');
        clearfields();
    });
    $('#equipment-form').validate({
        rules: {
            'arpa-id': {
                required: true
            },
            'equipment': {
                required: true
            },
        },
        messages: {
            'arpa-id': {
                required: "Inserire un codice Arpa ID"
            },
            'equipment': {
                required: "Inserire il nome della dotazione"
            },
        },
        ignore: "",
    });
    $("#equipment-form").submit(function(event){
        if (! $('#equipment-form').valid() ) {
            console.log('Form non valido!');
            return false;
        }
        console.log('Form valido.');
        return true;
    });
});
function clearfields(){
    $("#arpa-id").val('');
    $("#equipment").val('');
    $('#values-ins').hide();
    $('#equipment-form input').iCheck('uncheck');
};
function viewClearfields(){
    console.log('viewClearfields');
    $(".clear-txt").text("");
};
function loadEquipment(id, dest) {
    console.log('loadEquipment(' + id + ' -> ' + dest + ')');
    var jqxhr = $.ajax({
        url: 'man_allocation_get_equipment',
        type: "post",
        dataType: "json",
        data: { id: id },
    })
    .done(function(result) {
        console.dir( result );
        if (dest == 'show')
            viewequipment(result.equipment);
        if (dest == 'edit')
            editequipment(result.equipment);
    })
    .fail(function(xhr, err) {
        return null;
    });
}
function viewequipment(report) {
    viewClearfields();
    console.log('viewequipment');
    console.dir(report);
    $("#view-arpa-id").text(report.arpa_id);
    $("#view-equipment").text(report.equipment);
}
function editequipment(report) {
    clearfields();
    console.log('editequipment');
    console.dir(report);
    $('#equipment-eq-id').val(report.eq_id);
    $('#arpa-id').val(report.arpa_id);
    $('#equipment').val(report.equipment);
}
