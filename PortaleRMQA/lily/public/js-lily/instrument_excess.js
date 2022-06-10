$(document).ready(function() {
    $('.excess-text').hide();
    $('.excess-ins').hide();
    $( "#show-it" ).on( "click", function() {
        $('.excess-text').show();
        $('.excess-ins').show();
    });
});
