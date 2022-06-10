jQuery.ajaxSetup({
    cache: false,
    beforeSend: function() {
        $('.loading-spinner').toggleClass('fade-in-out');
    },
    complete: function(){
        $('.loading-spinner').delay(400).toggleClass('fade-in-out');
    },
    success: function() {}
});
$(document).ready(function() {
    $('.live-menu').on( 'click', '.collapse-live', function () {
        var ibox = $(this).closest('div.ibox');
        var button = $(this).find('i');
        var content = ibox.find('div.ibox-content');
        content.slideToggle(200);
        button.toggleClass('fa-chevron-up').toggleClass('fa-chevron-down');
        ibox.toggleClass('').toggleClass('border-bottom');
        setTimeout(function () {
            ibox.resize();
            ibox.find('[id^=map-]').resize();
        }, 50);
    });
    $('.live-menu').on( 'click', '.close-live', function () {
        var content = $(this).closest('div.ibox');
        content.remove();
    });
    $('.live-menu').on( 'click', '.fullscreen-live', function () {
        console.log("fullscreen-live");
        var ibox = $(this).closest('div.ibox');
        var button = $(this).find('i');
        var chart = ibox.find('div.visualizer-chart');
        $('body').toggleClass('fullscreen-ibox-mode');
        button.toggleClass('fa-expand').toggleClass('fa-compress');
        chart.toggleClass('visualizer-chart-big');
        ibox.toggleClass('fullscreen');
        chart.highcharts().reflow();
    });
    $('.i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green',
    });
    var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch'));
 elems.forEach(function(html) {
    var switchery = new Switchery(html, { color: '#1AB394' });
 });
    var elem_2 = document.querySelector('.js-switch_2');
    var switchery_2 = new Switchery(elem_2, { color: '#ED5565' });
    var elem_3 = document.querySelector('.js-switch_3');
    var switchery_3 = new Switchery(elem_3, { color: '#1AB394' });
    toastr.options = {
        "closeButton": true,
        "debug": false,
        "progressBar": true,
        "positionClass": "toast-top-full-width",
        "onclick": null,
        "showDuration": "400",
        "hideDuration": "1000",
        "timeOut": "7000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }
    $.fn.editable.defaults.ajaxOptions = {type: "it"};
    main.kickStart();
});
$(window).on('mouseover', (function () {
    window.onbeforeunload = null;
}));
$(window).on('mouseout', (function () {
    window.onbeforeunload = ConfirmLeave;
}));
function ConfirmLeave() {
    main.ws_send_log();
    setTimeout(function(){
        return null;
    }, 50);
}
var prevKey="";
$(document).keydown(function (e) {
    if (!e) e = event;
    if ( e.altKey && e.keyCode==115){
        window.onbeforeunload = ConfirmLeave;
    }
});
var wsocket;
var main = {
    kickStart : function(){
        this.ws_connect();
    },
    ws_connect : function(){
        console.log('< Connecting wsocket ... >');
        try{
            wsocket = new WebSocket( ws_url );
            wsocket.onopen = function(evt){
                console.log('< Socket status: '+wsocket.readyState+' (open) >');
            }
            wsocket.onmessage = function(evt){
                console.dir(evt.data);
            }
            wsocket.onclose = function(evt){
                console.log('< Socket Status: '+wsocket.readyState+' (Closed) >');
            }
            wsocket.onerror = function(evt){
                console.log('< Socket Error Occured: '+evt.error+' >');
            }
        } catch(exception){
             console.log('< Error'+exception + ' >');
        }
    },
    ws_monitor_status_start : function() {
        setInterval(function(){ main.ws_send_log(); }, 10000);
    },
    ws_send_log : function () {
        console.log('ws_send_log');
        try{
            if ( wsocket != null && wsocket.readyState == WebSocket.OPEN ) {
                var data = {
                    app: 'lily',
                }
                if (wsocket.bufferedAmount === 0) {
                    wsocket.send( JSON.stringify(data) );
                    console.log('wsocket data sent:');
                }
            } else {
              console.log('< WebSocket not connected, message not sent >');
            }
        } catch(exception){
            console.log('< Error:' + exception + ' >');
        }
    },
};
