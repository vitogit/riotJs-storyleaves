<game>
  <chat/>
  <action_box/>

  <script>

    this.areas = {'main':new Deck(), 'temp':new Deck(),'game':new Deck(), 'hand':new Deck(), 'discard':new Deck()}
    this.resources = {'pj':new Resource(), 'ally':new Resource(), 'enemy':new Resource()
                      // 'pj_feature':new Resource(), 'ally_feature':new Resource(), 'enemy_feature':new Resource(),
                      // 'pj_ally_rel':new Resource(), 'pj_enemy_rel':new Resource(), 'ally_enemy_rel':new Resource()
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

    var self = this
  
    RiotControl.on('game_action_run', function(actionName) {
      self.doAction(actionName)
    })  
    
    this.doAction = function(actionName, data) {
      console.log('actionname_____'+actionName)
      switch(actionName) {
        case 'initGame':
         var mainDeck = this.areas.main
         //mainDeck.shuffle()
         var cards = mainDeck.topCards(5)
         this.moveCardsFromTo('main', 'temp', cards)
         this.nextActions([{name:'choosePj', label:'Elige el protagonista'}])
         break
        case 'initGame2':
          console.log(' action2')
        case 'initGame3':
          console.log(' action2')
        default:
          console.log('default action')
      }
    }

    this.nextActions = function(actions) {
      //this.tags.action_box.actions = actions
      RiotControl.trigger('actions_add',actions)
    }

  </script>
</game>
