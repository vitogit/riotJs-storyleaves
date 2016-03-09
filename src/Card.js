function Card(number, text, type) {
    this.number =  number
    this.text = text
    this.cardType = type
}

Card.prototype.fullText = function fullText() {
  return this.number+' - '+this.text
}
