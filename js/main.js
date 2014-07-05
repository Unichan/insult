// Generated by CoffeeScript 1.7.1
(function() {
  var CUSTOM_CHANCE, PRESET_CHANCE, genPhrase, getCombo, getCustom, randChoice, setNewPhrase, setupWords, template;

  template = ['intro', 'you', 'adjective', 'compound_adjective', 'expletive', 'noun'];

  PRESET_CHANCE = 0.04;

  CUSTOM_CHANCE = 0.12;

  Array.prototype.compact = function() {
    var elem, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = this.length; _i < _len; _i++) {
      elem = this[_i];
      if (elem != null) {
        _results.push(elem);
      }
    }
    return _results;
  };

  randChoice = function(array) {
    return array[Math.floor(Math.random() * array.length)];
  };

  setupWords = function() {
    var k, v, w, _ref;
    _ref = this.words;
    for (k in _ref) {
      v = _ref[k];
      this.words[k] = v.replace(/#/g, '\n').replace(/(.+?)\[(\d+)\](\n|$)/g, function(s, m1, m2) {
        return Array(parseInt(m2) + 1).join(m1 + '\n');
      }).trim().split(/\n/);
    }
    return this.words.intro = (function() {
      var _i, _len, _ref1, _results;
      _ref1 = this.words.intro;
      _results = [];
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        w = _ref1[_i];
        _results.push(!!w ? "" + w + "," : w);
      }
      return _results;
    }).call(this);
  };

  getCustom = function() {
    return randChoice(this.words.custom).replace(/\{(.+?)\}/g, function(s, m1) {
      if (m1 === 'phrase') {
        return getCombo();
      } else {
        return randChoice(this.words[m1]);
      }
    });
  };

  getCombo = function() {
    return template.map(function(type) {
      return randChoice(this.words[type]);
    }).compact().join(' ');
  };

  genPhrase = function() {
    var roll;
    roll = Math.random();
    if (roll < PRESET_CHANCE) {
      return randChoice(this.words.preset);
    } else if (roll < CUSTOM_CHANCE) {
      return getCustom();
    } else {
      return getCombo();
    }
  };

  setNewPhrase = function() {
    return $('#sentence').text(genPhrase().toUpperCase());
  };

  $(function() {
    setupWords();
    setNewPhrase();
    $('#new').click(function() {
      return setNewPhrase();
    });
    return $('#time').text(lastUpdated);
  });

}).call(this);
