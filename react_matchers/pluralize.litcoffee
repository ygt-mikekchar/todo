### String#pluralize method

Many of the tests need to output plural versions of
objects.  This is just a handy utility to help with that.

    String.prototype.pluralize = (num, plural) ->
      return this if num == 1
      if plural? then plural else "#{this}s"
