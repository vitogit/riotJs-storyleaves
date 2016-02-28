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
      cards = [{number:1, text:'card1'},
              {number:2, text:'card2'}
      ]
      tag.loadArea('game', cards)
      expect(tag.areas.game.cards).to.have.lengthOf(2)
    })

    it('remove 2 cards to game area', function() {
      cards = [{number:1, text:'card1'},
              {number:2, text:'card2'}
      ]
      tag.loadArea('game', cards)
      tag.unloadArea('game', cards)
      expect(tag.areas.game.cards).to.have.lengthOf(0)
    })

    it('moves 2 cards from game area to hand area', function() {
      cards = [{number:1, text:'card1'},
              {number:2, text:'card2'}
      ]
      tag.loadArea('game', cards)
      tag.moveCardsFromTo('game','hand', cards)
      expect(tag.areas.game.cards).to.have.lengthOf(0)
      expect(tag.areas.hand.cards).to.have.lengthOf(2)
    })

    it('has phases', function() {
      expect(tag.phases).to.exist;
      expect(tag.phases).to.be.an('array');
    })

    it('has 5 phases', function() {
      expect(tag.phases).to.have.lengthOf(5);
    })

    it('has a current phase', function() {
      expect(tag.currentPhase).to.exist;
    })

    it('moves to the next phase', function() {
      tag.nextPhase()
      expect(tag.currentPhase).to.be.eq(1);
    })

    it('moves to phase 0 after nextPhase() the lastone', function() {
      tag.currentPhase = tag.phases.length
      tag.nextPhase()
      expect(tag.currentPhase).to.be.eq(0);
    })
  })

  context('Mount with params', function() {
    beforeEach(function() {
      var html = document.createElement('game')
      document.body.appendChild(html)
    });
  })

  context('Mechanics', function() {
    beforeEach(function() {
      var html = document.createElement('game')
      document.body.appendChild(html)
      tag = riot.mount('game')[0]
    });

    context('Phase 0', function() {
      before(function() {
        tag.currentPhase = 0
      });

      it('has an actionBox children tag ', function() {
        expect(tag.tags.actionbox).to.exist
      })

      it('has a chat children tag ', function() {
        expect(tag.tags.chat).to.exist
      })

      it('has 40 cards in the main place ', function() {
        expect(tag.areas.main.cards).to.have.lengthOf(40)
      })

      // it('has 1 action: initGame ', function() {
      //   var actionNames = Object.keys(tag.tags.actionbox.actions)
      //   expect(actionNames).to.include('initGame')
      // })

      it('execute initGame: moving 5 cards from main place to hand', function() {
        var actionName = 'initGame'
        tag.doAction(actionName)
        //expect(tag.areas.main.cards).to.have.lengthOf(tag.areas.main.cards.length-5)

      })
      //
      // it('choose a first character ', function() {
      //
      // })
      //
      // it('choose an allied character ', function() {
      //
      // })
      //
      // it('choose a enemy character ', function() {
      //
      // })
    })
  })

  afterEach(function() {
    //tag.unmount()
  })
})
