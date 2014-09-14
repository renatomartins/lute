define [
  'lute'
  'riot'
], (Lute, riot) ->


  class Lute.Audio


    Audio.prototype = riot.observable(Audio.prototype)


    @instance: null


    @getInstance: ->
      unless @instance?
        @instance = new Audio()
      @instance


    constructor: ->
      @isMuted = false
      @volume = @defaultVolume = 0.5

      AudioContext = (window.AudioContext or window.webkitAudioContext)
      @context = new AudioContext()

      # the merger node is there so that burst sounds don't stop each other
      @mergerNode = @context.createChannelMerger()
      @gainNode = @context.createGain()

      @mergerNode.connect(@gainNode)
      @gainNode.connect(@context.destination)

      @setVolume(@defaultVolume)


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


    setVolume: (volume) ->
      @volume = parseFloat(volume, 10)
      @gainNode.gain.value = @volume
      @trigger('volume', @volume)


    mute: ->
      @isMuted = true
      @setVolume(0)
      @trigger('muted')


    unmute: (volume) ->
      volume = if volume? then volume else @defaultVolume
      @isMuted = false
      @setVolume(volume)
      @trigger('unmuted', volume)
