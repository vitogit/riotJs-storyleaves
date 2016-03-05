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

    it('has a list of current actions ', function() {
      expect(tag.current_actions).to.exist
    })
  })

  context('with parameters', function() {
    beforeEach(function() {
      var action_box = document.createElement('action_box')
      document.body.appendChild(action_box)
      var game = document.createElement('game')
      document.body.appendChild(game)
      var actions = [{name:'initGame', label:'Comenzar juego'}]
      tag = riot.mount('action_box', {current_actions:actions})[0]
    })

    it('exist an action_box ', function() {
      expect(tag).to.exist
    })

    it('has 1 action', function() {
      expect(tag.current_actions).to.exist
      expect(tag.current_actions).to.have.lengthOf(1)
    })

    it('exist an action element with class action ', function() {
      var tagText = document.querySelector('.action').textContent
      expect(tagText).to.contain('Comenzar juego')
    })

    //this will not work because there is no game tag mounted
    //move this to an itegration test
    // it('run the first action using the onclick event ', function() {
    //     
    //   riot.actionStore.trigger('run_action', '{action.name}')
    //   $(".action").click();
    //   expect(tag.current_actions[0].name).to.be.eq('choosePj')
    // })
  })
  
  afterEach(function() {
    tag.unmount()
  });  
})
