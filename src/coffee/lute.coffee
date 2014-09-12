Lute = null

define [
  'audio'
  'sound-control'
  'string-player'
], (Audio, SoundControl, StringPlayer) ->


  class Lute


    @run: ->
      audio = new Audio()
      new SoundControl(audio)
      new StringPlayer(audio)


document.addEventListener 'DOMContentLoaded', ->
  Lute.run()
