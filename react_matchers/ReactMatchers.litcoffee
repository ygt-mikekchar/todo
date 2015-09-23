# React Matchers

Tests using the React test utilities are both difficult to read and inconvenient
to type.  As much as possible, I think it is best to write Jasmine matchers
to make the tests easier to write.

## Requirements

The matchers need to pluralize strings, so we need to load
[a string pluralizer method](pluralize.litcoffee)

    require("./pluralize.litcoffee")

We require the React and its addons so that we can get the test utils

    React = require("react/addons")
    Utils = React.addons.TestUtils

## DSL for React tests

These matchers will allow us to write tests like:

```coffee
  expect(component).toBeAComponent (it) ->
    it.contains.tags("div")
      .with.cssClass("my-class")
      .and.text("contents")
      .exactly(2).times
      .result()
```

**Note:** text() is not implemented yet.

One of the biggest problems with writing Jasmine matchers for React is that
you often have to search through Reacts tree to find the things you want
to test.  In Rspec (in Ruby) you can often chain matchers together to create
complex and readable tests.  Alas, this is not possible for Jasmine.

To compensate for this we will make a Maybe monad which will allow us to
chain a series of filters.  People often get flustered about monads, but
their use is very straight forward.

In example, aboce, `toBeAComponent` accepts a callback, which it will call,
funishing a monad called `it`.  We can then chain a series of tests.

This chain in this example means that I am expecting my component to contain a DOM `div`
with the class `my-css-class`.  This `div` should contain the text, `contents`.
There should be exactly 2 such `divs` in my tree.  The `result()` at the
end simply means, "Im done with my testing, please calculate the results".

The Maybe monad is a special kind of monad that only processes when
the data is valid.  In this case, if there are no `div` elements, then it
wont bother trying to figure out the cssClass, etc.  It will ignore
everything until it gets to the `result`.  Its a useful technique when
you dont want to constantly check return values for errors.

### The JasmineMonad

The [JasmineMonad](./JasmineMonad.litcoffee)is a "maybe" monad that
allows us to chain our matcher functions in a fluent way.

    JasmineMonad = require("./JasmineMonad.litcoffee")

### A monad for filtering collections of React components

This class filters collections React components, often for
the purpose of finding a DOM node with a specific CSS
class, or ID.

    class ComponentFilter extends JasmineMonad

Because this monad deals with filtering lists of components
it is nice to have a couple of dummy properties that
allow us to use a more fluent English expression.
`@with`, `@and` and `time` can be used for that purpose.

      constructor: (@value, @util, @testers, @messages) ->
        super(@value, @util, @testers, @messages)
        @with = this
        @and = this
        @time = this
        @times = this

#### Filtering nodes by CSS class

As this is the first monadic function we have seen, I will describe it
in a bit more detail.  Notice that the first line is a call to `@bind`.
You pass it a callback which accepts a list of components.  `@bind` will run
the function and pass `@value` in as the `component`.  You might be
wondering, "why dont we just use @value directly -- it is available
to us".  The reason we dont is because `@bind` is implementing our
Maybe functionality.  If we neglect to call it, we will lose that
functionality.  Although it is tempting to go around the structure
of the monad and treat it as any other object, it is better to follow
the interfact.

Secondly, you will notice that we call `@return` at the end.  This
builds a new Monad, wrapping the new component list and messages.  Note that
we return `null` in the case that our matcher fails.  This will stop
all subsequently chained matchers from running.

Be careful to only have one exit point in your monadic functions.
Otherwise you will have silly looking code that looks like:
`return @return(component, messages)`.

      cssClass: (cssClass) ->
        @bind (nodes) =>
          match = (a, b) ->
            return false if !b?
            b.indexOf(a) != -1

          if nodes?.length
            matched = (node for node in nodes when match(cssClass, node.props.className))
          else
            matched = []

          messages = [
            "Expected to find DOM node with class #{cssClass}, but it was not there."
            "Expected not to find DOM node with class #{cssClass}, but there #{@was(matched.length)}."
          ]

          if matched.length > 0
            @return(matched, messages)
          else
            @return(null, messages)

#### Enforcing the number of nodes

      exactly: (num) ->
        @bind (nodes) =>
          messages = [
            "Expected to find exactly #{@count(num, 'node')}, but there #{@was(nodes.length)}"
            "Expected not find #{@count(num, 'node')}, but there #{@was(nodes.length)}."
          ]

          if nodes.length == num
            @return(nodes, messages)
          else
            @return(null, messages)

### A monad for making queries of single Components

When we first start out, we are likely to have only a single
component.  This monad is used for querying that component
and getting a list of nodes that we will filter later.

    class ComponentQuery extends JasmineMonad

      constructor: (@value, @util, @testers, @messages) ->
        super(@value, @util, @testers, @messages)
        @contains = this

Most of the methods on `ComponentQuery` will actually want to
return a ComponentFilter so the user can filter the collection of returned 
nodes.  If we were using a language with strong typing the compiler
would be able to construct the correct the correct Monad based
on the types.  However, we are using Coffeescript, so we have to
give it a helping hand by making a different `return` method.

      returnMany: (nodes, messages) ->
        new ComponentFilter(nodes, @util, @testers, messages)

#### Testing for DOM tags

One of the most common kinds of tests is to determine whether or not
a component contains a DOM "tag" (eg "h1", "div", etc). This matcher
passes if there is at least one.


      tags: (tag) ->
        @bind (component) =>
          nodes = Utils.scryRenderedDOMComponentsWithTag(component, tag)
          messages = [
            "Expected to find DOM tag #{tag}, but it was not there."
            "Expected not to find DOM tag #{tag}, but there #{@was(nodes.length)}."
          ]
          if nodes.length > 0
            @returnMany(nodes, messages)
          else
            @return(null, messages)

**Back**

### Main matcher interface

We actually only require one main method in our matchers interface because
all of our matchers are actually implemented as methods on our monads.

    ReactMatchers =

      toBeAComponent: (util, testers) ->
        compare: (component, func) ->
          filter = new ComponentQuery(component, util, testers)
          func(filter)

**Back**

Export our matchers from this file.

    module.exports = ReactMatchers
