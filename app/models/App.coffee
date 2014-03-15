#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    player = @get "playerHand"
    dealer = @get "dealerHand"
    player.on "win", () -> setTimeout( () -> 
      new PopupView({model: new Backbone.Model, message: "you win!"})
    , 500 )
    player.on "bust", () -> setTimeout( () -> 
      new PopupView("you\'re bust!")
    , 500 )
    player.on "finished", () -> dealer.play()

    dealer.on "finished", () ->
      playerScores = _(player.scores()).filter (score) -> return score <= 21
      dealerScores = _(dealer.scores()).filter (score) -> return score <= 21

      if dealerScores.length is 0 or dealerScores[dealerScores.length - 1] < playerScores[playerScores.length - 1]
        setTimeout( () -> 
          new PopupView('you win!')
        , 500 )

      if dealerScores[dealerScores.length - 1] > playerScores[playerScores.length - 1]
        setTimeout( () -> 
          new PopupView('you lose')
        , 500 )
      if dealerScores[dealerScores.length - 1] is playerScores[playerScores.length - 1]
        setTimeout( () -> 
          new PopupView('push')
        , 500 )