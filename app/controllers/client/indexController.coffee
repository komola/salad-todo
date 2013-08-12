App.module "Index", (Index, App, Backbone) ->
  class Index.Router extends Backbone.Marionette.AppRouter
    appRoutes:
      "": "start"
      "index": "start"

  class Index.Controller
    start: ->
      console.log "Here we go..."

      @collection = new App.Index.Collection()
      @collection.fetch()

      @showList @collection

    showList: (collection) ->
      App.main.show new Index.Views.ListView
        collection: collection

  Index.addInitializer ->
    console.log "test"
    controller = new Index.Controller

    new Index.Router
      controller: controller