<action_box>
    <div class="action" each={action in current_actions} onclick='{runAction}'>
      {action.label}
    </div>

  <script>

    this.current_actions = []
    var self = this
  
    this.runAction = function(e) {
      RiotControl.trigger('run_action', e.item.action.name)
    }
    
    this.on('mount', function() {
      RiotControl.trigger('init_actions')
    })   
    
    RiotControl.on('update_actions', function(actions) {
      self.current_actions = actions
      self.update()
    })    
       
  </script>
</action_box>
