## Some Useless tests

We require the addons so that we can get the test utils

    React = require("react/addons")
    Utils = React.TestUtils

Probably I should rename the componenets file

    TodoApp = require("../src/components.cjsx.md")

### TodoApp exists

    describe "TodoApp", ->
      it "exists", ->
        expect(TodoApp).toEqual(jasmine.any(Function))

<a href="javascript:history.back()">Back</a>
