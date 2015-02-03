ractive = require 'ractive'
fs = require 'fs'
read = fs.readFileSync

cache = {}
render = (path, options, fn) ->
  if typeof options is 'function'
    fn = options
    options = {}
  options.filename = path
  html = if options.cache
    key = path + ':string'
    cache[key] ?= read path, 'utf8'
  else
    read path, 'utf8' unless options.cache

  r = new ractive
    template: html
    data: options
    stripComments: false

  fn null, r.toHTML()


partialPattern = '&&<>&&'
stripLayoutExtensionsRegEx = new RegExp '\n?' + partialPattern + '.+?' + partialPattern + '\n?', 'g'

initOptions = (options) ->
  # establecemos una referencia circular para poder establecer
  # opciones del layout con los layoutHelpers
  options.options = options
  Object.keys(layoutHelpers).forEach (helperName) ->
    option = helperName.substring(1)
    value = options[option]
    options[option] = null if typeof value == 'undefined'

###*
# Parsea el body y guarda en las options los fragmentos correspondientes
# a cada contenido parcial (head, body y script)
# @param body
# @param options
###
parseFragments = (body, options) ->
  regex = new RegExp('\n?' + partialPattern + '.+?' + partialPattern + '\n?', 'g')
  split = body.split(regex)
  matches = body.match(regex)
  options.body = split[0].trim()
  if matches != null
    matches.forEach (match, idx) ->
      name = match.split(partialPattern)[1]
      content = split[idx + 1].trim()
      if options[name]
        options[name] += '\n' + content
      else
        options[name] = content

layoutsMiddleware = (req, res, next) ->
  render = res.render

  res.render = (view, options, fn) ->
    initOptions options
    render.call res, view, options, (err, body) ->
      if err
        if fn
          return fn(err)
        else
          throw err
      if req.xhr or options.layout == false
        res.send body.replace stripLayoutExtensionsRegEx, ''
      else
        parseFragments body, options
        render.call res, (options.layout or 'layout'), options, fn

  next()

contentFor = (name) ->
  partialPattern + name + partialPattern

bindLocal = (name) ->
  (value) -> @options[name] = value

layoutHelpers =
  $layout:   bindLocal  'layout'
  $id:       bindLocal  'id'
  $classes:  bindLocal  'classes'
  $style:    bindLocal  'style'
  $title:    bindLocal  'title'
  $footer:   bindLocal  'footer'
  $head:     contentFor 'head'
  $body:     contentFor 'body'
  $js:       bindLocal  'js'
  $script:   contentFor 'script'

module.exports = exports =
  render: render
  layoutsMiddleware: layoutsMiddleware
