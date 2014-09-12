define [
  'audio'
], (Audio) ->


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


    constructor: (audio) ->
      @audio = audio
      @stringsDiv = document.getElementById('strings')
      @domListeners()


    domListeners: ->
      @stringsDiv.addEventListener('click', @onStringClick)


    onStringClick: (e) =>
      return unless e.target.tagName is 'BUTTON'
      frequencyIndex = e.target.dataset.index
      frequency = Audio.getFrequency(frequencyIndex)
      @audio.play(frequency)
