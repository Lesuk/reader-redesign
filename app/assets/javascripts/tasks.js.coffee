$(document).on 'click', '.edit_task input[type=checkbox]', ->
  $(this).parents('form').submit()