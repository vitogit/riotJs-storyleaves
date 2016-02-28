function Deck(arrayCards) {
    this.name =  ''
    this.cards = []
    if (arrayCards) {
      this.cards = this.initCards(arrayCards)
    }
}

Deck.prototype.initCards = function initCards(arrayCards) {
  var cards = [];
  for (var i=0; i<arrayCards.length ; i++) {
  	cards.push({number:i+1, text: arrayCards[i]});
  }
  return cards
}

Deck.prototype.topCards = function topCards(numberOfCards) {
  var topCards = [];
  if (this.cards.length >= numberOfCards) {
    for (var i=0; i<numberOfCards ; i++) {
    	topCards.push(this.cards[i]);
    }
    return topCards;
  }
}

Deck.prototype.load = function load(cards) {
  this.cards = this.cards.concat(cards)
}

Deck.prototype.unload = function unload(cards) {
  for(var i=0, len=cards.length; i < len; i++) {
    var card = cards[i]
    this.cards = this.cards.filter(function (el) {
      return el.number !== card.number
    })
  }
}
