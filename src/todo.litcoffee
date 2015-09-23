# A TODO Example in Literate Coffeescript

* [Project Page](https://github.com/ygt-mikekchar/todo)
* [Demo/Tests](http://ygt-mikekchar.github.io/todo)

If you like, you can read an [introduction](introduction.md)
to this project and to
[literate programming](introduction.md#literate-programming).

## Explore the source

This is the code that embeds the TODO app in your HTML.
Basically you use it like:

```html
<div class="js-todo-app"></div>
```

Running this code will render the TodoApp in that div.
To see a working example of this, take a look
at the [html](../index.html) for the
[demo](http://ygt-mikekchar.github.io/todo).

    React = require("react")
    TodoApp = require "./TodoApp.litcoffee"

    React.render(
      <TodoApp />,
      document.getElementById('js-todo-app')
    )

[TodoApp](TodoApp.litcoffee) is the top level react componenet
for the app.

Note that this file is the top level file loaded by
[webpack](https://webpack.github.io/).  You can
browse the [configuration file](../webpack.config.js)
if you like, but discussion of how it works is out
of scope for this document.

**Back**
