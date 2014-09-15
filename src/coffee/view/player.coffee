define [
  'jquery'
  'lute'
  'tunings'
  'template/player'
  'view/tone'
], ($, Lute, Tunings, template) ->


  class Lute.View.Player


    container: '<div>'


    constructor: (pitches) ->
      @$el = $(@container)
      @pitches = pitches or Tunings.STANDARD.pitches
      @render()


    # TODO: on re-render destroy previous inner views
    render: ->
      data = {tunings: Tunings}
      @$el.html(template(data))

      @$tunings = @$el.find('.js-tunings')
      @$pitches = @$el.find('.js-pitches')

      @renderTones()
      @configDom()


    renderTones: ->
      @$pitches.empty()
      for pitch in @pitches
        view = new Lute.View.Tone(pitch)
        @$pitches.append(view.$el)


    configDom: ->
      @$tunings.off().on('change', (e) => @onTuningsChange(e))


    onTuningsChange: (e) ->
      tuning = @$tunings.find('option:selected').val()
      @pitches = Tunings[tuning]?.pitches
      @renderTones()
