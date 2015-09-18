## Some Useless tests

We require the addons so that we can get the test utils

    React = require("react/addons")
    Utils = React.TestUtils

Probably I should rename the componenets file

    TodoApp = require("../src/components.cjsx.md")

Note: We are using [jasmine-given](https://github.com/searls/jasmine-given)
in these thests.  It is being loaded by (spec/index.html)[spec/index.html].

### TodoApp exists

    describe "TodoApp", ->
      Given -> @subject = TodoApp
      Then -> expect(@subject).toEqual(jasmine.any(Function))

**Back**
