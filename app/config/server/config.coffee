config = {}

config.database =
  production:
    username: "salad-todo"
    password: "salad"
    host: "localhost"
    database: "salad-todo"
    port: 5432

  testing:
    username: "salad-todo"
    password: "salad"
    host: "localhost"
    database: "salad-todo-testing"
    port: 5432

  development:
    username: "salad-todo"
    password: "salad"
    host: "localhost"
    database: "salad-todo-development"
    port: 5432

module.exports = config