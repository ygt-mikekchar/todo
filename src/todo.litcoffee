# A TODO Example in Literate Coffeescript

* [Project Page](https://github.com/ygt-mikekchar/todo)
* [Demo/Tests](http://ygt-mikekchar.github.io/todo)

If you like, you can read an [introduction](introduction.md)
to this project and to
[literate programming](introduction.md#literate-programming).

## Explore the source

This file is just a loader that gives webpack a place
to load everything all at once.

[React components in this project](TodoApp.litcoffee)

    React = require("react")
    TodoApp = require "./TodoApp.litcoffee"

    React.render(
      <TodoApp />,
      document.getElementById('js-todo-app')
    )
