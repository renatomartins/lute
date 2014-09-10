define [
  'audio'
  'sound-control'
  'string-player'
], (Audio, SoundControl, StringPlayer) ->


  class window.Lute


    @run: ->
      audio = new Audio()
      new SoundControl(audio)
      new StringPlayer(audio)
