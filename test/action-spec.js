describe('Action spec', function() {

  context('default', function() {
    it('creates a new action', function() {
      action = new Action()
      expect(action).to.exist
    })
        
    it('creates a new action with name and label ', function() {
      action = new Action('action_name', 'action_label')
      expect(action.name).to.be.eq('action_name')
      expect(action.label).to.be.eq('action_label')
    })
  })
})
