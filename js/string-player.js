'use strict';

Lute.StringPlayer = (function () {

  //TODO: create a class for pitches
  var pitches = [
    ['A'],
    ['A#', 'Bb'],
    ['B'],
    ['C'],
    ['C#', 'Db'],
    ['D'],
    ['D#', 'Eb'],
    ['E'],
    ['F'],
    ['F#', 'Gb'],
    ['G'],
    ['G#', 'Ab']
  ];


  var StringPlayer = function (audio) {
    this.audio = audio;

    this.stringsDiv = document.getElementById('strings');

    this.domListeners();
  };


  StringPlayer.prototype.domListeners = function () {
    this.stringsDiv.addEventListener('click', function (e) {
      var frequencyIndex = e.target.dataset.index;
      var frequency = Lute.Audio.getFrequency(frequencyIndex);
      this.audio.play(frequency);
    }.bind(this));
  };


  return StringPlayer;

}());
