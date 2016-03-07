<info_box >
  
  <div class="panel panel-info characters_box"> 
    <div class="panel-heading"><h4 class="panel-title">Personajes</h4></div> 
    <div class="panel-body">
      <ul class="list-unstyled">
        <li>Protagonista : {this.resources['pj'].card.text.replace('Personaje:','')}</li>
        <li>Aliado : {this.resources['ally'].card.text.replace('Personaje:','')}</li>
        <li>Enemigo : {this.resources['enemy'].card.text.replace('Personaje:','')}</li>
      </ul>  
    </div>
  </div>

  <div class="panel panel-info my_resources_box">
    <div class="panel-heading"><h4 class="panel-title">Recursos Protagonista</h4></div> 
    <div class="panel-body">
      <ul class="list-group">
        <li class="list-group-item">
          <h5 class="list-group-item-heading">Caracteristica del protagonista</h5>
          <p class="list-group-item-text">{this.resources['pj_feature'].card.text}</p>
        </li>
        <li class="list-group-item">
          <h5 class="list-group-item-heading">La caracteristica del Aliado</h5>
          <p class="list-group-item-text">{this.resources['ally_feature'].card.text}</p>
        </li>
        <li class="list-group-item" >
          <h5 class="list-group-item-heading">La relación con el Aliado</h5>
          <p class="list-group-item-text">{this.resources['pj_ally_rel'].card.text}</p>          
        </li>
      </ul>
    </div>
  </div>

  <div class="panel panel-info enemy_resources_box">
    <div class="panel-heading"><h4 class="panel-title">Recursos Enemigo</h4></div> 
    <div class="panel-body">
    
      <ul class="list-unstyled">
        <li>Caracteristica enemigo : {this.resources['pj_feature'].card.text}</li>
        <li>La relacion Enemigo - Aliado : {this.resources['pj_enemy_rel'].card.text}</li>
        <li>La relación Enemigo - Protagonista : {this.resources['ally_enemy_rel'].card.text}</li>
      </ul>
    </div>      
  </div>

  <div class="panel panel-info hand_box">
    <div class="panel-heading"><h4 class="panel-title">Mano</h4></div> 
    
    <div class="panel-body">
      
      <div class="hand btn btn-info btn-xs" each={card in cards}>
        {card.number} - {card.text}
      </div>
    </div>

  </div>


  <!-- <div class="resources_box">
    <div class="resource" each={key in Object.keys(resources)}>
      {key} : {resources[key].card.text}
    </div>
  </div> -->

  <script>

    this.resources = opts.resources || []
    this.cards = opts.cards || []

    var self = this

    this.on('mount', function() {
    })

    riot.actionStore.on('update_resource_info', function(resources) {
      console.log('update____')
      self.resources = resources
      self.update()
    })

    riot.actionStore.on('update_hand_info', function(cards) {
      self.cards = cards
      self.update()
    })
  </script>
</info_box>
