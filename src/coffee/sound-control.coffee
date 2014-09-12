define [], ->


  class SoundControl


    constructor: (audio) ->
      @audio = audio
      
      @volumeRange = document.getElementById('volume')
      @muteButton = document.getElementById('mute')

      @volumeRange.value = audio.defaultVolume
      @domListeners()
      @audioListeners()


    domListeners: ->
      @volumeRange.addEventListener('change', @onVolumeChange)
      @muteButton.addEventListener('click', @onMuteClick)


    audioListeners: ->
      @audio.on('muted', @onAudioMuted)
      @audio.on('unmuted', @onAudioUnmuted)


    onVolumeChange: =>
      volume = parseFloat(@volumeRange.value, 10)
      if volume is 0
        @audio.mute()
      else if @audio.isMuted
        @audio.unmute(volume)
      else
        @audio.setVolume(volume)


    onMuteClick: =>
      if @audio.isMuted
        @audio.unmute()
      else
        @audio.mute()


    onAudioMuted: =>
      @muteButton.value = 'Unmute'
      @volumeRange.value = 0


    onAudioUnmuted: (volume) =>
      @muteButton.value = 'Mute'
      @volumeRange.value = volume
