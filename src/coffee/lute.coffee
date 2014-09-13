Lute = null

define [
  'view/sound-control'
  'view/string-player'
], (SoundControl, StringPlayer) ->


  class Lute


    @run: ->
      new SoundControl()
      new StringPlayer()


document.addEventListener 'DOMContentLoaded', ->
  Lute.run()
