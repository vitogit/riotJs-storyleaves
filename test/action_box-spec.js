describe('action_box spec', function() {

  context('default', function() {
    beforeEach(function() {
      var html = document.createElement('action_box')
      document.body.appendChild(html)
      tag = riot.mount('action_box')[0]
    })

    it('exist an action_box ', function() {
      expect(tag).to.exist
    })

    it('has a list of actions ', function() {
      expect(tag.actions).to.exist
    })
  })

  context('with parameters', function() {
    beforeEach(function() {
      var action_box = document.createElement('action_box')
      document.body.appendChild(action_box)
      var game = document.createElement('game')
      document.body.appendChild(game)
      var actions = [{name:'initGame', label:'Comenzar juego'}]
      tag = riot.mount('action_box', {actions:actions})[0]
      //tagParent = riot.mount('game')[0]
      //tag.parent = tagParent //mocking the parent
      //PENDING use Sinon.js to mock and spy
    })

    it('exist an action_box ', function() {
      expect(tag).to.exist
    })

    it('has 1 action', function() {
      expect(tag.actions).to.exist
      expect(tag.actions).to.have.lengthOf(1)
    })

    it('exist an action element with class action ', function() {
      var tagText = document.querySelector('.action').textContent
      expect(tagText).to.contain('Comenzar juego')
    })

    it('exist a onclick event ', function() {
      tag.parent = sinon.stub().returnsThis();
      tag.parent.doAction = sinon.stub().withArgs('initGame').returns(true);
      $(".action").click();
    })

    it('calls parent to execute an action ', function() {
      // var actionDom = document.querySelector('.action')
      // $(actionDom).click()
      // expect(tag.parent).respond.to.contain('Comenzar juego')
    })

  })
  
  afterEach(function() {
    tag.unmount()
  });  
})
