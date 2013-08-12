_.mixin _.str.exports()
_.extend Backbone.Model.prototype, Backbone.Validation.mixin

App = window.App = new Backbone.Marionette.Application
  root: "/"

App.addRegions
  main: "#main"

Backbone.Marionette.Renderer.render = (template, data) ->
  # data = _.extend data,
  #   _t: (val) -> window.gettext val
  #   format: true

  Templates[template] data

$(document).on "click", "a[href^='/']", (event) ->
  href = $(event.currentTarget).attr('href')

  if $(event.currentTarget).hasClass "unmanaged"
    return

  # Allow shift+click for new tabs, etc.
  if !event.altKey && !event.ctrlKey && !event.metaKey && !event.shiftKey
    event.preventDefault()

    # Remove leading slashes and hash bangs (backward compatablility)
    url = href.replace(/^\//,'').replace('\#\!\/','')

    Backbone.history.navigate url, { trigger: true }

    return false


App.module "Layout", (Layout, App) ->
class App.IndexController
  constructor: ->
    alert "Yeah!"