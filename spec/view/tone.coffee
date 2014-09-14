define [
  'view/tone'
  'audio'
  'model/tone'
], (ToneView, Audio, ToneModel) ->


  describe 'Lute.View.Tone', ->


    beforeEach ->
      @tone = new ToneView('A4')


    it 'has a model with given pitch', ->
      expect(@tone.model instanceof ToneModel).toBe(true)
      expect(@tone.model.pitch).toBe(440)
      tone = new ToneView('A5')
      expect(tone.model.pitch).toBe(880)


    it 'renders a button with the pitch text', ->
      expect(@tone.$el.text()).toBe(@tone.pitch)


    it 'plays a sound when the button is clicked', ->
      audio = Audio.getInstance()
      spyOn(audio, 'play')
      @tone.$el.click()
      expect(audio.play).toHaveBeenCalledWith(@tone.model.pitch)
