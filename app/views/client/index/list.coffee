App.module "Index.Views", (Views, App, Backbone) ->
  class Views.ItemView extends Backbone.Marionette.ItemView
    template: "index/_item"
    tagName: "li"

    events:
      "click .toggle": "toggleCompleted"
      "dblclick label": "edit"
      "click .destroy": "clear"
      "keypress .edit": "updateOnEnter"
      "blur .edit": "close"

    ui:
      "input": "input.edit"

    initialize: ->
      @listenTo @model, "change", @render

    toggleCompleted: ->
      @model.toggle()

    edit: ->
      @$el.addClass "editing"
      @ui.input.focus()

    close: ->
      @updateModel()
      @$el.removeClass "editing"

    updateModel: ->
      trimmedValue = @ui.input.val().trim()
      @ui.input.val trimmedValue

      if trimmedValue and @model.get("title") isnt trimmedValue
        @model.set
          title: trimmedValue

        @model.save()

    updateOnEnter: (e) ->
      if e.which is 13
        @updateModel()
        e.preventDefault()

    serializeData: ->
      data =
        model: @model.attributes

      data

  class Views.ListView extends Backbone.Marionette.CompositeView
    template: "index/index"
    itemView: Views.ItemView

    events:
      "keypress #new-todo": "createOnEnter"

    appendHtml: (collectionView, itemView, index) ->
      collectionView.$("#todo-list").append itemView.$el

    onBeforeRender: ->
      $("#new-todo").on "keypress", @createOnEnter

    onClosed: ->
      $("#new-todo").off "keypress"

    createOnEnter: (e) =>
      trimmedValue = $("input#new-todo").val().trim()
      return if e.which isnt 13 or not trimmedValue

      @collection.create
        title: trimmedValue
