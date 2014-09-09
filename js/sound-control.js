'use strict';

Lute.SoundControl = (function () {

  var SoundControl = function (audio) {
    this.audio = audio;
    
    this.volumeRange = document.getElementById('volume');
    this.muteButton = document.getElementById('mute');

    this.volumeRange.value = audio.defaultVolume;
    this.domListeners();
    this.audioListeners();
  };


  SoundControl.prototype.domListeners = function () {
    this.volumeRange.addEventListener('change', function () {
      this.onVolumeChange();
    }.bind(this));

    this.muteButton.addEventListener('click', function () {
      this.onMuteClick();
    }.bind(this));
  };


  SoundControl.prototype.onVolumeChange = function () {
    var volume = parseFloat(this.volumeRange.value, 10);
    if (volume === 0) {
      this.audio.mute();
    } else if (this.audio.isMuted) {
      this.audio.unmute(volume);
    } else {
      this.audio.setGain(volume);
    }
  };


  SoundControl.prototype.onMuteClick = function () {
    this.audio.isMuted ? this.audio.unmute() : this.audio.mute();
  };


  SoundControl.prototype.audioListeners = function () {
    this.audio.on('muted', function () {
      this.onAudioMuted();
    }.bind(this));

    this.audio.on('unmuted', function (volume) {
      this.onAudioUnmuted(volume);
    }.bind(this));
  };


  SoundControl.prototype.onAudioMuted = function () {
    this.muteButton.value = 'Unmute';
    this.volumeRange.value = 0;
  };


  SoundControl.prototype.onAudioUnmuted = function (volume) {
    this.muteButton.value = 'Mute';
    this.volumeRange.value = volume;
  };


  return SoundControl;

}());
