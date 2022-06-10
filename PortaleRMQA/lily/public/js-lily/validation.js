$(document).ready(function() {
 $(".chosen-select").chosen({width: "99%!important"});
 $('#datepicker').datepicker({
        language: 'it',
        keyboardNavigation: false,
        forceParse: false,
        autoclose: true
    });
    $('#parameters').hide();
    $('#more-info').hide();
    $('#send').hide();
    $('#validation-data').hide();
    $('#select-station').bind('change', function (e) {
        if( $(this).val() == -1) {
            $('#parameters').hide();
        }
        else {
            $('#parameters').show();
        }
    });
    $('#select-params').on('change', function(evt, params) {
        values = $("#select-params").chosen().val();
        console.dir(values);
        console.log(values);
        if ( values !== null){
            $('#more-info').show();
        }
        else{
            $('#more-info').hide();
        }
    });
    $('#select-data-type, #datepicker input').bind('change', function (e) {
        if( ($('#select-data-type').val() > -1 ) && ($('#date-start').val() !== '') && ($('#date-end').val() !== '') ) {
            $('#send').show();
        }
        else {
            $('#send').hide();
        }
    });
    $( "#do-process" ).on( "click", function() {
        $('#validation-data').show();
    });
    $( "#redo-process" ).on( "click", function() {
        $("#select-station").val(-1);
        $('#select-params').val('').trigger('chosen:updated');
        $('#select-data-type').val(-1);
        $('#date-start').val('');
        $('#date-end').val('');
        $('#parameters').hide();
        $('#more-info').hide();
        $('#send').hide();
        $('#validation-data').hide();
    });
});
