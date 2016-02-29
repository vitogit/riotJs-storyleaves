function Resource() {
    this.name =  ''
    this.card = {}
}

Resource.prototype.set = function set(card) {
  this.card = card
}
