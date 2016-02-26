describe('Chat spec', function() {

  beforeEach(function() {
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
    $('input').val('mes1')
    $('form').submit()
    expect(tag.messages).to.have.length(1)
  })     
  
  it('add the message to a li tag', function() {  
    tag.input.value = 'mes1' //same as document.querySelector('input').value
    $('form').submit() //using jquery to send the form
    var tagText = document.querySelector('.message').textContent
    expect(tagText).to.contain('mes1') 
  }) 
  
  it('empty input after adding', function() {  
    tag.input.value = 'mes1' 
    tag.add()     
    var tagText = document.querySelector('input').value
    expect(tagText).to.be.empty 
  }) 
     

  
  afterEach(function() {
    tag.unmount()
  });          
})
