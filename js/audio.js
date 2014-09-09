'use strict';

Lute.Audio = (function (AudioContext, riot) {

  if (!AudioContext) {
    throw new Error('Web Audio API is not supported in this browser');
  }


  var Audio = function (args) {
    args = Lute.default(args, {});
    this.isMuted = Lute.default(args.muted, false);
    this.defaultVolume = Lute.default(args.volume, 0.5);

    this.context = new AudioContext();
    // the merger node is there so that burst sounds don't stop each other
    this.mergerNode = this.context.createChannelMerger();
    this.gainNode = this.context.createGain();

    this.configure();
  };


  Audio.prototype = riot.observable(Audio.prototype);


  Audio.prototype.configure = function () {
    this.mergerNode.connect(this.gainNode);
    this.gainNode.connect(this.context.destination);

    this.setGain(this.defaultVolume);
  };


  Audio.prototype.play = function (frequency) {
    var oscillator = this.context.createOscillator();
    var fadeOutGain = this.context.createGain();

    oscillator.type = 'square';
    oscillator.frequency.value = frequency;
    fadeOutGain.gain.value = 1.0;

    oscillator.connect(fadeOutGain);
    fadeOutGain.connect(this.mergerNode);

    oscillator.start();
    fadeOutGain.gain.setTargetAtTime(0, this.context.currentTime + 0.2, 0.75);
    // should the oscillator and gain nodes be destroyed?
  };


  Audio.prototype.setGain = function (volume) {
    this.gainNode.gain.value = parseFloat(volume, 10);
    this.trigger('gain', volume);
  };


  Audio.prototype.mute = function () {
    this.isMuted = true;
    this.setGain(0);
    this.trigger('muted');
  };


  Audio.prototype.unmute = function (volume) {
    volume = Lute.default(volume, this.defaultVolume);
    this.isMuted = false;
    this.setGain(volume);
    this.trigger('unmuted', volume);
  };


  // get the frequency in Hz for given index (0 is 440Hz)
  // https://en.wikipedia.org/wiki/Piano_key_frequencies
  Audio.getFrequency = function (index) {
    return Math.pow(2, index / 12) * 440;
  };


  return Audio;
}((window.AudioContext || window.webkitAudioContext), riot));
