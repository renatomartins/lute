define [
  'lute'
  'audio'
  'view/string-player'
], (Lute) ->


  describe 'Lute.View.StringPlayer', ->


    beforeEach ->
      @player = new Lute.View.StringPlayer()


    it 'plays a sound when a button is clicked', ->
      audio = Lute.Audio.getInstance()
      spyOn(audio, 'play')

      @player.$el.find('button:nth-child(2)').click()
      expect(audio.play).toHaveBeenCalledWith(220)
