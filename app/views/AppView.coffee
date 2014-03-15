class window.AppView extends Backbone.View

  template: _.template '
    <div class="buttons"><button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <span class="money"></span></div>    
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: -> 
    @render()
    @model.on 'reset', () => @render()
    @model.on 'change', () => @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.money').text(@model.get("money"))
