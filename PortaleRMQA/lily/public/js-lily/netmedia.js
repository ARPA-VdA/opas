function parseMediaBlocks( data ){
    console.log('parseMediaBlocks');
    console.dir(data);
    var block_old = 0;
    $.each(data.tree, function(index, value) {
        block = value.block;
        if (block != block_old){
            var htmlPanel = '<div class="col-lg-4" id="p'+block+'">';
                htmlPanel += '    <div class="row ibox-smaller">';
                htmlPanel += '        <div class="col-lg-12">';
                htmlPanel += '            <div class="ibox float-e-margins">';
                htmlPanel += '                <div class="ibox-title">';
                htmlPanel += '                    <h5 class="text-info">'+value.path1+'</h5>';
                htmlPanel += '                    <div class="ibox-tools">';
                htmlPanel += '                        <a class="collapse-link collapse-live"><i class="fa fa-chevron-up"></i></a>';
                htmlPanel += '                        <a class="close-link close-live"><i class="fa fa-times"></i></a>';
                htmlPanel += '                    </div>';
                htmlPanel += '                </div>';
                htmlPanel += '                <div class="ibox-content">';
                htmlPanel += '                    <div class="row">';
                htmlPanel += '                        <h3 id="p'+block+'-pdf-title">Pdf</h3>';
                htmlPanel += '                        <ul class="stat-media-pdf" id="p'+block+'-pdf"></ul>';
                htmlPanel += '                        <h3 id="p'+block+'-img-title">Immagini</h3>';
                htmlPanel += '                        <div class="stat-media-img clearfix" id="p'+block+'-img"></div>';
                htmlPanel += '                        <div id="p'+block+'-tab"></div>';
                htmlPanel += '                    </div>';
                htmlPanel += '                </div>';
                htmlPanel += '            </div>';
                htmlPanel += '        </div>';
                htmlPanel += '    </div>';
                htmlPanel += '</div>';
            $('#add_boxes').append(htmlPanel);
            if(block % 3 == 0){
                $('#add_boxes').append('<div class="clear_both"></div>');
            }
            block_old = block;
        }
    });
}
function parseMediaTabs( data ){
    console.log('parseMediaTabs');
    var htmlTabFlag = 0;
    var htmlTabStart;
    var htmlTabMiddle;
    var htmlTabClose;
    htmlTabStart = '<div class="tabs-container">';
    htmlTabStart += '    <ul class="nav nav-tabs">';
    htmlTabMiddle = '    </ul>';
    htmlTabMiddle += '    <div class="tab-content">';
    htmlTabClose = '    </div>';
    htmlTabClose += '</div>';
    var panelTabId;
    var block_old = 1;
    var tab_old = 0;
    $.each(data.tree, function(index, value) {
        block = value.block;
        console.log('analysing block '+block+' tab '+value.tab);
        if (block != block_old){
            if ( htmlTabFlag == 1 ) {
                var prevBlock = block-1;
                console.log('add tab-div to block '+prevBlock);
                panelTabId = 'p'+prevBlock+'-tab';
                var htmlTab = htmlTabStart + htmlTabMiddle + htmlTabClose;
                $('#'+panelTabId).append(htmlTab);
            }
            htmlTabFlag = 0;
            htmlTabStart = '<div class="tabs-container">';
            htmlTabStart += '    <ul class="nav nav-tabs">';
            htmlTabMiddle = '    </ul>';
            htmlTabMiddle += '    <div class="tab-content">';
            htmlTabClose = '    </div>';
            htmlTabClose += '</div>';
            block_old = block;
        }
        if ( value.tab != 0 && tab_old != value.tab) {
            console.log('add tab-li '+value.tab+' -> block '+value.block);
            htmlTabFlag = 1;
            var classActive = '';
            if (value.tab ==1)
                classActive = 'active';
            htmlTabStart += '        <li class="'+classActive+'"><a data-toggle="tab" href="#tab-b'+value.block+'-'+value.tab+'">'+value.path2+'</a></li>';
            htmlTabMiddle += '        <div id="tab-b'+value.block+'-'+value.tab+'" class="tab-pane '+classActive+'">';
            htmlTabMiddle += '            <div class="panel-body" id="tab-pane-b'+value.block+'-'+value.tab+'">';
            htmlTabMiddle += '                 <h3 id="p'+value.block+'-t'+value.tab+'-pdf-title">Pdf</h3>';
            htmlTabMiddle += '                 <ul class="stat-media-pdf" id="p'+value.block+'-t'+value.tab+'-pdf"></ul>';
            htmlTabMiddle += '                 <h3 id="p'+value.block+'-t'+value.tab+'-img-title">Immagini</h3>';
            htmlTabMiddle += '                 <div class="stat-media-img clearfix" id="p'+value.block+'-t'+value.tab+'-img"></div>';
            htmlTabMiddle += '            </div>';
            htmlTabMiddle += '        </div>';
        }
        tab_old = value.tab;
    });
    if ( htmlTabFlag == 1 ) {
        console.log('add tab-div to block '+block);
        panelTabId = 'p'+block+'-tab';
        panelFileId = 'p'+block+'-file';
        var htmlTab = htmlTabStart + htmlTabMiddle + htmlTabClose;
        $('#'+panelTabId).append(htmlTab);
    }
}
function parseMediaFiles(data) {
    console.log('parseMediaFiles');
    $.each(data.tree, function(index, value) {
        var block = value.block;
        var tab = value.tab;
        var divFileId;
        var patt = new RegExp("png|jpg|jpeg|PNG|JPG|JPEG");
        if(patt.test(value.suff)){
            var img = '<a href="'+value.url+'" title="'+value.file+''+value.suff+'" class="single-image-gallery" data-gallery="stat-'+block+'">';
                img += '    <img src="'+value.url+'">';
                img += '</a>';
            if (tab == 0) {
                divFileId = 'p'+block+'-img';
            } else {
                divFileId = 'p'+block+'-t'+tab+'-img';
            }
            $('#'+divFileId).append(img);
        }else{
            var li = '<li>';
                li += '    <a href="'+value.url+'" target="_blank"><i class="fa fa-file-text text-danger"></i> '+value.file+''+value.suff+'</a>&nbsp;&nbsp;<small>[ '+value.size+' ]</small>';
                li += '</li>';
            if (tab == 0) {
                divFileId = 'p'+block+'-pdf';
            } else {
                divFileId = 'p'+block+'-t'+tab+'-pdf';
            }
            $('#'+divFileId).append(li);
        }
    });
}
function removeEmptyDivs(data) {
    console.log('removeEmptyDivs');
    var block;
    var tab;
    var divFileId;
    var block_old = 1;
    var filePdfFound = 0;
    var fileImgFound = 0;
    $.each(data.tree, function(index, value) {
        block = value.block;
        tab = value.tab;
        if (block != block_old){
            if (filePdfFound == 0){
                var lastBlock = block -1;
                divFileId = 'p'+lastBlock+'-pdf';
                $('ul#'+divFileId).prev().remove();
                $('ul#'+divFileId).remove();
            }
            if (fileImgFound == 0){
                var lastBlock = block -1;
                divFileId = 'p'+lastBlock+'-img';
                $('div#'+divFileId).prev().remove();
                $('div#'+divFileId).remove();
            }
            filePdfFound = 0;
            fileImgFound = 0;
            block_old = block;
        }
        if (tab == 0) {
            divFileId = 'p'+block+'-pdf';
        } else {
            divFileId = 'p'+block+'-t'+tab+'-pdf';
        }
        if ( $('ul#'+divFileId+' li').length == 0 ){
            $('ul#'+divFileId).prev().remove();
            $('ul#'+divFileId).remove();
        } else {
            if (tab == 0) { filePdfFound = 1; }
        }
        if (tab == 0) {
            divFileId = 'p'+block+'-img';
        } else {
            divFileId = 'p'+block+'-t'+tab+'-img';
        }
        if ( $('div#'+divFileId).children().length == 0 ){
            $('div#'+divFileId).prev().remove();
            $('div#'+divFileId).remove();
        } else {
            if (tab == 0) { fileImgFound = 1; }
        }
    });
    if (filePdfFound == 0){
        divFileId = 'p'+block+'-pdf';
        $('ul#'+divFileId).prev().remove();
        $('ul#'+divFileId).remove();
    }
    if (fileImgFound == 0){
        divFileId = 'p'+block+'-img';
        $('div#'+divFileId).prev().remove();
        $('div#'+divFileId).remove();
    }
}
$(document).ready(function() {
    $( "#add_boxes" ).on( "click", ".single-image-gallery", function(event) {
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
