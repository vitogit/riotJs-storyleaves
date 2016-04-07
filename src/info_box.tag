<info_box >
  
  <div class="panel panel-info hand_box">
    <div class="panel-heading"><h4 class="panel-title">Mano</h4></div>   
    <div class="panel-body">
      <div class="hand btn btn-info btn-xs" each={card in cards} onclick={selectCard}>
        {card.fullText()}
      </div> 
    </div>
  </div>

  <div class="panel panel-info enemy_resources_box">
    <div class="panel-heading"><h4 class="panel-title">Recursos Enemigo <p>{this.resources['enemy'].card.text.replace('Personaje:','')}</p></h4></div> 
    <div class="panel-body">
      <ul class="list-unstyled">
        <li riot-tag="list-group-item" header="Caracteristica enemigo" text={this.resources['enemy_feature'].card.fullText()} data-resource="enemy_feature" onclick={selectEnemyResource}></li>
        <li riot-tag="list-group-item" header="La relacion Enemigo - Aliado" text={this.resources['pj_enemy_rel'].card.fullText()}  data-resource="pj_enemy_rel" onclick={selectEnemyResource}></li>
        <li riot-tag="list-group-item" header="La relación Enemigo - Protagonista" text={this.resources['ally_enemy_rel'].card.fullText()} data-resource="ally_enemy_rel" onclick={selectEnemyResource}></li>
      </ul>
    </div>
  </div>

  <div class="panel panel-info my_resources_box">
    <div class="panel-heading"><h4 class="panel-title">Recursos Protagonista <p>{this.resources['pj'].card.text.replace('Personaje:','')}</p></h4></div> 
    <div class="panel-body">
      <ul class="list-group">
        <li riot-tag="list-group-item" header="Caracteristica del protagonista" text={this.resources['pj_feature'].card.fullText()} data-resource="pj_feature" onclick={selectPjResource}></li>
        <li riot-tag="list-group-item" header="La caracteristica del Aliado" text={this.resources['ally_feature'].card.fullText()} data-resource="ally_feature" onclick={selectPjResource}></li>
        <li riot-tag="list-group-item" header="La relación con el Aliado" text={this.resources['pj_ally_rel'].card.fullText()} data-resource="pj_ally_rel" onclick={selectPjResource}></li>
      </ul>
    </div>
  </div>

  <div class="panel panel-info my_resources_box">
    <div class="panel-heading"><h4 class="panel-title">Aliado <p>{this.resources['ally'].card.text.replace('Personaje:','')}</p></h4></div> 
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
      if (this.resources[resourceName].card) {
        riot.actionStore.trigger('enemy_resource_selected', resourceName)
      }
    } 
    
    this.selectPjResource = function(event) {
      var resourceName = event.currentTarget.dataset.resource
      if (this.resources[resourceName].card) {
        riot.actionStore.trigger('pj_resource_selected', resourceName)
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
