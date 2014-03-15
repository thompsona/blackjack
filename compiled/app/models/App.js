// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.App = (function(_super) {
    __extends(App, _super);

    function App() {
      _ref = App.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    App.prototype.initialize = function() {
      var deck;
      this.set('deck', deck = new Deck());
      this.set('money', 200);
      this.bet();
      this.set('playerHand', deck.dealPlayer());
      this.set('dealerHand', deck.dealDealer());
      return this.setUpListeners();
    };

    App.prototype.setUpListeners = function() {
      var dealer, player, self;
      player = this.get("playerHand");
      dealer = this.get("dealerHand");
      self = this;
      player.on("win", function() {
        return setTimeout(function() {
          alert("you win!");
          return self.reDeal();
        }, 1000);
      });
      player.on("bust", function() {
        return setTimeout(function() {
          alert("you\'re bust!");
          return self.reDeal();
        }, 1000);
      });
      player.on("finished", function() {
        return dealer.play();
      });
      return dealer.on("finished", function() {
        var dealerScores, playerScores;
        playerScores = _(player.scores()).filter(function(score) {
          return score <= 21;
        });
        dealerScores = _(dealer.scores()).filter(function(score) {
          return score <= 21;
        });
        if (dealerScores.length === 0 || dealerScores[dealerScores.length - 1] < playerScores[playerScores.length - 1]) {
          setTimeout(function() {
            alert('you win!');
            self.set('money', self.get('money') + 2 * self.get('bet'));
            return self.reDeal();
          }, 1000);
        }
        if (dealerScores[dealerScores.length - 1] > playerScores[playerScores.length - 1]) {
          setTimeout(function() {
            alert('you lose');
            return self.reDeal();
          }, 1000);
        }
        if (dealerScores[dealerScores.length - 1] === playerScores[playerScores.length - 1]) {
          return setTimeout(function() {
            alert('push');
            self.set('money', self.get('money') + self.get('bet'));
            return self.reDeal();
          }, 1000);
        }
      });
    };

    App.prototype.reDeal = function() {
      var deck;
      deck = this.get('deck');
      this.bet();
      this.set('playerHand', deck.dealPlayer());
      this.get('playerHand').trigger("add");
      this.set('dealerHand', deck.dealDealer());
      this.get('dealerHand').trigger("add");
      this.setUpListeners();
      return this.trigger("reset");
    };

    App.prototype.bet = function() {
      var amount;
      this.set('bet', 0);
      amount = parseInt(prompt("How much monies"));
      console.log(amount, this.get('money'));
      if (amount > this.get('money')) {
        return this.bet();
      } else {
        this.set('money', this.get('money') - amount);
        this.set('bet', amount);
        return console.log(this.get('money'));
      }
    };

    return App;

  })(Backbone.Model);

}).call(this);

/*
//@ sourceMappingURL=App.map
*/
