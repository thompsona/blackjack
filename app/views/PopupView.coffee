class window.PopupView extends Backbone.View

  initialize: (message)->
    console.log('popupview init ' , message)
    @render(message)

  render: (message)->
    alert(message)
