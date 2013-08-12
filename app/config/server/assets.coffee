module.exports =
  javascripts:
    head: [
      "vendor/jquery"
    ]

    vendor: [
      "vendor/handlebars"
      "vendor/underscore"
      "vendor/underscore.string"
      "vendor/backbone"
      "vendor/backbone.marionette"
      "vendor/backbone.babysitter"
      "vendor/bootstrap"
    ]

    application: [
      "config/bootstrap"
      "controllers/indexController"
      "models/todo"
      "views/index/list"
      # "models/*"
      "templates"
    ]

  stylesheets:
    application: [
      "application"
    ]

    vendor: [
      # "vendor/bootstrap"
    ]