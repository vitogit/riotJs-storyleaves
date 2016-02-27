<game>
  <chat/>
  <script>

    this.areas = {'main':new Deck(), 'game':new Deck(), 'hand':new Deck(), 'discard':new Deck()}
    this.areas.main.cards = defaultDeck

    this.loadArea = function(area, cards) {
      this.areas[area].load(cards)
    }

    this.unloadArea = function(area, cards) {
      this.areas[area].unload(cards)
    }

    this.moveCardsFromTo = function(from, to, cards) {
      this.unloadArea(from, cards)
      this.loadArea(to, cards)
    }


    this.phases = [ {number:0, description:'Initial phase'},
                    {number:1, description:'first phase'},
                    {number:2, description:'second phase'},
                    {number:3, description:'third phase'},
                    {number:4, description:'fourth phase'}
    ]
    this.currentPhase = 0
    
    this.nextPhase = function(text, user) {
      this.currentPhase++
      if (this.currentPhase > this.phases.length) {
        this.currentPhase = 0
      }
    }



  </script>
</game>
