<action_box>
    <div class="action" each={action in actions} onclick='{doAction}'>
      {action.label}
    </div>

  <script>

    this.actions = []
    var self = this
    //opts.actions || [{name:'initGame', label:'Comenzar juego'}]
    
    this.doAction = function(e) {
      RiotControl.trigger('game_action_run', e.item.action.name)
    }
    
    this.on('mount', function() {
      this.actions = opts.actions || RiotControl.trigger('action_init')
    })   
    
    RiotControl.on('actions_changed', function(actions) {
      self.actions = actions
      self.update()
    })    
       
  </script>
</action_box>
