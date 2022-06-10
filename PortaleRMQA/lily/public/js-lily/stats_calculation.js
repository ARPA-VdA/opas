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
    $('#stats').hide();
    $('#send').hide();
    $('#validation-data').hide();
    $('#select-station').bind('change', function (e) {
        if( $(this).val() == -1) {
            $('#parameters').hide();
            $('#more-info').hide();
            $('#stats').hide();
            $('#send').hide();
            $('#validation-data').hide();
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
            $('#stats').show();
        }
        else{
            $('#stats').hide();
            $('#more-info').hide();
            $('#send').hide();
            $('#validation-data').hide();
        }
    });
    $('input.js-switch').bind('change', function (e) {
        var array_check = [];
        $("#calc-type-stats input[type=checkbox]:checked").each(function(i){
            array_check.push( i.value );
            console.dir(i);
        });
        console.dir(array_check);
        if (array_check.length > 0) {
            $('#more-info').show();
        }else{
            $('#more-info').hide();
            $('#send').hide();
            $('#validation-data').hide();
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
        $('#stats').hide();
        $('#send').hide();
        $('#validation-data').hide();
    });
});
