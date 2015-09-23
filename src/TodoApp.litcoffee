# High level Container for the TODO lists

    React = require("react")

    module.exports = React.createClass

Here are some inline styles for this component.  [(Why inline styles?)](styles.md)
Basically it is just something to make it visible in the browser.  I will change it to
something else later.

      inlineStyles: ->
        backgroundColor: "dodgerblue"
        width: "80%"
        height: "1.2rem"

Finally we need to render the div into the document.  This brings us to the first
major point.  With react, it is useful to have a top level div that contains
all the other components.  This component does not need to do anything
for itself, but if we are to move state up from one component, to its parent,
we need to have somewhere to go.  This is the top level.

Another important point is that if you want to have transitions working without
a lot of effort, you need to keep a div around that is visible to put the
transition on.  The transition will only happen if the element was pre-existing
when the  transition is applied.

      render: ->
        <div className='js-todo-app' style={@inlineStyles()} >
        </div>

**Back**
