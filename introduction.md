# Introduction

We started to use React a little over a year ago.  When we
started, I don't think that we had a really clear picture about
idioms in React that would lead to simple logic.  As a result,
some of our code contained a lot of state and corresponding
logic to deal with that state.

Recently, I had the opportunity to refactor some of that old
code and I developed some opinions on what kind of idioms lead
to simple React code.  Because they are not necessarily obvious,
I thought it would be nice to write something that explains
some of the ideas.

Note that this project deals only with straight React code,
without Flux (or similar frameworks).  I think that Flux, et al,
can make it easier to understand how to write simple code
in React, but I don't think it is necessary.

## How to use this project

I originally thought about writing an ordinary blog post to
describe my ideas, but then I realized that it would be easier
to explain if the reader could have access to working code
and especially unit tests.  For that reason, I've decided to
implement this project in
[literate Coffeescript](http://coffeescript.org/#literate).

### Literate Programming

If you are unfamiliar with
[literate programming](https://en.wikipedia.org/wiki/Literate_programming),
it is a style of programming where you embed the executable
code inside a natural language document.  The intent is to describe
the program in the same way that you would present a design
document.

Literate programming was introduced by Donald Knuth with the
TeX typesetting language.  The idea was that you had a preprocessor
that would extract the executable portions of the code out
of your natural language documents and then reassemble them
in an order that the computer would like to see them.  This
allowed you to present the code in the way that was easiest
for the reader to understand and then rearrange it so that it
was easy for the computer to compile.

Unfortunately, literate Coffeescript does not have the ability
to rearrange fragments.  It's really just coffeescript embedded
in a Markdown document.  Because of that, I will try to add links
that will follow the natural presentation order of the material.

For example, [please follow this link](literate-example.md)

**Back** or [browse the source](todo.litcoffee)
