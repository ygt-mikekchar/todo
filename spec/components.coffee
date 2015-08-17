Document = require "../src/components.coffee"

describe "Document", ->
  describe "@create_fake", ->
    it "creates an HTML element with no contents", ->
      subject = Document.create_fake()
      expect(subject.dom.innerHTML).toEqual("")
