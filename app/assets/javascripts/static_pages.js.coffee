###
jQuery ->
  $('#new_micropost_home').fileupload
    dataType: "script"
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload-home", file))
        $('#new_micropost_home').append(data.context)
        $('.btn-primary').click (e) ->
          data.submit()
      else
        alert("#{file.name} is not a gif, jpeg, or png image file!")
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')

jQuery ->
  $('#new_micropost_m').fileupload
    dataType: "script"
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload-m", file))
        $('#new_micropost_m').append(data.context)
        $('.btn-primary').click (e) ->
          data.submit()
      else
        alert("#{file.name} is not a gif, jpeg, or png image file!")
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar-m').css('width', progress + '%')
###