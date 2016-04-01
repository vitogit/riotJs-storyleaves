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

    it('has 9 resources', function() {
      expect(tag.resources).to.exist;
      expect(Object.keys(tag.resources)).to.have.lengthOf(9)
    })
    
    it('has enemy_resources_count equal to 3', function() {
      expect(tag.enemy_resources_count).to.exist;
      expect(tag.enemy_resources_count).to.be.eq(3)
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
    
    it('reorganize the decks (move from discard to main)', function() {
      var cards = [{number:1, text:'card1'},
              {number:2, text:'card2'}
      ]
      tag.areas.main.cards = []
      expect(tag.areas.discard.cards).to.have.lengthOf(0);
      tag.loadArea('discard', cards)
      tag.reorganization()
      expect(tag.areas.main.cards).to.have.lengthOf(2);
    })
  })

  context('Mount with params', function() {
    beforeEach(function() {
      var html = document.createElement('game')
      document.body.appendChild(html)
    });
  })

  describe('Mechanics', function() {
    beforeEach(function() {
      var html = document.createElement('game')
      document.body.appendChild(html)
      tag = riot.mount('game')[0]
    });

    context('Phase 0', function() {
      beforeEach(function() {
        tag.currentPhase = 0
      });

      it('has an action_box children tag ', function() {
        expect(tag.tags.action_box).to.exist
      })

      it('has a chat children tag ', function() {
        expect(tag.tags.chat).to.exist
      })

      it('has a info_box children tag ', function() {
        expect(tag.tags.info_box).to.exist
      })

      it('has 38 cards in the main place ', function() {
        expect(tag.areas.main.cards).to.have.lengthOf(38)
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
              if (card.cardType == 'Personaje') {
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

      describe('select the resources', function() {
        beforeEach(function() {
          tag.doAction('selectResources')
        });

        it('select the characters feature', function() {
          mainDeckLength = tag.areas.main.cards.length

          tag.selectCharactersFeatures()
          var characters = ['pj', 'ally', 'enemy']
          characters.forEach(function(character) {
            var characterFeature = character+'_feature'
            expect(tag.resources[characterFeature].card).to.exist
          })
          expect(tag.areas.main.cards).to.have.lengthOf(mainDeckLength-3)
        })

        it('select the characters relationships', function() {
          mainDeckLength = tag.areas.main.cards.length
          tag.selectCharactersRelationships()
          expect(tag.resources.pj_ally_rel.card.text).to.exist
          expect(tag.resources.pj_enemy_rel.card.text).to.exist
          expect(tag.resources.ally_enemy_rel.card.text).to.exist
          expect(tag.areas.main.cards).to.have.lengthOf(mainDeckLength-3)
          //PENDING refactor: is testing multiple behaviours
        })
      })

      describe('select the destiny cards', function() {
        beforeEach(function() {
          tag.doAction('selectDestinyCards')
        });

        it('moves 5 cards from main to hand', function() {
          mainDeckLength = tag.areas.main.cards.length
          tag.selectDestinyCards()
          expect(tag.areas.hand.cards).to.have.lengthOf(5)
          expect(tag.areas.main.cards).to.have.lengthOf(mainDeckLength-5)
        })
      })

      describe('Movements', function() {

        it('run move: pursue goal (and succeed)', function() {
          var myCard = new Card(1,'Aspecto:my card')
          var enemyCard = new Card(5,'Aspecto:enemy card')
          tag.loadArea('hand', [myCard])
          tag.areas.main.cards = [enemyCard]
          // sinon.mock(tag.areas.main).expects("topCard").returns(enemyCard) also could work with a mock
          tag.selectedCard = myCard
          tag.doMove('goal')
          expect(tag.areas.hand.cards).to.have.lengthOf(0)
          expect(tag.characterProgress).to.be.eq(1)
          expect(tag.areas.discard.cards).to.have.lengthOf(2)
          expect(tag.tags.chat.messages).to.have.lengthOf(4)
        })

        it('run move: attack enemy', function() {
          var myCard = {number:1, text:'Aspecto: my card'}
          var enemyResourceCard = {number:5, text:'Aspecto:enemy card'}
          tag.loadArea('hand', [myCard])
          tag.resources.enemy_feature.card = enemyResourceCard
          tag.selectedCard = myCard
          tag.selectedEnemyResource = 'enemy_feature'
          tag.doMove('attack')
          expect(tag.areas.hand.cards).to.have.lengthOf(0)
          expect(tag.resources.enemy_feature.card.text).to.be.undefined
          expect(tag.tags.chat.messages).to.have.lengthOf(1)

        })

        it('run move: wait', function() {
          tag.doMove('wait')
          expect(tag.tags.chat.messages).to.have.lengthOf(3)
        })

        it('run move: sacrifice resource', function() {
          tag.selectedPjResource = 'pj_feature'
          tag.doMove('sacrifice')
          expect(tag.resources.pj_feature.card.text).to.be.undefined
          expect(tag.areas.hand.cards).to.have.lengthOf(2)
          expect(tag.tags.chat.messages).to.have.lengthOf(5)
        })

        it('run move: reverse condition (and lost)', function() {
          var myCard = new Card(10,'Aspecto:my 10card')
          var enemyCard = new Card(5,'Aspecto:enemy 5 card')
          tag.loadArea('hand', [myCard])
          tag.areas.main.cards = [enemyCard]
          tag.selectedCard = myCard
          tag.doMove('reverse')
          expect(tag.areas.hand.cards).to.have.lengthOf(0)
          expect(tag.areas.discard.cards).to.have.lengthOf(2)
          expect(tag.tags.chat.messages).to.have.lengthOf(3)
        })
      })
    })
  })

  afterEach(function() {
    //tag.unmount()
  })
})
