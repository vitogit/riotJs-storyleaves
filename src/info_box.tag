<info_box >
  
  <div class="panel panel-info hand_box">
    <div class="panel-heading"><h4 class="panel-title">Mano</h4></div>   
    <div class="panel-body">
      <div class="hand btn btn-info btn-xs" each={card in cards} onclick={selectCard}>
        {card.fullText()}
      </div>
    </div>
  </div>

  <div class="panel panel-info my_resources_box">
    <div class="panel-heading"><h4 class="panel-title">Recursos Protagonista</h4></div> 
    <div class="panel-body">
      <ul class="list-group">
        <li riot-tag="list-group-item" header="Caracteristica del protagonista" text={this.resources['pj_feature'].card.fullText()}></li>
        <li riot-tag="list-group-item" header="La caracteristica del Aliado" text={this.resources['ally_feature'].card.fullText()}></li>
        <li riot-tag="list-group-item" header="La relación con el Aliado" text={this.resources['pj_ally_rel'].card.fullText()}></li>
      </ul>
    </div>
  </div>

  <div class="panel panel-info enemy_resources_box">
    <div class="panel-heading"><h4 class="panel-title">Recursos Enemigo</h4></div> 
    <div class="panel-body">
      <ul class="list-unstyled">
        <li riot-tag="list-group-item" header="Caracteristica enemigo" text={this.resources['enemy_feature'].card.fullText()} data-resource="enemy_feature" onclick={selectEnemyResource}></li>
        <li riot-tag="list-group-item" header="La relacion Enemigo - Aliado" text={this.resources['pj_enemy_rel'].card.fullText()}  data-resource="pj_enemy_rel" onclick={selectEnemyResource}></li>
        <li riot-tag="list-group-item" header="La relación Enemigo - Protagonista" text={this.resources['ally_enemy_rel'].card.fullText()} data-resource="ally_enemy_rel" onclick={selectEnemyResource}></li>
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
    this.cards = opts.cards || []
    this.selectedCard = {}
    this.selectedEnemyResource = ''
    
    this.selectCard = function(event) {
      this.selectedCard = event.item.card
      riot.actionStore.trigger('card_selected', this.selectedCard)
    }
    
    this.selectEnemyResource = function(event) {
      var resourceName = event.currentTarget.dataset.resource
      if (resourceName) {
        riot.actionStore.trigger('enemy_resource_selected', resourceName)
      }
    }    

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
