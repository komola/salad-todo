App.module "Index", (Index, App, Backbone) ->
  class Index.Todo extends Backbone.Model
    urlRoot: "/todos"

    toJSON: ->
      todo: @attributes

    toggle: ->
      @set "completedAt", if @get("completedAt") then null else new Date()
      @save()

  class Index.Collection extends Backbone.Collection
    model: Index.Todo
    url: "/todos"
