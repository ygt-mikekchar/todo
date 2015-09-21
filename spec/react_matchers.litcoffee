# React Matchers

We require the addons so that we can get the test utils

    React = require("react/addons")
    Utils = React.addons.TestUtils

Tests using the React test utilities are both difficult to read and inconvenient
to type.  As much as possible, I think it's best to write Jasmine matchers
to make the tests easier to write.

Unfortunately, Jasmine matchers are kind of confusing to write.  Each matcher
is a function that returns an object with a comparison function.  I want to reuse some
of these comparison functions, so I have made this object to contain them.

    Compare =

### Testing for DOM tags

One of the most common kinds of tests is to determine whether or not
a component contains a DOM "tag" (eg "h1", "div", etc).
**Note**: This code contains bug. In the inverse case
(not.toContainReact(tag: "div")), the code checks to see if the
number of nodes is != 1.  So if there are many, it falsely reports that
there are none.

      containsTag: (component, tag, util, testers) ->
        result = {}
        nodes = Utils.scryRenderedDOMComponentsWithTag(component, tag)
        result.pass = util.equals(nodes.length, 1, testers)
        if result.pass
          result.message = "Expected one #{tag}, but there were #{nodes.length}"
        else
          result.message = "Expected not to have #{tag}, but there was"
        return result

**Back**

## DSL for React tests

One fo the biggest problems with writing Jasmine matchers is tring to find
an appropriate name for the matcher.  In Rspec (in Ruby) you can often
chain matchers together to create complex and readable tests.  Alas, this
is not possible for Jasmine.

To compensate for this I make a kind of DSL with hashes.  The result
looks like:

```coffee
  expect(component).toContainReact(
    tag: 'div'
    class: 'my-css-class'
    text: 'contents'
  )
```

This means that I am expecting my component to contain a DOM div
with the class 'my-css-class'.  This DOM should contain the text, 'contents'.

**Note:** Only "tag" is implemented so far.  

    ReactMatchers =

      toContainReact: (util, testers) ->
        compare: (component, expected) ->
          if expected.tag?
            return Compare.containsTag(component, expected.tag, util, testers)

**Back**

Export our matchers from this file.

    module.exports = ReactMatchers
