// Generated by CoffeeScript 1.8.0
(function() {
  var cache, exports, fs, get, read;

  fs = require('fs');

  read = fs.readFileSync;

  cache = {};

  get = function(path, compile) {
    var template;
    return template = cache[path] != null ? cache[path] : cache[path] = (function() {
      var raw;
      raw = read(path, 'utf8');
      if (compile) {
        return compile(raw);
      } else {
        return raw;
      }
    })();
  };

  module.exports = exports = get;

}).call(this);