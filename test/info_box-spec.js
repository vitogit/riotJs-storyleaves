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
  
  it('has hand cards ', function() {
    expect(tag.cards).to.exist
  })        
      
})
