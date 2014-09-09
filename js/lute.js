'use strict';

var Lute = (function () {

  var Lute = function () {
    var audio = new Lute.Audio();

    new Lute.SoundControl(audio);
    new Lute.StringPlayer(audio);
  };


  Lute.default = function (value, defaultValue) {
    return typeof value !== 'undefined' ? value : defaultValue;
  };


  return Lute;

}());


var lute;
document.addEventListener('DOMContentLoaded', function () {
  lute = new Lute();
});
