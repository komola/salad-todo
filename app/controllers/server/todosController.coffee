class App.TodosController extends Salad.RestfulController
  @resource "todo"

  scoped: (callback) ->
    super (err, scope) =>
      scope = scope.asc("id")
      callback.call @, null, scope