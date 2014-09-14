define [
  'jquery'
  'lute'
  'template/player'
  'audio'
], ($, Lute, template) ->


  class Lute.View.Player


    # TODO: create a class for pitches
    pitches = [
      ['A']
      ['A#', 'Bb']
      ['B']
      ['C']
      ['C#', 'Db']
      ['D']
      ['D#', 'Eb']
      ['E']
      ['F']
      ['F#', 'Gb']
      ['G']
      ['G#', 'Ab']
    ]


    constructor: ->
      @audio = Lute.Audio.getInstance()
      @$el = $('<div>')

      @render()


    render: ->
      @$el.html(template())
      $('body').append(@$el)

      @configDom()


    configDom: ->
      @$el.on('click', 'button', (e) => @onButtonClick(e))


    onButtonClick: (e) ->
      frequencyIndex = e.target.dataset.index
      frequency = Lute.Audio.getFrequency(frequencyIndex)
      @audio.play(frequency)
