//= require jquery
//= require jquery_ujs
// require jquery-fileupload/basic  // I don't use it now
// require jquery-fileupload/vendor/tmpl  // I don't use it now
//= require textarea-сounter
//= require bootstrap
//= require turbolinks
//= require bootstrap-checkbox
//= require select2.min
//= require breakpoints
//= require jquery-ui-1.10.1.custom.min
//= require jquery.unveil.min
//= require pace.min
//= require bootstrap-datepicker
//= require zebra_datepicker
//= require touchTouch.jquery
//= require core
//= require ckeditor/override
//= require ckeditor/init
//= require ckeditor/ckeditor
//= require jquery.bind_with_delay
//= require yt_player
//= require_tree .


$(document).on('change', '.btn-file :file', function() {
  var input = $(this),
      numFiles = input.get(0).files ? input.get(0).files.length : 1,
      label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
  input.trigger('fileselect', [numFiles, label]);
});

$(document).ready(function(){
	var counter = {
		'maxCharacterSize': 140,
		'originalStyle': 'originalDisplayInfo',
		'warningStyle': 'warningDisplayInfo',
		'warningNumber': 30,
		'displayFormat': '#left'
	};
	$('#word-counter').textareaCount(counter);
	$('#word-counter-2').textareaCount(counter);

	$('.btn-file :file').on('fileselect', function(event, numFiles, label) {

        var input = $(this).parents('.input-group').find(':text'),
            log = numFiles > 1 ? numFiles + ' files selected' : label;
        
        if( input.length ) {
            input.val(log);
            $("#new_micropost .b-post").removeClass("b-post");
        } else {
            if( log ) alert(log);
        }
        
    });

  $("#message_recepient_id").select2({
    placeholder: "Choose a recipient",
  });

  $('#task_due_date').Zebra_DatePicker({
    direction: true
  });

  $('.task-note span').popover({
    placement : 'bottom'
  });

  $('.entry-thumb a').touchTouch();

  $('#new_micropost .b-post').on('click', function () {  
    $('#ModalWrite').modal('hide');
  });

  $('.task-form .collapse, .task-form .expand').on('click', function () {
    var el = jQuery(this).parents(".task-form").children(".task-form-body");
    if (jQuery(this).hasClass("collapse")) {
      jQuery(this).removeClass("collapse").addClass("expand");
      el.slideUp(200);
    } else {
      jQuery(this).removeClass("expand").addClass("collapse");
      el.slideDown(200);
    }
  });


});