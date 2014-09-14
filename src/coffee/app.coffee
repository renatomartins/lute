define [
  'jquery'
  'lute'
  'view/sound-control'
  'view/player'
], ($, Lute) ->


  $ ->
    new Lute.View.SoundControl()
    new Lute.View.Player()
