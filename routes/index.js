// Generated by CoffeeScript 1.8.0
(function() {
  var express, router;

  express = require('express');

  router = express.Router();

  router.get('/:engine', function(req, res, next) {
    var engine, i, list;
    engine = req.params.engine;
    console.log(engine);
    list = (function() {
      var _i, _results;
      _results = [];
      for (i = _i = 1; _i <= 10000; i = ++_i) {
        _results.push({
          name: i
        });
      }
      return _results;
    })();
    return res.render("index." + engine, {
      list: list
    });
  });

  module.exports = router;

}).call(this);
