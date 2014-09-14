define [
  'audio'
], (Audio) ->


  describe 'Lute.Audio', ->


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
      spyOn(@audio, 'trigger')
      spyOn(@audio, 'setVolume')

      expect(@audio.isMuted).toBe(false)
      @audio.mute()
      expect(@audio.isMuted).toBe(true)
      expect(@audio.trigger).toHaveBeenCalledWith('muted')
      @audio.unmute()
      expect(@audio.isMuted).toBe(false)
      volume = @audio.defaultVolume
      expect(@audio.trigger).toHaveBeenCalledWith('unmuted', volume)


    it 'sets the volume', ->
      spyOn(@audio, 'trigger')

      expect(@audio.volume).toBe(@audio.defaultVolume)
      @audio.setVolume(0.1)
      expect(@audio.volume).toBe(0.1)
      expect(@audio.trigger).toHaveBeenCalledWith('volume', 0.1)


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
