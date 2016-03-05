<game>

  <div class="left col-md-4">
    <info_box resources={this.resources}/>
  </div>
  <div class="right col-md-8">
    <chat/>
    <action_box />
  </div>



  <script>

    this.areas = {'main':new Deck(), 'temp':new Deck(),'game':new Deck(), 'hand':new Deck(), 'discard':new Deck()}
    this.resources = {'pj':new Resource(), 'ally':new Resource(), 'enemy':new Resource(),
                      'pj_feature':new Resource(), 'ally_feature':new Resource(), 'enemy_feature':new Resource(),
                      'pj_ally_rel':new Resource(), 'pj_enemy_rel':new Resource(), 'ally_enemy_rel':new Resource()
                    }
    this.areas.main = new Deck(defaultDeck) //set default deck to the main place

    this.loadArea = function(area, cards) {
      this.areas[area].load(cards)
    }

    this.unloadArea = function(area, cards) {
      this.areas[area].unload(cards)
    }

    this.setResource = function(resourceName, card) {
      this.resources[resourceName].card = card
    }

    this.moveCardsFromTo = function(from, to, cards) {
      this.unloadArea(from, cards)
      this.loadArea(to, cards)
    }

    this.moveFromAreaToResource = function(area, resource, card) {
      this.unloadArea(area, card)
      this.setResource(resource, card)
    }

    this.phases = [ {number:0, description:'Initial phase'},
                    {number:1, description:'first phase'},
                    {number:2, description:'second phase'},
                    {number:3, description:'third phase'},
                    {number:4, description:'fourth phase'}
    ]

    this.currentPhase = 0

    this.nextPhase = function(text, user) {
      this.currentPhase++
      if (this.currentPhase > this.phases.length) {
        this.currentPhase = 0
      }
    }

    this.characterProgress = 0
    this.characterConditions = 0

    this.cardsToActions = function(cards, actionName) {
      var actions = []
      for (var i=0; i< cards.length; i++) {
        actions.push({name:actionName, label:cards[i].number+' '+cards[i].text, data:{card:cards[i]}})
      }
      return actions
    }

    this.chooseCharacter = function(data, resourceName, nextActionName, characterLabel, nextCharacterLabel ) {
      var card = data['card']
      this.moveFromAreaToResource('temp', resourceName ,card)
      var actions = this.cardsToActions(this.areas.temp.cards, nextActionName)
      riot.actionStore.trigger('add_chat', 'El '+characterLabel+' es: '+card.text)
      riot.actionStore.trigger('add_chat', 'Elige a tu '+nextCharacterLabel)
      this.nextActions(actions)
    }

    var self = this

    riot.actionStore.on('run_action', function(actionName, data) {
      self.doAction(actionName, data)
    })

    this.doAction = function(actionName, data) {
      switch(actionName) {
        case 'initGame':
         var mainDeck = this.areas.main
         //mainDeck.shuffle()
         var newDeck = mainDeck.findByType('Personaje')
         var cards = newDeck.topCards(5)
         this.moveCardsFromTo('main', 'temp', cards)
         var actions = this.cardsToActions(cards, 'choosePj')
         riot.actionStore.trigger('add_chat', 'Elige al protagonista')
         this.nextActions(actions)

         break
        case 'choosePj':
          this.chooseCharacter(data, 'pj', 'chooseAlly', 'protagonista', 'aliado' )
          break
        case 'chooseAlly':
          this.chooseCharacter(data, 'ally', 'chooseEnemy', 'aliado', 'enemigo' )
          break
        case 'chooseEnemy':
            this.chooseCharacter(data, 'enemy', 'choosePjFeature', 'enemigo', 'caracteristica del pj' )
            break
        default:
          console.log('default action')
      }
    }

    this.nextActions = function(actions) {
      riot.actionStore.trigger('add_actions', actions)
    }

    this.selectCharactersFeatures = function() {
      var characters = ['pj', 'ally', 'enemy']
      characters.forEach(function(character) {
        var card = self.areas.main.topCard()
        var characterFeature = character+'_feature'
        self.moveFromAreaToResource('main', characterFeature , card)
      })
    }

    this.selectCharactersRelationships = function() {
      var card = self.areas.main.topCard()
      self.moveFromAreaToResource('main', 'pj_ally_rel' , card)

      var card = self.areas.main.topCard()
      self.moveFromAreaToResource('main', 'pj_enemy_rel' , card)

      var card = self.areas.main.topCard()
      self.moveFromAreaToResource('main', 'ally_enemy_rel' , card)
    }

    this.selectDestinyCards = function() {
      var cards = self.areas.main.topCards(5)
      self.moveCardsFromTo('main', 'hand', cards)
    }

    this.doMove = function(moveName, data) {
      switch(moveName) {
        case 'goal':
          var myCard = data['myCard']
          var enemyCard = self.areas.main.topCard()
          if (myCard.number < enemyCard.number) {
            self.characterProgress++
            riot.actionStore.trigger('add_chat', 'Superado, aumenta tu progreso a '+self.characterProgress)
          } else {
            riot.actionStore.trigger('add_chat', 'No superado')
          }
          self.moveCardsFromTo('hand', 'discard', myCard)
          self.moveCardsFromTo('main', 'discard', enemyCard)

          break
        case 'attack':
          var myCard = data['myCard']
          var enemyResource = data['enemyResource']
          var enemyCard = tag.resources[enemyResource].card
          if (myCard.number < enemyCard.number) {
            riot.actionStore.trigger('add_chat', 'Triunfas. Tu carta: '+myCard.text+' supera a la carta de tu enemigo: '+enemyCard.text)
            tag.resources[enemyResource].unset()
          } else {
            riot.actionStore.trigger('add_chat', 'Pierdes. Tu carta: '+myCard.text+' pierde ante la carta de tu enemigo: '+enemyCard.text)
          }
          self.moveCardsFromTo('hand', 'discard', myCard)

          break
        case 'wait':
          var enemyCard = self.areas.main.topCard()
          riot.actionStore.trigger('add_chat', 'Esperas, pero tu enemigo intenta algo contra ti: '+enemyCard.text)
          break
        case 'sacrifice':
          var resourceName = data['resourceName']
          var cards = self.areas.main.topCards(2)
          self.moveCardsFromTo('main', 'hand', cards)
          riot.actionStore.trigger('add_chat', 'Sacrificas tu recurso: '+tag.resources[resourceName].card.text)
          riot.actionStore.trigger('add_chat', 'Explica como se pierde para siempre')
          tag.resources[resourceName].unset()
          break
        case 'reverse':
          var myCard = data['myCard']
          var enemyCard = self.areas.main.topCard()
          if (myCard.number < enemyCard.number) {
            riot.actionStore.trigger('add_chat', 'Logras revertir la situación')
          } else {
            riot.actionStore.trigger('add_chat', 'No logras revertir la situación, y obtienes otra condición')
            self.characterConditions++

          }
          self.moveCardsFromTo('hand', 'discard', myCard)
          self.moveCardsFromTo('main', 'discard', enemyCard)
          break
        default:
          console.log('default move')
          break
      }
    }
  </script>
</game>
