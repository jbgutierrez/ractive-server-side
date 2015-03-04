ractive = require 'ractive'
measure = require './measure'
cache = require './cache'

render = (path, data, fn) ->
  template = cache path
  r = null
  measure ->
    r = new ractive
      template: template
      data: data
      stripComments: false

  measure ->
    fn null, r.toHTML()

module.exports = exports =
  render: render
