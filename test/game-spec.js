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

    it('has 5 areas', function() {
      expect(tag.areas).to.exist
      expect(tag.areas).to.be.an('object')
      expect(Object.keys(tag.areas)).to.have.lengthOf(5)
    })

    it('has areas with decks', function() {
      expect(tag.areas).to.exist
      expect(tag.areas).to.be.an('object')
      for (var area in tag.areas) {
        expect(tag.areas[area]).to.be.an.instanceof(Deck)
      }
    })

    it('has resources', function() {
      expect(tag.resources).to.exist;
      expect(tag.resources).to.be.an('object');
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
      expect(tag.areas.game.cards).to.have.lengthOf(2)
      tag.unloadArea('game', cards)
      expect(tag.areas.game.cards).to.have.lengthOf(0)
    })

    it('moves 2 cards from game area to hand area', function() {
      var cards = [{number:1, text:'card1'},
              {number:2, text:'card2'}
      ]
      tag.loadArea('game', cards)
      tag.moveCardsFromTo('game','hand', cards)
      expect(tag.areas.game.cards).to.have.lengthOf(0)
      expect(tag.areas.hand.cards).to.have.lengthOf(2)
    })


    it('moves a specific card from temp area to resource ', function() {
      var cards = [{number:1, text:'card1'},
              {number:2, text:'card2'}
      ]
      tag.loadArea('temp', cards)
      tag.moveFromAreaToResource('temp','pj',cards[0])
      expect(tag.resources.pj.card.number).to.be.eq(1)
      expect(tag.areas.temp.cards).to.have.lengthOf(1)
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

      it('has an action_box children tag ', function() {
        expect(tag.tags.action_box).to.exist
      })

      it('has a chat children tag ', function() {
        expect(tag.tags.chat).to.exist
      })

      it('has 40 cards in the main place ', function() {
        expect(tag.areas.main.cards).to.have.lengthOf(40)
      })

      context('execute initGame', function() {
        beforeEach(function() {
          mainDeckLength = tag.areas.main.cards.length
          tag.doAction('initGame')
        });

        it('moves 5 cards from main place to temp', function() {
          expect(tag.areas.main.cards).to.have.lengthOf(mainDeckLength-5)
          expect(tag.areas.temp.cards).to.have.lengthOf(5)
        })

        it('return 5 character cards', function() {
          var cardCounter = 0
          tag.areas.temp.cards.forEach(function(card){
              if (card.type == 'Personaje') {
                cardCounter++
              }
          })
          expect(cardCounter).to.be.eq(5)
        })

        it('changes the currentActions showing the 5 cards', function() {
          expect(tag.tags.action_box.current_actions).to.have.lengthOf(5)
        })

        it('sends a chat message', function() {
          expect(tag.tags.chat.messages).to.have.lengthOf(1)
        })
      })


      it('choose a first character ', function() {
        // var cards = tag.areas.main.topCards(5)
        // tag.moveCardsFromTo('main', 'temp', cards)
        // var card = tag.areas.temp.cards[0]
        // tag.doAction('choosePj')
        // expect(tag.resources.pj.card).to.be.eq(card)
      })


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
