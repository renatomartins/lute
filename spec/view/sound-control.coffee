define [
  'jquery'
  'audio'
  'view/sound-control'
], ($, Audio, SoundControl) ->


  describe 'Lute.View.SoundControl', ->


    beforeEach ->
      Audio.instance = null
      @audio = Audio.getInstance()
      @control = new SoundControl()


    it 'has DOM elements', ->
      expect(@control.$volume instanceof $).toBe(true)
      expect(@control.$mute instanceof $).toBe(true)


    # PhantomJS doesn't seem to support <input type=range> entirely
    xit 'sets the audio volume on the input', ->
      expect(+@control.$volume.val()).toBe(@audio.volume)


    # PhantomJS doesn't seem to support <input type=range> entirely
    xit 'changes the volume', ->
      spyOn(@control, 'onVolumeChange').and.callThrough()

      expect(@audio.volume).toBe(@audio.defaultVolume)
      expect(@control.onVolumeChange).not.toHaveBeenCalled()
      @control.$volume.val(0.1)
      @control.$volume.change()
      expect(@control.onVolumeChange).toHaveBeenCalled()
      expect(@audio.volume).toBe(0.1)


    # PhantomJS doesn't seem to support <input type=range> entirely
    xit 'updates the volume when the sound is muted/unmuted', ->
      expect(+@control.$volume.val()).toBe(@audio.defaultVolume)
      @audio.trigger('muted')
      expect(+@control.$volume.val()).toBe(0)
      @audio.trigger('unmuted', 0.1)
      expect(+@control.$volume.val()).toBe(0.1)


    it 'toggles muting the sound', ->
      spyOn(@control, 'onMuteClick').and.callThrough()

      expect(@audio.isMuted).toBe(false)
      @control.$mute.click()
      expect(@control.onMuteClick).toHaveBeenCalled()
      expect(@audio.isMuted).toBe(true)
      @control.$mute.click()
      expect(@audio.isMuted).toBe(false)


    it 'updates the mute button when the sound is muted/unmuted', ->
      expect(@control.$mute.val()).toBe('Mute')
      @audio.trigger('muted')
      expect(@control.$mute.val()).toBe('Unmute')
      @audio.trigger('unmuted')
      expect(@control.$mute.val()).toBe('Mute')
