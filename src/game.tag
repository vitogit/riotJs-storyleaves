<game>
  <script>
    this.areas = {'main':new Deck(), 'game':new Deck(), 'hand':new Deck(), 'discard':new Deck()}

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
  </script>
</game>
