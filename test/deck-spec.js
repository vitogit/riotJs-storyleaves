describe('Deck spec', function() {

  context('Mount without params', function() {
    beforeEach(function() {
      var html = document.createElement('deck')
      document.body.appendChild(html)
      tag = riot.mount('deck')[0]
      message = 'mes1'
    });

    it('mounts a deck tag', function() {
      expect(tag).to.exist
      expect(tag.isMounted).to.be.true
    })

    it('has a deck', function() {
      expect(tag.deck).to.exist
      expect(tag.deck).to.be.an('array')
    })

    it('load 2 new cards to the deck', function() {
      cards = [{number:1, text:'card1'},
              {number:2, text:'card2'}
      ]
      tag.load(cards)
      expect(tag.deck).to.have.lengthOf(2)
    })

  })

  afterEach(function() {
    tag.unmount()
  })
})
