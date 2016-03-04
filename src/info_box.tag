<info_box>
  <!-- <div class="characters_box">
    <div class="character" each={key in Object.keys(characters)}>
      {key} : {characters[key].card.text}
    </div>    
  </div> -->
  
  <div class="resources_box">
    <div class="resource" each={key in Object.keys(resources)}>
      {key} : {resources[key].card.text}
    </div>      
  </div>
  
  <script>

    this.resources = opts.resources || []
    
    var self = this

    this.on('mount', function() {
    })
    
    riot.actionStore.on('update_info', function(resources) {
      self.resources = resources
      self.update()
    })    
  </script>
</info_box>
