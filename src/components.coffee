class DOMElement
  constructor: (@factory, @name, @contents) ->
    # TODO Create a tree of @contents

  render: ->
    # TODO render the @contents tree and insert into element
    @factory.createElement(@name)

class DOMFactory
  constructor: (@document) ->
    @document = document if !@document?

  createElement: (name) ->
    @document.createElement(name)

  html: (fn) ->
    # TODO: run fn() to determine contents
    new DOMElement(this, @name, null)

module.exports = class Document
  constructor: (@document, @dom) ->
    @document = document if !@document?
    @factory = new DOMFactory(@document)
    @dom = @document.documentElement if !@dom?

  # Create a document with and empty html element
  @create_fake: (document) ->
    factory = new DOMFactory(document)
    dom = factory.html(->).render()
    new Document(document, dom)
