class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @model.on 'change', => @render
    
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.html @template @model.toJSON()
    if @model.get 'revealed'
      @$el.addClass  @model.get('suitName') + @model.get('rankName')
    else
      @$el.addClass 'covered'
