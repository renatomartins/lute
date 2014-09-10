define [
  'riotjs'
], (riot) ->


  class Audio


    AudioContext = (window.AudioContext or window.webkitAudioContext)
    unless AudioContext?
      throw new Error('Web Audio API is not supported in this browser')


    Audio.prototype = riot.observable(Audio.prototype)


    constructor: (args) ->
      args = if args? then args else {}
      @isMuted = if args.muted? then args.muted else false
      @defaultVolume = if args.volume? then args.volume else 0.5

      @configure()


    configure: ->
      @context = new AudioContext()
      # the merger node is there so that burst sounds don't stop each other
      @mergerNode = @context.createChannelMerger()
      @gainNode = @context.createGain()

      @mergerNode.connect(@gainNode)
      @gainNode.connect(@context.destination)

      @setGain(@defaultVolume)


    # Play a given frequency by creating a new oscillator.
    # TODO: provide oscillator type, frequency, gain, duration, fade duration)
    play: (frequency) ->
      oscillator = @context.createOscillator()
      fadeOutGain = @context.createGain()

      oscillator.type = 'square'
      oscillator.frequency.value = frequency
      fadeOutGain.gain.value = 1

      oscillator.connect(fadeOutGain)
      fadeOutGain.connect(@mergerNode)

      oscillator.start()
      fadeOutGain.gain.setTargetAtTime(0, @context.currentTime + 0.2, 0.75)
      # should the oscillator and gain nodes be destroyed?


    setGain: (volume) ->
      @gainNode.gain.value = parseFloat(volume, 10)
      @trigger('gain', volume)


    mute: ->
      @isMuted = true
      @setGain(0)
      @trigger('muted')


    unmute: (volume) ->
      volume = if volume? then volume else @defaultVolume
      @isMuted = false
      @setGain(volume)
      @trigger('unmuted', volume)


    # Get the frequency in Hz for given index (0 is 440Hz).
    # https://en.wikipedia.org/wiki/Piano_key_frequencies
    @getFrequency: (index) ->
      Math.pow(2, index / 12) * 440
