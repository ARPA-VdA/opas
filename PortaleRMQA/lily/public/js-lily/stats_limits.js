$(document).ready(function() {
    $(".chosen-select").chosen({width: "99%!important"});
    $('.show_params').hide();
    $( "#show-stats" ).on( "click", function() {
        values = $("#select-params").chosen().val();
        console.dir(values);
        console.log(values);
        if ( values !== null){
            $('.show_params').show();
        }
        else{
            $('.show_params').hide();
        }
    });
});
