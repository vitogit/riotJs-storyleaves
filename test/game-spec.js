describe('Game spec', function() {

  context('Mount without params', function() {
    beforeEach(function() {
      var html = document.createElement('game')
      document.body.appendChild(html)
      tag = riot.mount('game')[0]
    });

    it('mounts a game tag', function() {
      expect(tag).to.exist
      expect(tag.isMounted).to.be.true
    })

    it('has 4 areas', function() {
      expect(tag.areas).to.exist
      expect(tag.areas).to.be.an('object')
      expect(Object.keys(tag.areas)).to.have.lengthOf(4)
    })

    it('has areas with decks', function() {
      expect(tag.areas).to.exist
      expect(tag.areas).to.be.an('object')
      for (var area in tag.areas) {
        expect(tag.areas[area]).to.be.an.instanceof(Deck)
      }
    })

    it('adds 2 cards to game area', function() {
      // cards = [{number:1, text:'card1'},
      //         {number:2, text:'card2'}
      // ]
      // tag.loadArea('game', cards)
      // expect(tag.areas.game).to.have.lengthOf(2)
    })

    it('moves 2 cards from game area to hand area', function() {
      // cards = [{number:1, text:'card1'},
      //         {number:2, text:'card2'}
      // ]
      // tag.loadArea('game', cards)
      // tag.moveCardsFromTo('game','hand', cards)
      // expect(tag.areas.game).to.have.lengthOf(0)
      // expect(tag.areas.hand).to.have.lengthOf(2)

    })

  })

  afterEach(function() {
    tag.unmount()
  })
})
