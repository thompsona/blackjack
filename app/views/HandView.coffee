class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  # template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'
  template: (obj) -> 
    temp = $('#hand').html()
    return Mustache.render(temp, obj)

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    obj = {
      isDealer: @collection.isDealer,
      scores: @collection.scores().join(", ")
    }
    str = @template(obj)
    console.log('html is', str)
    @$el.html( str )
    # @$el.html.slice(0, html.length-1);
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    # @$('.score').text @collection.scores()[0]
    # if @collection.scores().length > 1
    #   @$('.score').append ", #{@collection.scores()[1]}"
