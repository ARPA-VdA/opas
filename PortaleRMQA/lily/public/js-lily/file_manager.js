$(document).ready(function() {
 $('.file-box').each(function() {
        animationHover(this, 'pulse');
    });
    var previewNode = document.querySelector("#template");
    previewNode.id = "";
    var previewTemplate = previewNode.parentNode.innerHTML;
    previewNode.parentNode.removeChild(previewNode);
    var myDropzone = new Dropzone(document.body, {
      url: "/target-url",
      thumbnailWidth: 80,
      thumbnailHeight: 80,
      parallelUploads: 20,
      previewTemplate: previewTemplate,
      autoQueue: false,
      previewsContainer: "#previews",
      clickable: ".fileinput-button"
    });
    myDropzone.on("addedfile", function(file) {
      file.previewElement.querySelector(".start").onclick = function() { myDropzone.enqueueFile(file); };
    });
    myDropzone.on("totaluploadprogress", function(progress) {
      document.querySelector("#total-progress .progress-bar").style.width = progress + "%";
    });
    myDropzone.on("sending", function(file) {
      document.querySelector("#total-progress").style.opacity = "1";
      file.previewElement.querySelector(".start").setAttribute("disabled", "disabled");
    });
    myDropzone.on("queuecomplete", function(progress) {
      document.querySelector("#total-progress").style.opacity = "0";
    });
    document.querySelector("#actions .start").onclick = function() {
      myDropzone.enqueueFiles(myDropzone.getFilesWithStatus(Dropzone.ADDED));
    };
    document.querySelector("#actions .cancel").onclick = function() {
      myDropzone.removeAllFiles(true);
    };
});
