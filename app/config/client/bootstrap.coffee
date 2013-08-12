_.mixin _.str.exports()
# _.extend Backbone.Model.prototype, Backbone.Validation.mixin

App = window.App = new Backbone.Marionette.Application
  root: "/"

App.addRegions
  main: "#main"

Backbone.Marionette.Renderer.render = (template, data) ->
  # data = _.extend data,
  #   _t: (val) -> window.gettext val
  #   format: true

  JST[template] data

App.on "initialize:after", ->
  location = "/"

  unless "history" of window and "pushState" of window.history
    location = window.location.pathname

  Backbone.history.start
    pushState: true
    root: location

  unless "history" of window and "pushState" of window.history
    location = window.location

    if location.pathname.substr(1) isnt location.hash.substr(1)
      Backbone.history.navigate location.pathname, trigger: true

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