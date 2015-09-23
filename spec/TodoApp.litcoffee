## Some Useless tests

We require the addons so that we can get the test utils

    React = require("react/addons")
    Utils = React.addons.TestUtils

    TodoApp = require("../src/TodoApp.litcoffee")

Note: We are using [jasmine-given](https://github.com/searls/jasmine-given)
in these thests.  It is being loaded by [spec/index.html](spec/index.html).

We are also going to add some [React Matchers](react_matchers.litcoffee)
to jasmine to make our lives easier.

    ReactMatchers = require("./react_matchers.litcoffee")

    describe "TodoApp", ->
      beforeEach ->
        jasmine.addMatchers(ReactMatchers)

**Back**

### TodoApp renders a div
[Production](spec/TodoApp.litcoffee#TodoApp-renders-a-div)

      When ->
        @subject = Utils.renderIntoDocument(
          <TodoApp />
        )
      Then -> expect(@subject).toContainReact (subjectContains) ->
        subjectContains.tags("div")
                       .with.cssClass("js-todo-app")
                       .exactly(1).time
                       .result()

**Back**
