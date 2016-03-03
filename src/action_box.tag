<action_box>
    <div class="action" each={action in current_actions} onclick="ActionStore.trigger('run_action', '{action.name}')">
      {action.label}
    </div>

  <script>

    this.current_actions = []
    var self = this

    this.on('mount', function() {
      ActionStore.trigger('init_actions')
    })   
    
    ActionStore.on('update_actions', function(actions) {
      self.current_actions = actions
      self.update()
    })    
       
  </script>
</action_box>
