module.exports = {
  entry: {
    beans: __dirname + "/src/beans.js",
    spec: __dirname + "/spec/spec.js",
  },
  output: {
    path: __dirname + "/build",
    filename: "[name].bundle.js"
  }
};
