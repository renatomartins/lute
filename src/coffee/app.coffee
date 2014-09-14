define [
  'jquery'
  'lute'
  'view/sound-control'
  'view/string-player'
], ($, Lute) ->


  $ ->
    new Lute.View.SoundControl()
    new Lute.View.StringPlayer()
