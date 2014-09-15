define [
  'jquery'
  'lute'
  'view/sound-control'
  'view/player'
], ($, Lute) ->


  $ ->
    soundControl = new Lute.View.SoundControl()
    player = new Lute.View.Player()
    $('body').append(soundControl.$el, player.$el)
