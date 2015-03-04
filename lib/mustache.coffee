Mustache = require 'Mustache'
measure  = require './measure'
cache    = require './cache'

render = (path, data, fn) ->
  template = cache path
  Mustache.parse(template)
  measure ->
    fn null, Mustache.render template, data

module.exports = exports =
  render: render
