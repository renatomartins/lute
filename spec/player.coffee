define [
  'lute'
  'audio'
  'view/player'
], (Lute) ->


  describe 'Lute.View.Player', ->


    beforeEach ->
      @player = new Lute.View.Player()


    it 'plays a sound when a button is clicked', ->
      audio = Lute.Audio.getInstance()
      spyOn(audio, 'play')

      @player.$el.find('button:nth-child(2)').click()
      expect(audio.play).toHaveBeenCalledWith(220)
