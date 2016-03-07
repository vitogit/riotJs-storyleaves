describe('Card spec', function() {

  context('default', function() {
    it('creates a new card', function() {
      card = new Card()
      expect(card).to.exist
    })
        
    it('creates a new card with number, text and type', function() {
      card = new Card(10, 'text_card', 'type_card')
      expect(card.number).to.be.eq(10)
      expect(card.text).to.be.eq('text_card')
      expect(card.cardType).to.be.eq('type_card')
    })
  })
})
