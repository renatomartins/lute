define [
  'lute'
], (Lute) ->


  # Represents a tone: duration, pitch, intensity and timbre.
  class Lute.Model.Tone


    # the 12 pitches of an octave (we don't care about the accidentals' names)
    pitches = ['C', '', 'D', '', 'E', 'F', '', 'G', '', 'A', '', 'B']


    pitchRegex = ///
      ([a-gA-G])  # letter name
      ([#b]*)     # accidental
      (\d*)       # octave
    ///


    defaults:
      duration: null
      pitch:    440
      volume:   1
      timbre:   'square'


    constructor: (args = {}) ->
      args = Lute.defaults(args, @defaults)
      @duration = args.duration
      @pitch = Tone.normalizePitch(args.pitch)
      @volume = args.volume
      @timbre = args.timbre


    @normalizePitch: (pitch) ->
      return pitch if typeof pitch is 'number'
      
      match = pitchRegex.exec(pitch)
      throw new Error('Malformed pitch ' + pitch) unless match?
      [name, accidentals, octave] = match[1..3]

      # if no octave is given start at 4
      octave = 4 unless octave.length
      accidentalType = 0

      # 1-based index of the pitch in the series (A0 = 1; A1 = 13; etc)
      # also, the index starts with the A, and C and A are 9 pitches apart
      pitchIndex = pitches.indexOf(name)+1 + (octave * pitches.length) - 9

      if accidentals.length
        # let us assume that, having more than one accidental, they are equal
        accidentalType = if accidentals[0] is '#' then 1 else -1

      # now we increase or decrease the pitch based on the accidental
      pitchIndex += accidentalType * accidentals.length

      @getFrequency(pitchIndex)


    # Get the frequency in Hz for given index.
    # A4 is 440Hz and the 49th in the series.
    # https://en.wikipedia.org/wiki/Piano_key_frequencies
    @getFrequency: (index) ->
      Math.pow(2, (index - 49) / 12) * 440
