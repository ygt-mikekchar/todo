path = require("path")

module.exports = {
  entry: {
    todo: path.join(__dirname, "/src/todo.coffee"),
    spec: path.join(__dirname, "/spec/spec.coffee"),
  },
  output: {
    path: path.join(__dirname, "/build"),
    filename: "[name].bundle.js"
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loader: "coffee" }
    ]
  }
};
