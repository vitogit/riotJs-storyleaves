describe('Deck spec', function() {

  context('default', function() {
    beforeEach(function() {
      deck = new Deck()
    })

    it('exist a deck ', function() {
      expect(deck).to.exist
    })

    it('has cards', function() {
      expect(deck.cards).to.exist
      expect(deck.cards).to.be.an('array')
    })

    it('get the top 2 cards', function() {
      var cards = [{number:1, text:'card1'},
              {number:2, text:'card2'},
              {number:3, text:'card3'}
      ]
      deck.load(cards)
      var topCards = deck.topCards(2)
      expect(topCards).to.have.lengthOf(2)

      var card1 = JSON.stringify(topCards[0])
      var card2 = JSON.stringify(topCards[1])
      expect(card1).to.be.eq('{"number":1,"text":"card1"}')
      expect(card2).to.be.eq('{"number":2,"text":"card2"}')
    })

    it('get top card', function() {
      var cards = [{number:1, text:'card1'},
              {number:2, text:'card2'},
              {number:3, text:'card3'}
      ]
      deck.load(cards)
      var topCard = deck.topCard()
      expect(topCard).to.be.eq(cards[0])
    })
    
    context('There are no cards', function() { 
      it('not break when trying to get top 2 cards', function() {
        var topCards = deck.topCards(2)
        expect(topCards).to.be.undefined
      })       
      it('not break when trying to get top card', function() {
        var topCard = deck.topCard()
        expect(topCard).to.be.undefined
      })    
    }) 
    
    it('load a single card to the deck', function() {
      card = {number:1, text:'card1'}
      deck.load(card)
      expect(deck.cards).to.have.lengthOf(1)
    })

    it('unload a single card from the deck', function() {
      card = {number:1, text:'card1'}
      deck.load(card)
      expect(deck.cards).to.have.lengthOf(1)
      deck.unload(card)
      expect(deck.cards).to.have.lengthOf(0)
    })

    it('load 2 new cards to the deck', function() {
      cards = [{number:1, text:'card1'},
              {number:2, text:'card2'}
      ]
      deck.load(cards)
      expect(deck.cards).to.have.lengthOf(2)
    })

    it('unload 2 cards from the deck', function() {
      var cards = [{number:1, text:'card1'},
              {number:2, text:'card2'}
      ]
      deck.load(cards)
      expect(deck.cards).to.have.lengthOf(2)
      deck.unload(cards)
      expect(deck.cards).to.have.lengthOf(0)
    })

    // it('shuffle the deck', function() {
    //   var cards = [{number:1, text:'card1'},
    //           {number:2, text:'card2'},
    //           {number:3, text:'card3'}
    //   ]
    //   deck.load(cards)
    //   deck.shuffle()
    //   var shuffleCards = [{number:3, text:'card3'},
    //           {number:2, text:'card2'}
    //           {number:1, text:'card1'}
    //   ]
    //   expect(deck.cards).to.be.eql(shuffleCards)
    // })

  })

  context('with params', function() {
    it('can receive a card array', function() {
      var cardArray = ['card1', 'card2']
      deck = new Deck(cardArray)
      expect(deck.cards).to.have.lengthOf(2)
    })

    it('transform an arrayCards to Cards(object)', function() {
      var cardArray = ['Personaje:card1', 'Lugar:card2']
      var deck = new Deck(cardArray)
      expect(deck.cards[0].number).to.be.eq(1)
      expect(deck.cards[1].number).to.be.eq(2)
      expect(deck.cards[0].text).to.be.eq(cardArray[0])
      expect(deck.cards[1].text).to.be.eq(cardArray[1])
      expect(deck.cards[0].type).to.be.eq('Personaje')
      expect(deck.cards[1].type).to.be.eq('Lugar')
    })

    it('select card by type', function() {
      var cardArray = ['Personaje:card1', 'Lugar:card2']
      var deck = new Deck(cardArray)
      var newDeck = deck.findByType('Personaje')
      expect(newDeck.cards).to.have.lengthOf(1)
      expect(newDeck.cards[0].text).to.be.eq(cardArray[0])
    })
  })

})
