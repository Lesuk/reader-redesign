//= require jquery
//= require jquery_ujs
//= require textarea-сounter
//= require bootstrap
//= require turbolinks
//= require bootstrap-checkbox
//= require breakpoints
//= require jquery-ui-1.10.1.custom.min
//= require jquery.unveil.min
//= require pace.min
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
        } else {
            if( log ) alert(log);
        }
        
    });

});