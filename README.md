# Beans II - A web version of Beans, a technical debt analogy game

Copyright (C) 2015 Mike Charlton

Note: This is a re-implementation of : https://github.com/mikekchar/beans
      Please see that project for a description.

## Try it

Currently Beans is in active development.  All of the features are
currently unimplemented.  However, you can follow
[the current progress](http://mikekchar.github.io/BeansII)

## Description

Beans is a game that tries to model technical debt.  The idea is that
choices you make early on in the game to get quick wins (or to
avoid thinking strategically) increase costs later in the game.
However, early wins can be lucrative, so creating a balance is crucial.

The original Beans game was not entirely successful in its aim, as
the game is quite difficult to play.  Beans II will probably suffer
the same fate as I am using it as a technical challenge only.

### Rules

There are 3 jars.  Two of them are empty.  The other contains
9 jelly beans.  3 of the jelly beans are red, 3 are black, and
3 are green.

The game starts with 15 potential points.  Every turn the
number of potential points is reduced by 1.

The player starts the game without holding a jelly bean.  They
can remove a jelly bean from any jar that contains one.  They
will then be holding that jelly bean.  This does not take a turn.

The jars randomly accept beans.  The first jar is 100% likely
to accept a bean.  The second jar is 50% likely to accept
a bean. The third is 25% likely to accept a bean.

The user can deposit a bean in any accepting jar, or pass their
turn (and continue holding on to the bean).  This takes 1 turn.

The user can "force" a bean into a jar.  This will simply keep
trying until the jar accepts the bean, using as many turns as
necessary.

Every jar has a "point multiplier".  It is calculated by counting
the most numerous colour bean and subtracting all of the other
beans.  So if a jar has 3 red beans, 1 black bean and one green bean,
then the "point multiplier" for the jar is 1 (3 - 1 - 1).  The point
multiplier can not be less than 0.

Any time a jar has a multiplier greater than 1, it can be "released".
Doing so gives the user a number of points equal to:
```
  potential points * point multiplier
```
It then removes the jar and all of the contained beans from the game.

The game is over when:
- The potential points < 1.
- There are no unreleased jars left
- There is only 1 jar left and it has a point multiplier of 0


## License

The original Beans program was licensed under the GPLv3.  BeansII
is licensed under the AGPLv3.  GPLv3 code can be used in AGPLv3
code, but the opposite is not true.  Be careful about that.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

### Why AGPL?

Beans II does not actually run on a server, so there is no particular
need for it to be licensed under AGPL.  This is the first of a series
of games that I will write in Coffeescript and I wish to share code
freely between them.  Other projects will need AGPL, so just to keep
the headaches to a minimum for myself, I've decided to go this way.

