# High level Container for the TODO lists

    React = require("react")

    module.exports = React.createClass

Normally it doesnt make sense to embed the styles directly in javascript.
I want to document the code using literateCofee, so I'm going to
write styles here.  It makes much more sense to make a separate style
sheet in load it into the HTML.

Here are some inline styles for this component.  Basically it's just
something to make it visible in the browser.  I will change it to
something else later.

      inlineStyles: ->
        backgroundColor: "dodgerblue"
        width: "80%"
        height: "1.2rem"

      render: ->
        <div className='js-todo-app' style={@inlineStyles()} >
        </div>
