# React Matchers

We require the addons so that we can get the test utils

    React = require("react/addons")
    Utils = React.addons.TestUtils

Tests using the React test utilities are both difficult to read and inconvenient
to type.  As much as possible, I think it's best to write Jasmine matchers
to make the tests easier to write.

## DSL for React tests

One of the biggest problems with writing Jasmine matchers for React is that
you often have to search through React's tree to find the things you want
to test.  In Rspec (in Ruby) you can often chain matchers together to create
complex and readable tests.  Alas, this is not possible for Jasmine.

To compensate for this we will make a Maybe monad which will allow us to
chain a series of filters.  People often get flustered about monads, but
their use is very straight forward.  Here is an example of the kind of 
thing we want to do.

```coffee
  expect(component).toContainReact (componentContains) ->
    componentContains.tags("div")
      .with.cssClass("my-class")
      .and.text("contents")
      .exactly(2).times
      .result()
```

This means that I am expecting my component to contain a DOM `div`
with the class 'my-css-class'.  This `div` should contain the text, 'contents'.
There should be exactly 2 such `divs` in my tree.  The `result()` at the
end simply means, "I'm done with my testing, please calculate the results".

The Maybe monad is a special kind of monad that only processes when
the data is valid.  In this case, if there are no `div` elements, then it
won't bother trying to figure out the cssClass, etc.  It will ignore
everything until it gets to the `result`.  It's a useful technique when
you don't want to constantly check return values for errors.

**Note:** Only "tag" is implemented so far.

In our example, `toContainReact` accepts a callback, which it will call,
funishing a monad called `componentContains`.  We can then chain a series
of tests.

### A monad for Jasmine tests

This is the base class for our monads.  In general, a monad simply wraps
a value and provides a way to run arbitrary functions using those
wrapped values.  Monads are meant to be immutable.  This means that it
doesn't change state.  You can only set instance variables in the constructor.
Because of that, the functions that use monad's data usually return
a *new* monad constructed from the data transformed in the function.

    class JasmineMonad

      constructor: (@value, @util, @testers, @messages) ->
        @messages = [] if !@messages?

      return: (value, messages) ->
        new @constructor(value, @util, @testers, messages)

      bind: (func) ->
        if @passed()
          func(@value)
        else
          this

      passed: () ->
        @value?

      result: ->
        result = {}
        result.pass = @util.equals(@passed(), true, @testers)
        if @messages?
          if result.pass
            result.message = @messages[1]
          else
            result.message = @messages[0]
        return result

    class ComponentFilter extends JasmineMonad

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

    ReactMatchers =

      toContainReact: (util, testers) ->
        compare: (component, func) ->
          filter = new ComponentFilter(component, util, testers)
          func(filter)

**Back**

Export our matchers from this file.

    module.exports = ReactMatchers
