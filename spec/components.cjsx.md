## Some Useless tests

We require the addons so that we can get the test utils

    React = require("react/addons")
    Utils = React.addons.TestUtils

Probably I should rename the componenets file

    TodoApp = require("../src/components.cjsx.md")

Note: We are using [jasmine-given](https://github.com/searls/jasmine-given)
in these thests.  It is being loaded by (spec/index.html)[spec/index.html].

At first we need to add our React Matchers to jasmine.

    describe "TodoApp", ->
      beforeEach ->
        jasmine.addMatchers(ReactMatchers)

### TodoApp renders a div

      When ->
        console.log(React)
        @subject = Utils.renderIntoDocument(
          <TodoApp />
        )
      Then -> expect(@subject).toContainReact(tag: "div")

**Back**
