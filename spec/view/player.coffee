define [
  'audio'
  'view/player'
], (Audio, Player) ->


  describe 'Lute.View.Player', ->


    beforeEach ->
      @player = new Player()


    it 'renders 6 tones', ->
      expect(@player.$el.children().length).toBe(6)
