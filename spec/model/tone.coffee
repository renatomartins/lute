define [
  'model/tone'
], (Tone) ->


  describe 'Lute.Model.Tone', ->


    beforeEach ->
      @tone = new Tone()


    it 'has a duration', ->
      expect(@tone.duration).toBe(@tone.defaults.duration)
      tone = new Tone({duration: 2})
      expect(tone.duration).toBe(2)


    it 'has a pitch', ->
      expect(@tone.pitch).toBe(@tone.defaults.pitch)
      tone = new Tone({pitch: 'A3'})
      expect(tone.pitch).toBe(220)


    it 'has a volume', ->
      expect(@tone.volume).toBe(@tone.defaults.volume)
      tone = new Tone({volume: 0.1})
      expect(tone.volume).toBe(0.1)


    # TODO: more complex timbres are not strings, but configurations to pass
    #       into the audio context
    it 'has a timbre', ->
      expect(@tone.timbre).toBe(@tone.defaults.timbre)
      tone = new Tone({timbre: 'sine'})
      expect(tone.timbre).toBe('sine')


    it 'normalizes pitches', ->
      expect(Tone.normalizePitch(440)).toBe(440)
      expect(Tone.normalizePitch(466.164)).toBe(466.164)
      expect(Tone.normalizePitch('G5')).toBeCloseTo(783.99)
      expect(Tone.normalizePitch('F##5')).toBeCloseTo(783.99)
      expect(Tone.normalizePitch('A')).toBe(440)
      expect(Tone.normalizePitch('A#')).toBeCloseTo(466.164)
      expect(->Tone.normalizePitch('X')).toThrow()


    it 'converts indexes into frequencies', ->
      expect(Tone.getFrequency(61)).toBeCloseTo(880)
      expect(Tone.getFrequency(50)).toBeCloseTo(466.164)
      expect(Tone.getFrequency(49)).toBeCloseTo(440)
      expect(Tone.getFrequency(48)).toBeCloseTo(415.305)
      expect(Tone.getFrequency(37)).toBeCloseTo(220)
