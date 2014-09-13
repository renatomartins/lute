define [
  'audio'
  'stub/audio-context'
], (Audio) ->


  describe 'Audio', ->


    beforeEach ->
      Audio.instance = null
      @audio = Audio.getInstance()


    it 'generates a singleton', ->
      Audio.instance = null
      audio = Audio.getInstance()
      expect(audio instanceof Audio).toBe(true)
      expect(Audio.getInstance()).toBe(audio)
      expect(@audio).not.toBe(audio)


    it 'can be muted and unmuted', ->
      expect(@audio.isMuted).toBe(false)
      @audio.mute()
      expect(@audio.isMuted).toBe(true)
      @audio.unmute()
      expect(@audio.isMuted).toBe(false)
      # TODO: test if events were triggered


    it 'sets the volume', ->
      expect(@audio.volume).toBe(@audio.defaultVolume)
      @audio.setVolume(0.1)
      expect(@audio.volume).toBe(0.1)
      # TODO: test if event was triggered


    it 'reverts volume to default when unmuted', ->
      @audio.mute()
      @audio.unmute()
      expect(@audio.volume).toBe(@audio.defaultVolume)


    it 'can be unmuted to given volume', ->
      expect(@audio.volume).toBe(@audio.defaultVolume)
      @audio.mute()
      @audio.unmute(0.1)
      expect(@audio.volume).toBe(0.1)


    it 'plays a given frequency', ->
      expect(@audio.mergerNode.connectedBy.length).toBe(0)
      @audio.play(440)
      expect(@audio.mergerNode.connectedBy.length).toBe(1)
      @audio.play(440)
      expect(@audio.mergerNode.connectedBy.length).toBe(2)


    it 'converts indexes into frequencies', ->
      expect(Audio.getFrequency(12)).toBeCloseTo(880)
      expect(Audio.getFrequency(1)).toBeCloseTo(466.164)
      expect(Audio.getFrequency(0)).toBeCloseTo(440)
      expect(Audio.getFrequency(-1)).toBeCloseTo(415.305)
      expect(Audio.getFrequency(-12)).toBeCloseTo(220)
