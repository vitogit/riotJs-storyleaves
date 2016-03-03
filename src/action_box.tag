<action_box>
    <div class="action" each={action in current_actions} onclick="riot.actionStore.trigger('run_action', '{action.name}')">
      {action.label}
    </div>

  <script>

    this.current_actions = opts.current_actions || [] 
    var self = this

    this.on('mount', function() {
      riot.actionStore.trigger('init_actions')
    })   
    
    riot.actionStore.on('update_actions', function(actions) {
      self.current_actions = actions
      self.update()
    })    
       
  </script>
</action_box>
