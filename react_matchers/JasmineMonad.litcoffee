# A monad for Jasmine tests

## Requirements

The matchers need to pluralize strings, so we need to load
[a string pluralizer method](pluralize.litcoffee)

    require("./pluralize.litcoffee")

## JasmineMonad

This is the base class for our matcher monads.  In general, a monad simply wraps
a value and provides a way to run arbitrary functions using those
wrapped values.  Monads are meant to be immutable.  This means that it
doesnt change state.  You can only set instance variables in the constructor.
Because of that, the functions that use a monads data usually return
a *new* monad constructed from the data transformed in the function.

    class JasmineMonad

Our monad wraps a few things.  The important ones are the `value`
and the `messages`.  The `value` depends on the type of monad we
are constructing.  We will contain either a single React
component, or a list of React components, depending on the type
of monad.  Basically, the monad is simply a wrapper for the component that
will allow us to chain filters and matchers.

The other main thing the monad wraps are the `messages` for the
last run matcher.  Jasmine has an odd way of outputting error
messages.  When you write a matcher, you need to supply the
error message both for when the matcher does not pass *and*
for when the matcher does not  pass when `.not` was supplied.
We store these two messages from the last run matcher in
@messages.

In the following two methods You can see there is a method
called `return` that simply calls the constructor.  This probably
looks a bit odd, but `return` is what Haskel uses for creating a new
Monad.  When you see the 
[implementation of a matcher](./ComponentFilter.litcoffee#filtering-nodes-by-css-class),
you will see why it is called `return`.  The name will not cause
a conflict with the reserved word `return` because we will always
invoke it as `@return()` or `monad.return()`.

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

Note that in the case where we dont want to run the function, we
still have to return `this` otherwise we wont be able to chain
any more functions.  This is the power of the Maybe monad; to
chain together a series of functions without having to worry
about error conditions.  It will simply skip over the ones 
after the error occurs.

      bind: (func) ->
        if @passed()
          func(@value)
        else
          this

We dont have any definitive way of determining if the previous
matchers have passed, so we will rely on the matcher functions
to return null when the matcher fails.

      passed: () ->
        @value?

Once we have run our chain of matchers and filters, we need some
way of returning a result to Jasmine.  This should always be
the last method called in the chain.  Notice that it doesnt
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

In constructing the messages it is often the case that you want to
use the word "was/were" depending on the number of items.  This
is a small helper utility.

For example:
```
"there #{@was(1)}" # == "there was 1"
"There #{@was(2)}" # == "there were 2"
```

      was: (num) ->
        'was'.pluralize(num, 'were') + " #{num}"

Similarly we often want to count the number of objects using the
correct pluralization.

For example:
```
"I have #{@count(1, 'apple')}"            # == "I have 1 apple"
"I have #{@count(2, 'apple')}"            # == "I have 2 apples"
"I have #{@count(2, 'mommy', 'mommies)}"  # == "I have 2 mommies" 
```

      count: (num, singular, plural) ->
        "#{num} #{singular.pluralize(num, plural)}"

Export our matchers from this file.

    module.exports = JasmineMonad
