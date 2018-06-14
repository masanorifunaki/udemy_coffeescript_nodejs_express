NODE_ENV = (process.env.NODE_ENV || "").trim() || "development"
IS_DEVELOPMENT = NODE_ENV == "development"
#IS_DEVELOPMENT = NODE_ENV == "production"

module.exports =
  env: {
    NODE_ENV,
    IS_DEVELOPMENT
  },
  path: {
    root: "./",
    log: "./log",
    node_modules: "./node_modules",
    input: "./public/source",
    output: "./public/#{NODE_ENV}"
  },
  sass: {
    outputStyle: if IS_DEVELOPMENT then "expanded" else "compressed"
  },
  uglify: {

  }
