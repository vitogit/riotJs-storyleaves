<info_box >
  <div class="characters_box">
  <h4>Personajes</h4>
    <ul class="list-unstyled">
      <li>Protagonista : {this.resources['pj'].card.text.replace('Personaje:','')}</li>
      <li>Aliado : {this.resources['ally'].card.text.replace('Personaje:','')}</li>
      <li>Enemigo : {this.resources['enemy'].card.text.replace('Personaje:','')}</li>
    </ul>
  </div>

  <div class="my_resources_box">
    <h4>Recursos Protagonista</h4>
    <ul class="list-unstyled">
      <li>Caracteristica del protagonista : {this.resources['pj_feature'].card.text}</li>
      <li>La caracteristica del Aliado : {this.resources['ally_feature'].card.text}</li>
      <li>La relación con el Aliado : {this.resources['pj_ally_rel'].card.text}</li>
    </ul>
  </div>

  <div class="enemy_resources_box">
    <h4>Recursos Enemigo</h4>
    <ul class="list-unstyled">
      <li>Caracteristica enemigo : {this.resources['pj_feature'].card.text}</li>
      <li>La relacion Enemigo - Aliado : {this.resources['pj_enemy_rel'].card.text}</li>
      <li>La relación Enemigo - Protagonista : {this.resources['ally_enemy_rel'].card.text}</li>
    </ul>
  </div>

  <div class="hand_box">
    <h4>Mano</h4>
    <div class="hand btn btn-info btn-xs" each={card in cards}>
      {card.number} - {card.text}
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
