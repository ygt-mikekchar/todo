module.exports = class Document
  constructor: (root) ->
    if !root?
      @root = document.documentElement
    else
      @root = root

  @create_fake: ->
    new Document(document.createElement("html"))

  html: ->
    @root.innerHTML
