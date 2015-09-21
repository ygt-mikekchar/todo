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

Our monad wraps a few things.  The important ones are the `value`
and the `messages`.  The `value` depends on the type of monad we
are constructing.  In the general case it will be a React component.
Basically, the monad is simply a wrapper for the component that
will allow us to chain filters and matchers.  Later there will also
be a similar monad that contains DOM nodes (TBD).

The other main thing the monad wraps are the `messages` for the
last run matcher.  Jasmine has an odd way of outputting error
messages.  When you write a matcher, you need to supply the
error message both for whent the matcher does not pass *and*
for when the matcher does not  pass when `.not` was supplied.
We store these two messages from the last run matcher in
@messages.

You can see the there is a method called `return` that simply
calls the constructor.  This probably looks a bit odd, but
`return` is what Haskel uses for creating a new Monad.  When
you see the implementation of a matcher (see below), you will
see why it is called `return`.  We won't cause confusion with
the reserved word because we will always invoke it as
`@return()` or `monad.return()`.

      constructor: (@value, @util, @testers, @messages) ->
        @messages = [] if !@messages?

      return: (value, messages) ->
        new @constructor(value, @util, @testers, messages)

To be a monad, we need to be able to run arbitrary functions
and have the wrapped value in the monad passed to it.  Historically
`bind` is the name for that function.  We are implementing a
"Maybe" monad.  This means that when `bind()` is called, you only
run the passed function if some condition holds.  In our case
we want to run the function if all the matchers up to this point
have passed.

Note that in the case where we don't want to run the function, we
still have to return `this` otherwise we won't be able to chain
any more functions.  This is the power of the Maybe monad; to
chain together a series of functions without having to worry
about error conditions.  It will simply skip over the ones 
after the error occurs.

      bind: (func) ->
        if @passed()
          func(@value)
        else
          this

We don't have any definitive way of determining if the previous
matchers have passed, so we will rely on the matcher functions
to return null when the matcher fails.

      passed: () ->
        @value?

Once we have run our chain of matchers and filters, we need some
way of returning a result to Jasmine.  This should always be
the last method called in the chain.  Notice that it doesn't
return a new monad, but rather the result object that Jasmine
expects.

      result: ->
        result = {}
        result.pass = @util.equals(@passed(), true, @testers)
        if @messages?
          if result.pass
            result.message = @messages[1]
          else
            result.message = @messages[0]
        return result

### A monad for filtering React components

    class ComponentFilter extends JasmineMonad

#### Testing for DOM tags

One of the most common kinds of tests is to determine whether or not
a component contains a DOM "tag" (eg "h1", "div", etc). This matcher
passes if there is at least one.

As this is the first monadic function we have seen, I will describe it
in a bit more detail.  Notice that the first line is a call to `@bind`.
You pass it a callback which accepts a component.  `@bind` will run
the function and pass `@value` in as the `component`.  You might be
wondering, "why don't we just use @value directly -- it is available
to us".  The reason we don't is because `@bind` is implementing our
Maybe functionality.  If we neglect to call it, we will lose that
functionality.  Although it is tempting to go around the structure
of the monad and treat it as any other object, it is better to follow
the interfact.

Secondly, you will notice that we call `@return` at the end.  This
builds a new Monad, wrapping the component and messages.  Note that
we return `null` in the case that our matcher fails.  This will stop
all subsequently chained matchers from running.

Be careful to only have one exit point in your monadic functions.
Otherwise you will have silly looking code that looks like:
`return @return(component, messages)`.

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
### Main matcher interface

We actually only require one main method in our matchers interface because
all of our matchers are actually implemented as methods on our monads.

    ReactMatchers =

      toContainReact: (util, testers) ->
        compare: (component, func) ->
          filter = new ComponentFilter(component, util, testers)
          func(filter)

**Back**

Export our matchers from this file.

    module.exports = ReactMatchers
