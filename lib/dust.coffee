dust = require 'dustjs-linkedin'
measure = require './measure'
cache = require './cache'

render = (path, data, fn) ->
  render = cache path, (source) ->
    console.log "compiling"
    dust.compileFn source

  measure.async (done) ->
    render data, (err, out) ->
      console.log err
      fn null, out
      done()

module.exports = exports =
  render: render
