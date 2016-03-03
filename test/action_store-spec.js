describe('Action Store spec', function() {

  it('exist an ActionStore ', function() {
    expect(riot.actionStore).to.be.instanceOf(ActionStore)
  })
  
  it('has actions', function() {
    expect(riot.actionStore.actions).to.exist
    expect(riot.actionStore.actions).to.be.an('array')
  })
  
  it('initilize the actions array', function() {
    riot.actionStore.trigger('init_actions')
    expect(riot.actionStore.actions).to.have.lengthOf(1)
  })  
  
  it('adds new actions', function() {
    var actions =[{ name: 'n1', label: 'l1' }]
    riot.actionStore.trigger('add_actions',actions)
    expect(riot.actionStore.actions).to.have.lengthOf(1)
  }) 
      
})
