class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    @canHit = true

  hit: -> 
    if @canHit
      @add(@deck.pop()).last()
      if @scores().length is 1 and @scores()[0] > 21
        @canHit = false
        @trigger "bust"
      if @scores().length is 1 and @scores()[0] is 21
        @stand()


  stand: ->
    if @canHit
      @canHit = false
      @trigger "finished"

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      return memo + if card.get('value') is 1 then 1 else 0
    , 0
    score = @reduce (score, card) ->
      return score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce and (score + 10 <= 21) then [score, score + 10] else [score]

  play: ->
    @hit()
    @first().flip()
    @trigger "finished"