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
    var card = new Card(i+1,cardText, cardType)
  	cards.push(card)
  }
  return cards
}

Deck.prototype.findByType = function findByType(varType) {
  var mapTypeCards = {};
  for (var i=0; i< this.cards.length ; i++) {
    var cardType = this.cards[i].cardType

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

Deck.prototype.topCard = function topCard() {
  cards = this.topCards(1)
  if (cards && cards.length >0) {
    return cards[0]
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

Deck.prototype.shuffle = function(seed){
		Math.seedrandom(seed)
    var counter = this.cards.length, temp, index

    while (counter > 0) {
        index = Math.floor(Math.random() * counter)
        counter--
        temp = this.cards[counter]
        this.cards[counter] = this.cards[index]
        this.cards[index] = temp
    }
    return this.cards;
}
