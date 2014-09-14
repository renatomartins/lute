define [
  'jquery'
  'lute'
  'audio'
  'model/tone'
], ($, Lute) ->


  class Lute.View.Tone


    container: '<button>'


    constructor: (@pitch) ->
      @audio = Lute.Audio.getInstance()
      @model = new Lute.Model.Tone({pitch: @pitch})
      @$el = $(@container)

      @render()


    render: ->
      @$el.text(@pitch)
      @configDom()


    configDom: ->
      @$el.off().on('click', => @onButtonClick())


    onButtonClick: ->
      @audio.play(@model.pitch)
