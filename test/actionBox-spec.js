describe('ActionBox spec', function() {

  context('default', function() {
    beforeEach(function() {
      var html = document.createElement('actionBox')
      document.body.appendChild(html)
      tag = riot.mount('actionBox')[0]
    })

    it('exist an actionBox ', function() {
      expect(tag).to.exist
    })

    it('has a list of actions ', function() {
      expect(tag.actions).to.exist
    })
  })
})
