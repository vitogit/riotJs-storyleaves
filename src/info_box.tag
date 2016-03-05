<info_box>
  <div class="characters_box">
  <h3>Personajes</h3>
    <ul>
      <li>Personaje : {this.characters['pj'].card.text}</li>
      <li>Aliado : {this.characters['ally'].card.text}</li>
      <li>Enemigo : {this.characters['enemy'].card.text}</li>
    </ul>
  </div>
  
  <div class="my_resources_box">
    <h3>Recursos Protagonista</h3>
    <ul>
      <li>Caracteristica del protagonista : {this.resources['pj_feature'].card.text}</li>
      <li>La caracteristica del Aliado : {this.resources['ally_feature'].card.text}</li>
      <li>La relación con el Aliado : {this.resources['pj_ally_rel'].card.text}</li>   
    </ul>
         
  </div> 
  
  <div class="enemy_resources_box">
    <h3>Recursos Enemigo</h3>
    <ul>
      <li>Caracteristica enemigo : {this.resources['pj_feature'].card.text}</li>
      <li>La relacion Enemigo - Aliado : {this.resources['pj_enemy_rel'].card.text}</li>
      <li>La relación Enemigo - Protagonista : {this.resources['ally_enemy_rel'].card.text}</li>  
    </ul>
      
  </div> 
  
  <div class="hand_box">
    <div class="hand" each={card in cards}>
      {card.text}
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
      self.resources = resources
      self.update()
    })    
    
    riot.actionStore.on('update_hand_info', function(cards) {
      self.cards = cards
      self.update()
    })      
  </script>
</info_box>
