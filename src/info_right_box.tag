<info_right_box >
  

  <div class="panel panel-info hand_box">
    <div class="panel-heading"><h4 class="panel-title">Estado</h4></div>   
    <div class="panel-body">
      <ul class="list-group">
        <li class="list-group-item list-group-item-heading">Progreso: {this.characterProgress}</li>
        <li class="list-group-item list-group-item-heading">Condiciones: {this.characterConditions}</li>
      </ul> 
    </div>
  </div>  

  <div class="panel panel-info characters_box"> 
    <div class="panel-heading"><h4 class="panel-title">Personajes</h4></div> 
    <div class="panel-body">
      <ul class="list-group">
        <li riot-tag="list-group-item" header="Protagonista" text={this.resources['pj'].card.text.replace('Personaje:','')}></li>
        <li riot-tag="list-group-item" header="Aliado" text={this.resources['ally'].card.text.replace('Personaje:','')}></li>
        <li riot-tag="list-group-item" header="Enemigo" text={this.resources['enemy'].card.text.replace('Personaje:','')}></li>
      </ul>
    </div>
  </div>


  <script>
    this.resources = opts.resources || []
    this.characterProgress = 0
    this.characterConditions = 0


    var self = this

    this.on('mount', function() {
    })

    riot.actionStore.on('update_characterConditions', function(characterConditions) {
      self.characterConditions = characterConditions
      self.update()
    })  
    
    riot.actionStore.on('update_characterProgress', function(characterProgress) {
      self.characterProgress = characterProgress
      self.update()
    })   
    
    riot.actionStore.on('update_resource_info', function(resources) {
      self.resources = resources
      self.update()
    })        
  </script>
</info_right_box>
