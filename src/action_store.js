function ActionStore() {
  riot.observable(this) // Riot provides our event emitter.
  
  var self = this

  self.actions = [ 
    { name: 'initGame', label: 'Comenzar juego' }
  ]

  self.on('actions_add', function(newActions) {
    self.actions = newActions 
    self.trigger('actions_changed', self.actions)        
  })
  
  self.on('action_init', function() {
    self.trigger('actions_changed', self.actions)
  })

}
