define [
  'jquery'
  'audio'
  'template/sound-control'
], ($, Audio, template) ->


  class SoundControl


    constructor: ->
      @audio = Audio.getInstance()
      @$el = $('<div>')

      @audio.on('muted', @onAudioMuted)
      @audio.on('unmuted', @onAudioUnmuted)

      @render()


    render: ->
      @$el.html(template())
      $('body').append(@$el)

      @$volume = @$el.find('#volume')
      @$mute = @$el.find('#mute')

      @configDom()


    configDom: ->
      @$volume.val(@audio.defaultVolume)
      @$volume.on('change', @onVolumeChange)
      @$mute.on('click', @onMuteClick)


    onVolumeChange: =>
      volume = parseFloat(@$volume.val(), 10)
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
      @$mute.val('Unmute')
      @$volume.val(0)


    onAudioUnmuted: (volume) =>
      @$mute.val('Mute')
      @$volume.val(volume)
