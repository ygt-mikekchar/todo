## Some Useless tests

### Lazily evaluated initializer

Often you need to re-render React components, changing the props.
It is convenient to use a lazily evaluated initializer for that
purpose.

    lazy = (lambda) ->
      func = -> func._memo || (func._memo = lambda())

### Requirements

We require the addons so that we can get the test utils

    React = require("react")
    ReactTestUtils = require('react-addons-test-utils')

    TodoApp = require("../src/TodoApp.litcoffee")

We are also going to add some [React Matchers](https://github.com/ygt-mikekchar/react-maybe-matchers)
to jasmine to make our lives easier.

    ReactMaybeMatchers = require("react-maybe-matchers")

    describe "Render a TodoApp", ->
      beforeEach ->
        new ReactMaybeMatchers(ReactTestUtils).addTo(jasmine)

        @subject = lazy ->
          ReactTestUtils.renderIntoDocument(
            <TodoApp />
          )

**Back**

### TodoApp renders a div
[Production Code](../src/TodoApp.litcoffee#todoapp-renders-a-div)

      it "reders a div", ->
        expect(@subject()).toBeAComponent (which) ->
          which.contains.tags("div")
            .with.cssClass("js-todo-app")
            .exactly(1).time
            .result()

**Back**
