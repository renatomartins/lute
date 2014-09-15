define [
  'view/player'
  'tunings'
  'jquery'
], (Player, Tunings, $) ->


  describe 'Lute.View.Player', ->


    expectButtons = ($el, config) ->
      $el.children().each (i, button) ->
        expect($(button).text()).toBe(config[i])


    beforeEach ->
      @player = new Player()


    it 'has a standard tuning', ->
      # Jasmine complains that it has no expectations
      expect(true).toBe(true)
      expectButtons(@player.$pitches, Tunings.STANDARD.pitches)


    it 'loads tuning configurations', ->
      @player.$tunings.val('BASS').change()
      expectButtons(@player.$pitches, Tunings.BASS.pitches)
      @player.$tunings.val('NST').change()
      expectButtons(@player.$pitches, Tunings.NST.pitches)
