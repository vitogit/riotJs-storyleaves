function Resource() {
    this.name =  ''
    this.card = {}
}

Resource.prototype.set = function set(card) {
  this.card = card
}

Resource.prototype.unset = function unset() {
  this.card = {}
}
