describe('Info Box spec', function() {
  beforeEach(function() {
    var html = document.createElement('info_box')
    document.body.appendChild(html)
    tag = riot.mount('info_box')[0]
  });
    
  it('exist an info_box ', function() {
    expect(tag).to.exist
  })
  
  it('has resources ', function() {
    expect(tag.resources).to.exist
  })
  
  it('has characters ', function() {
    expect(tag.characters).to.exist
  })    

  
  // it('has actions', function() {
  //   expect(riot.actionStore.actions).to.exist
  //   expect(riot.actionStore.actions).to.be.an('array')
  // })
  // 
  // it('initilize the actions array', function() {
  //   riot.actionStore.trigger('init_actions')
  //   expect(riot.actionStore.actions).to.have.lengthOf(1)
  // })  
  // 
  // it('adds new actions', function() {
  //   var actions =[{ name: 'n1', label: 'l1' }]
  //   riot.actionStore.trigger('add_actions',actions)
  //   expect(riot.actionStore.actions).to.have.lengthOf(1)
  // }) 
      
})
