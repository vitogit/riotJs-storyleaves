function Deck() {
    this.name =  ''
    this.cards = []
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
