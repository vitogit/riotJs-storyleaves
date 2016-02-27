describe('Deck spec', function() {

  context('default', function() {
    beforeEach(function() {
      deck = new Deck()
    });

    it('exist a deck ', function() {
      expect(deck).to.exist
    })

    it('has a cards', function() {
      expect(deck.cards).to.exist
      expect(deck.cards).to.be.an('array')
    })

    it('load 2 new cards to the deck', function() {
      cards = [{number:1, text:'card1'},
              {number:2, text:'card2'}
      ]
      deck.load(cards)
      expect(deck.cards).to.have.lengthOf(2)
    })

    it('unload 2 cards from the deck', function() {
      cards = [{number:1, text:'card1'},
              {number:2, text:'card2'}
      ]
      deck.load(cards)
      expect(deck.cards).to.have.lengthOf(2)
      deck.unload(cards)
      expect(deck.cards).to.have.lengthOf(0)
    })

  })

})
