<game>

  <div class="left col-md-3">
    <info_box resources={this.resources}/>
  </div>
  <div class="center col-md-6">
    <chat/>
    <action_box />
  </div>

  <div class="right col-md-3">
    <info_right_box/>
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
    this.currentAction = ''

    this.currentPhase = 0

    this.nextPhase = function(text, user) {
      this.currentPhase++
      if (this.currentPhase > this.phases.length) {
        this.currentPhase = 0
      }
    }

    this.characterProgress = 0
    this.characterConditions = 0
    this.moveActions = [new Action('action_goal', 'Perseguir objetivo'), new Action('action_attack', 'Atacar enemigo'), new Action('action_wait', 'Esperar'),
                        new Action('action_sacrifice', 'Sacrificar recurso'), new Action('action_reverse', 'Revertir situación')]

    this.enemyActions = [new Action('action_enemy_turn', 'Turno del enemigo')]
    this.respondToEnemy = [new Action('action_pj_respond', 'Responder con mejor carta'),
                           new Action('action_pj_sacrifice', 'Sacrificar recurso de mejor valor'),
                           new Action('action_pj_luck', 'Sacar carta del mazo'),
                         new Action('action_pj_condition', 'Asumir condicion')]

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
      if (nextCharacterLabel && nextCharacterLabel != '') {
        riot.actionStore.trigger('add_chat', 'Elige a tu '+nextCharacterLabel)
        this.nextActions(actions)
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

    this.resetState = function() {
      this.nextActions(this.moveActions)
      self.currentAction = ''
      this.selectedCard = {}
      this.selectedEnemyResource = ''
      riot.actionStore.trigger('update_hand_info', this.areas.hand.cards)
      riot.actionStore.trigger('update_resource_info', this.resources)
    }

    this.selectedCard = {}
    this.selectedEnemyResource = ''
    this.selectedPjResource = ''
    var self = this

    riot.actionStore.on('run_action', function(actionName, data) {
      self.doAction(actionName, data)
    })

    riot.actionStore.on('enemy_resource_selected', function(resourceName) {
      if (self.currentAction == 'action_attack') {
        self.selectedEnemyResource = resourceName
        riot.actionStore.trigger('add_chat', 'Recurso enemigo seleccionado.')
      }
    })

    riot.actionStore.on('pj_resource_selected', function(resourceName) {
      if (self.currentAction == 'action_sacrifice') {
        self.selectedPjResource = resourceName
        self.doMove('sacrifice')
      }
    })

    riot.actionStore.on('card_selected', function(card) {
      self.selectedCard = card
      switch(self.currentAction) {
        case 'action_goal':
          self.doMove('goal')
          break
        case 'action_attack':
          if (self.selectedEnemyResource) {
            self.doMove('attack')
          } else {
            riot.actionStore.trigger('add_chat', 'Selecciona el recurso enemigo primero y luego la carta.')
          }

          break
        default:
          console.log('default selectedcard')
      }
    })

    this.doAction = function(actionName, data) {
      switch(actionName) {
        case 'initGame':
         var mainDeck = this.areas.main
         mainDeck.shuffle()
         var newDeck = mainDeck.findByType('Personaje')
         var cards = newDeck.topCards(5)
         this.moveCardsFromTo('main', 'temp', cards)
         var actions = this.cardsToActions(cards, 'choosePj')
         riot.actionStore.trigger('add_chat', 'Elige al protagonista')
         this.nextActions(actions)

         break
        case 'choosePj':
          this.chooseCharacter(data, 'pj', 'chooseAlly', 'protagonista', 'aliado' )
          riot.actionStore.trigger('update_resource_info', this.resources)
          break
        case 'chooseAlly':
          this.chooseCharacter(data, 'ally', 'chooseEnemy', 'aliado', 'enemigo' )
          riot.actionStore.trigger('update_resource_info', this.resources)
          break
        case 'chooseEnemy':
          this.chooseCharacter(data, 'enemy', 'choosePjFeature', 'enemigo')
          riot.actionStore.trigger('update_resource_info', this.resources)
          riot.actionStore.trigger('add_chat', 'A continuacion se generararn las relaciones y caracteristicas de los personajes')
          this.doAction('generateResources')
          break
        case 'generateResources':
          this.selectCharactersFeatures()
          this.selectCharactersRelationships()
          riot.actionStore.trigger('update_resource_info', this.resources)
          riot.actionStore.trigger('add_chat', 'Elige nombres para los personajes y escribe una breve historia sobre el objetivo del protagonista y como el antagonista lo quiere detener.')
          riot.actionStore.trigger('add_chat', 'Utiliza las caracteristicas y relaciones de los personajes en la historia.')
          this.nextActions([{name:'chooseDestinyCards', label:'Tomar cartas de destino.'}])
        case 'chooseDestinyCards':
          riot.actionStore.trigger('add_chat', 'Ahora tienes 5 cartas de destino. Estaran en tu mano y las podras usar a lo largo del juego.')
          this.selectDestinyCards()
          riot.actionStore.trigger('update_hand_info', this.areas.hand.cards)
          this.nextActions(this.moveActions)
          break
        case 'action_goal':
          riot.actionStore.trigger('add_chat', 'Elige la carta de tu mano, y escribe como persigues tu objetivo con ella. Deja la historia abierta porque el enemigo puede detenerte.')
          self.currentAction = 'action_goal'
          this.nextActions([])
          break
        case 'action_attack':
          riot.actionStore.trigger('add_chat', 'Elige un recurso de tu enemigo que quieres atacar y una carta de tu mano (debe ser menor al recurso).')
          riot.actionStore.trigger('add_chat', 'Escribe como atacas ese recurso y como afecta a tu enemigo.')
          self.currentAction = 'action_attack'
          this.nextActions([])
          break
        case 'action_wait':
          riot.actionStore.trigger('add_chat', 'Esperas. Obtienes una nueva carta en tu mano pero tu enemigo ataca directamente')
          self.currentAction = 'action_wait'
          self.doMove('wait')
          this.nextActions(this.moveActions)
          break
        case 'action_sacrifice':
          riot.actionStore.trigger('add_chat', 'Elige el recurso que quieres sacrificar y escribe como se pierde para siempre. Gracias a esto obtendras dos cartas.')
          self.currentAction = 'action_sacrifice'
          this.nextActions([])
          break
        case 'action_enemy_turn':
          riot.actionStore.trigger('add_chat', 'Turno enemigo')

          break
        default:
          console.log('default action')
      }
    }

    this.doMove = function(moveName, data) {
      switch(moveName) {
        case 'goal':
          var myCard = self.selectedCard
          var enemyCard = self.areas.main.topCard()
          riot.actionStore.trigger('add_chat', 'La carta del enemigo es '+enemyCard.fullText())
          riot.actionStore.trigger('add_chat', 'Tu carta es '+myCard.fullText())

          if (myCard.number < enemyCard.number) {
            self.characterProgress++
            riot.actionStore.trigger('add_chat', 'Superado, tu progreso aumenta a '+self.characterProgress)
            riot.actionStore.trigger('add_chat', 'Escribe como avanzas hacia tu objetivo utilizando la carta como inspiración.')
            riot.actionStore.trigger('update_characterProgress', self.characterProgress)

          } else {
            riot.actionStore.trigger('add_chat', 'No superado')
          }
          self.moveCardsFromTo('hand', 'discard', myCard)
          self.moveCardsFromTo('main', 'discard', enemyCard)

          self.resetState()
          break
        case 'attack':
          var myCard = self.selectedCard
          var enemyResource = self.selectedEnemyResource
          var enemyCard = self.resources[enemyResource].card
          if (myCard.number < enemyCard.number) {
            riot.actionStore.trigger('add_chat', 'Triunfas. Tu carta: '+myCard.text+' supera a la carta de tu enemigo: '+enemyCard.text)
            self.resources[enemyResource].unset()
          } else {
            riot.actionStore.trigger('add_chat', 'Pierdes. Tu carta: '+myCard.text+' pierde ante la carta de tu enemigo: '+enemyCard.text)
          }
          self.moveCardsFromTo('hand', 'discard', myCard)
          self.resetState()
          break
        case 'wait':
          var newCard = self.areas.main.topCard()
          self.moveCardsFromTo('main', 'hand', newCard)
          var enemyCard = self.areas.main.topCard()
          self.moveCardsFromTo('main', 'discard', enemyCard)

          self.characterConditions++
          riot.actionStore.trigger('update_characterConditions', self.characterConditions)

          riot.actionStore.trigger('add_chat', 'Tu enemigo te ataca directamente usando: '+enemyCard.text)
          riot.actionStore.trigger('add_chat', 'Escribe una nueva condicion para tu personaje. Tus condiciones aumentan a: '+self.characterConditions)

          self.resetState()
          break
        case 'sacrifice':
          var resourceName = self.selectedPjResource
          var cards = self.areas.main.topCards(2)
          self.moveCardsFromTo('main', 'hand', cards)
          riot.actionStore.trigger('add_chat', 'Sacrificas tu recurso: '+self.resources[resourceName].card.text)
          riot.actionStore.trigger('add_chat', 'Explica como se pierde para siempre')
          self.resources[resourceName].unset()
          self.resetState()
          self.doAction('action_enemy_turn')

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
