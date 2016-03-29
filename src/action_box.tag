<action_box>
    <div class="btn btn-sm btn-default action" each={action in current_actions} onclick={run_action}>
      {action.label}
    </div>

  <script>

    this.current_actions = opts.current_actions || []
    var self = this

    this.run_action = function run_action(event) {
      var action = event.item.action
      riot.actionStore.trigger('run_action', action.name, action.data)
      riot.actionStore.trigger('add_chat_new_line')
    }

    this.on('mount', function() {
      riot.actionStore.trigger('init_actions')
    })

    riot.actionStore.on('update_actions', function(actions) {
      self.current_actions = actions
      self.update()
    })

  </script>
</action_box>
