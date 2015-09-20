## Some Useless tests

We require the addons so that we can get the test utils

    React = require("react/addons")
    Utils = React.addons.TestUtils

Probably I should rename the componenets file

    TodoApp = require("../src/components.cjsx.md")

Note: We are using [jasmine-given](https://github.com/searls/jasmine-given)
in these thests.  It is being loaded by (spec/index.html)[spec/index.html].

### Some React Matchers

Tests using the React test utilities are both difficult to read and inconvenient
to type.  As much as possible, I think it's best to write Jasmine matchers
to make the tests easier to write.

Jasmine matchers are kind of confusing to write.  Each matcher is a function
that returns an object with a comparison function.  I want to reuse some
of these comparison functions, so I have made an object (called Compare) that
contains all the comparison functions.

    Compare =

This function determines whether or not a given React component contains
an DOM element with a given tag (eg "h1", "div", etc).  Note that there
is a bug because in the inverse case (not.toContainReact(tag: "div")), the
code checks to see if the number of nodes is != 1.  So if there are many,
it falsely reports that there are none.

      containsTag: (component, tag, util, testers) ->
        result = {}
        nodes = Utils.scryRenderedDOMComponentsWithTag(component, tag)
        result.pass = util.equals(nodes.length, 1, testers)
        if result.pass
          result.message = "Expected one #{tag}, but there were #{nodes.length}"
        else
          result.message = "Expected not to have #{tag}, but there was"
        return result

    ReactMatchers =

This matcher simply tests to see whether there is a contained DOM element
in a component.  It uses the `containsTag` in the Compare object.

      toContainReact: (util, testers) ->
        compare: (component, expected) ->
          if expected.tag?
            return Compare.containsTag(component, expected.tag, util, testers)

**Back**

At first we need to add our React Matchers to jasmine.

    describe "TodoApp", ->
      beforeEach ->
        jasmine.addMatchers(ReactMatchers)

### TodoApp renders a div

      When ->
        console.log(React)
        @subject = Utils.renderIntoDocument(
          <TodoApp />
        )
      Then -> expect(@subject).toContainReact(tag: "div")

**Back**
