fs       = require 'fs'
read     = fs.readFileSync

cache = {}
get = (path, compile) ->
  template = cache[path] ?= ( -> 
    raw = read path, 'utf8'
    if compile then compile raw else raw
  )()

module.exports = exports = get
