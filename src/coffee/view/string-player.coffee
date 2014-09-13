define [
  'jquery'
  'audio'
  'template/string-player'
], ($, Audio, template) ->


  class StringPlayer


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
      @audio = Audio.getInstance()
      @$el = $('<div>')

      @render()


    render: ->
      @$el.html(template())
      $('body').append(@$el)

      @configDom()


    configDom: ->
      @$el.on('click', 'button', @onButtonClick)


    onButtonClick: (e) =>
      frequencyIndex = e.target.dataset.index
      frequency = Audio.getFrequency(frequencyIndex)
      @audio.play(frequency)
