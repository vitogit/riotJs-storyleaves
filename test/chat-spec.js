describe('Chat spec', function() {

  before(function() {
    var html = document.createElement('chat')
    document.body.appendChild(html)
    tag = riot.mount('chat')[0]
  });  
  
  it('mounts a chat tag', function() {
    expect(tag).to.exist
    expect(tag.isMounted).to.be.true    
  })
  
  it('has messages', function() {  
    expect(tag.messages).to.exist
    expect(tag.messages).is.an('array')
  }) 
  
  it('has an input ', function() {  
    expect(tag.input).to.exist
  }) 
  
  it('adds a new message from the input', function() { 
    tag.input = 'mes'
    tag.add() 
    expect(tag.messages).to.have.length(1)
  })     
  // 
  // it('mounts a hello tag with a setted name', function() {  
  //   tag = riot.mount('hello', {name: 'Carl'})[0]
  //   expect(tag.name).to.be.eq('Carl')
  // })
  // 
  // it('prints <h1>Hello {name}</h1>', function() {  
  //   tag = riot.mount('hello', {name: 'Carl'})[0]
  //   var tagText = document.querySelector('hello > h1').textContent
  //   expect(tagText).to.be.eq('Hello Carl') 
  // })       
})
