define [], ->


  class AudioNode

    constructor: ->
      @connectedBy = []

    connect: (otherNode) ->
      otherNode.connectedBy.push(this)


  class ChannelMergerNode extends AudioNode


  class GainNode extends AudioNode

    gain:
      value: 0
      setTargetAtTime: ->


  class OscillatorNode extends AudioNode

    type: 'square'

    frequency:
      value: 440

    start: ->


  # PhantomJS doesn't support the Web Audio API
  class window.AudioContext

    currentTime: 0

    constructor: ->
      @destination = new AudioNode()

    createChannelMerger: ->
      new ChannelMergerNode()

    createGain: ->
      new GainNode()

    createOscillator: ->
      new OscillatorNode()
