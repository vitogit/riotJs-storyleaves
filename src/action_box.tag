<action_box>
    <div class="action" each={action in actions} onclick='{doAction}'>
      {action.label}
    </div>

  <script>
    this.actions = opts.actions || [{name:'initGame', label:'Comenzar juego'}]
    this.doAction = function(e) {
      var actionName = e.item.action.name
      this.parent.parent.doAction(actionName) //not sure why parent.parent
    }
  </script>
</action_box>
