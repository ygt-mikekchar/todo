# React Matchers

We require the addons so that we can get the test utils

    React = require("react/addons")
    Utils = React.addons.TestUtils

Tests using the React test utilities are both difficult to read and inconvenient
to type.  As much as possible, I think it's best to write Jasmine matchers
to make the tests easier to write.

    class ComponentFilter
      constructor: (@component, @util, @testers, @messages) ->
        @messages = [] if !@messages?

      return: (component, messages) ->
        new ComponentFilter(component, @util, @testers, messages)

      bind: (func) ->
        if @component?
          func(@component)
        else
          this

      result: ->
        result = {}
        result.pass = @util.equals(@component?, true, @testers)
        if @messages?
          if result.pass
            result.message = @messages[1]
          else
            result.message = @messages[0]
        return result

### Testing for DOM tags

One of the most common kinds of tests is to determine whether or not
a component contains a DOM "tag" (eg "h1", "div", etc).  It returns
true if there is at least one.

      tags: (tag) ->
        @bind (component) =>
          nodes = Utils.scryRenderedDOMComponentsWithTag(component, tag)
          messages = [
            "Expected to find DOM tag #{tag}, but it was not there."
            "Expected not to find DOM tag #{tag}, but there were #{nodes.length}."
          ]
          if nodes.length > 0
            @return(component, messages)
          else
            @return(null, messages)

**Back**

## DSL for React tests

One fo the biggest problems with writing Jasmine matchers is tring to find
an appropriate name for the matcher.  In Rspec (in Ruby) you can often
chain matchers together to create complex and readable tests.  Alas, this
is not possible for Jasmine.

To compensate for this toContainReact furnishes a Maybe monad that allows
you to filter the contents of the React tree.

```coffee
  expect(component).toContainReact (contains) ->
    contains.tags("div")
      .with.cssClass("my-class")
      .and.text("contents")
      .result()
```

This means that I am expecting my component to contain a DOM div
with the class 'my-css-class'.  This DOM should contain the text, 'contents'.

**Note:** Only "tag" is implemented so far.  

    ReactMatchers =

      toContainReact: (util, testers) ->
        compare: (component, func) ->
          filter = new ComponentFilter(component, util, testers)
          func(filter)

**Back**

Export our matchers from this file.

    module.exports = ReactMatchers
