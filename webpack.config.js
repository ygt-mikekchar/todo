path = require("path")

module.exports = {
  entry: {
    todo: path.join(__dirname, "/src/todo.litcoffee"),
    spec: path.join(__dirname, "/spec/spec.litcoffee"),
  },
  output: {
    path: path.join(__dirname, "/build"),
    filename: "[name].bundle.js"
  },
  module: {
    loaders: [
      { test: /\.cjsx$/, loaders: ['coffee', 'cjsx']},
      { test: /\.coffee$/, loader: "coffee" },
      { test: /\.litcjsx$/, loaders: ['coffee?literate', 'cjsx?literate']},
      { test: /\.litcoffee$/, loader: "coffee?literate" }
    ]
  }
};
