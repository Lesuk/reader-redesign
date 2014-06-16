jQuery ->
  $('.yt_preview').click -> makeVideoPlayer $(this).data('uid')
  $('#ModalVideo').click -> makeVideoPlayer "0"

  # Initially the player is not loaded
  window.ytPlayerLoaded = false

  $(window).bindWithDelay('resize', ->
    player = $('#ytPlayer')
    player.height(483) if player.size() > 0
    return
  , 500)

  makeVideoPlayer = (video) ->
    if !window.ytPlayerLoaded && video != "0"
      player_wrapper = $('#player-wrapper')
      player_wrapper.append('<div id="ytPlayer"><p>Loading player...</p></div>')

      window.ytplayer = new YT.Player('ytPlayer', {
        width: '100%'
        height: 483
        videoId: video
        playerVars: {
          wmode: 'opaque'
          autoplay: 1
          modestbranding: 1
        }
        events: {
          'onReady': -> window.ytPlayerLoaded = true
          #'onError': (errorCode) -> alert("We are sorry, but the following error occured: " + errorCode)
        }
      })
    else
      window.ytplayer.loadVideoById(video)
      window.ytplayer.pauseVideo()
    return

  return