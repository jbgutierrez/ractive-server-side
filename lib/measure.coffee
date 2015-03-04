measure = (message, fn, binding) ->
  unless fn
    fn = message
    message = "benchmark"

  time = process.hrtime()
  result = fn.apply binding
  diff = process.hrtime(time)
  ms = (diff[0] * 1e9 + diff[1]) / 1000000
  console.log "#{message}: took %d nanoseconds", ms
  result

measure.async = (message, fn, binding) ->
  unless fn
    fn = message
    message = "benchmark"

  time = process.hrtime()
  done = ->
    diff = process.hrtime(time)
    ms = (diff[0] * 1e9 + diff[1]) / 1000000
    console.log "#{message}: took %d nanoseconds", ms
  fn.apply binding, [done]

module.exports = exports = measure
