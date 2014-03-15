#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'money', 200
    @bet()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @setUpListeners()
  
  setUpListeners: ->
    player = @get "playerHand"
    dealer = @get "dealerHand"
    self = @
    player.on "win", () -> setTimeout( () ->
      alert("you win!")
      self.reDeal()
    , 1000 )
    player.on "bust", () -> setTimeout( () ->
      alert("you\'re bust!")
      self.reDeal()
    , 1000 )
    player.on "finished", () -> dealer.play()

    dealer.on "finished", () ->
      playerScores = _(player.scores()).filter (score) -> return score <= 21
      dealerScores = _(dealer.scores()).filter (score) -> return score <= 21

      if dealerScores.length is 0 or dealerScores[dealerScores.length - 1] < playerScores[playerScores.length - 1]
        setTimeout( () ->
          alert('you win!')
          self.set('money', self.get('money') + 2 * self.get('bet'))
          self.reDeal()
        , 1000 )

      if dealerScores[dealerScores.length - 1] > playerScores[playerScores.length - 1]
        setTimeout( () ->
          alert('you lose')
          self.reDeal()
        , 1000 )
      if dealerScores[dealerScores.length - 1] is playerScores[playerScores.length - 1]
        setTimeout( () ->
          alert('push')
          self.set('money', self.get('money') + self.get('bet'))
          self.reDeal()
        , 1000 )

  reDeal: ->
    deck = @get 'deck'
    # @get('playerHand').reset()
    # @get('dealerHand').reset()
    @bet()
    @set 'playerHand', deck.dealPlayer()
    @get('playerHand').trigger "add"
    @set 'dealerHand', deck.dealDealer()
    @get('dealerHand').trigger "add"
    @setUpListeners()
    @trigger "reset"

  bet: ->
    @set('bet', 0)
    amount = parseInt(prompt("How much monies"))
    console.log(amount, @get 'money')
    if( amount > @get 'money')
      @bet()
    else
      @set('money', @get('money') - amount)
      @set('bet', amount)
      console.log(@get 'money')

