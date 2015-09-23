# High level Container for the TODO lists

    React = require("react")

    module.exports = React.createClass

## Tests

There are [unit tests](../spec/TodoApp.litcoffee) for this code.  There is a link
to the tests (and back) for each piece of functionality that has a test.
This code uses [jasmine-given](https://github.com/searls/jasmine-given) and
some hand built [React Matchers](../spec/react_matchers.litcoffee) to make the tests
easier to write and read.

## Inline styles

Note: [Why inline styles?](styles.md)

Here are some inline styles for this component.  Basically it is just
something to make it visible in the browser.  I will change it to
something else later.

**Tests are missing**

      inlineStyles: ->
        backgroundColor: "dodgerblue"
        width: "80%"
        height: "1.2rem"

## TodoApp renders a div

Finally we need to render the div into the document.  This brings us to the first
major point.  With react, it is useful to have a top level div that contains
all the other components.  This component does not need to do anything
for itself, but if we are to move state up from one component, to its parent,
we need to have somewhere to go.  This is the top level.

Another important point is that if you want to have transitions working without
a lot of effort, you need to keep a div around that is visible to put the
transition on.  The transition will only happen if the element was pre-existing
when the  transition is applied.

[Tests](../spec/TodoApp.litcoffee#TodoApp-renders-a-div)

      render: ->
        <div className='js-todo-app' style={@inlineStyles()} >
        </div>

**Back**
