// Generated by CoffeeScript 1.8.0
(function() {
  var Mustache, cache, exports, measure, render;

  Mustache = require('Mustache');

  measure = require('./measure');

  cache = require('./cache');

  render = function(path, data, fn) {
    var template;
    template = cache(path);
    Mustache.parse(template);
    return measure(function() {
      return fn(null, Mustache.render(template, data));
    });
  };

  module.exports = exports = {
    render: render
  };

}).call(this);