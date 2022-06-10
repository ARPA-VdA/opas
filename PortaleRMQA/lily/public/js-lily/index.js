$(document).ready(function() {
    $('.tooltip-table').tooltip({
        selector: "[data-toggle=tooltip]",
        container: "body"
    })
    $('.lightBoxGallery .single-image-gallery').on('click', function(event) {
        event = event || window.event;
        var target = event.target || event.srcElement,
            link = target.src ? target.parentNode : target,
            options = {
                index: link,
                event: event,
                hidePageScrollbars: false
            },
            links = $('a.single-image-gallery');
        blueimp.Gallery(links, options);
    });
});
