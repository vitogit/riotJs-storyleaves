function ActionStore() {
  riot.observable(this) // Riot provides our event emitter.
  
  var self = this

  self.actions = [ 
    { name: 'initGame', label: 'Comenzar juego' }
  ]

  self.on('add_actions', function(newActions) {
    self.actions = newActions 
    self.trigger('update_actions', self.actions)        
  })

  self.on('init_actions', function() {
    self.trigger('update_actions', self.actions)
  })
  // 
  
}

riot.actionStore = new ActionStore()
