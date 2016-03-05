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
    var cardText = arrayCards[i]
    var cardType =''
    var typeList = ['Personaje', 'Lugar', 'Objeto', 'Aspecto', 'Detalle']
    typeList.forEach(function(type){
      if (cardText.indexOf(type) > -1) {
        cardType = type
      }
    })
  	cards.push({number:i+1, text: cardText, type:cardType});
  }
  return cards
}

Deck.prototype.findByType = function findByType(varType) {
  var mapTypeCards = {};
  for (var i=0; i< this.cards.length ; i++) {
    var cardType = this.cards[i].type

    if (!mapTypeCards[cardType]) {
      mapTypeCards[cardType] = []
    }
    mapTypeCards[cardType].push(this.cards[i])
  }
  var newDeck = new Deck()
  newDeck.cards = mapTypeCards[varType]
  return newDeck
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
  cards = [].concat(cards) //to accept single card or card arrays
  for(var i=0, len=cards.length; i < len; i++) {
    var card = cards[i]
    this.cards = this.cards.filter(function (el) {
      return el.number !== card.number
    })
  }
}
