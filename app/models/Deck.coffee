class window.Deck extends Backbone.Collection

  model: Card

  initialize: ->
    @add _(_.range(0, 52)).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)
    @on 'remove', () =>
      if @length < 1
        console.log('deck reset')
        @initialize()

  dealPlayer: -> 
    new Hand [ @pop(), @pop() ], @, no

  dealDealer: -> new Hand [ @pop().flip(), @pop() ], @, yes
