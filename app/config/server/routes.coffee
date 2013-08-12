Salad.Router.register (router) ->
  router.get("/").to("index.index")
  router.get("/index").to("index.index")

  router.resource("todos", "todos", "todo")