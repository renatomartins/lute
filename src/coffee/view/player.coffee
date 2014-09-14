define [
  'jquery'
  'lute'
  'view/tone'
], ($, Lute) ->


  class Lute.View.Player


    pitches = ['E2', 'A2', 'D3', 'G3', 'B3', 'E4']


    container: '<div>'


    constructor: ->
      @$el = $(@container)
      @render()


    render: ->
      for pitch in pitches
        view = new Lute.View.Tone(pitch)
        @$el.append(view.$el)
      
      $('body').append(@$el)
