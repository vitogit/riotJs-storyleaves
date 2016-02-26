describe('Chat spec', function() {


  context('Mount without params', function() {
    beforeEach(function() {
      var html = document.createElement('chat')
      document.body.appendChild(html)
      tag = riot.mount('chat')[0]
      message = 'mes1'
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
      $('input').val(message)
      $('form').submit()
      expect(tag.messages).to.have.length(1)
    })     
    
    it('add the message to a li tag', function() {  
      tag.input.value = message //same as document.querySelector('input').value
      $('form').submit() //using jquery to send the form
      var tagText = document.querySelector('.message').textContent
      expect(tagText).to.contain(message) 
    }) 
    
    it('empty input after adding', function() {  
      tag.input.value = message 
      tag.add()     
      var tagText = document.querySelector('input').value
      expect(tagText).to.be.empty 
    }) 
       
    it('has actions', function() {  
      expect(tag.actions).to.exist;
      expect(tag.actions).to.be.an('array');
    })
    
    it('exist an user', function() {  
      expect(tag.user).to.exist
    }) 
    
    it('set the default user', function() {  
      tag.input.value = message 
      tag.add()     
      var message = tag.messages[0]
      expect(message.user).to.be.eq('default')
    }) 
    
    it('set the master class when a master user send message', function() {  
      tag.addGeneric(message, 'master')     
      tag.update()
      var classNames = document.querySelector('.master').textContent
      expect(classNames).to.be.contains('mes1')
    })         
  })

  context('Passing parameters to mount', function() {
    beforeEach(function() {
      var html = document.createElement('chat')
      document.body.appendChild(html)
      messages = ['mes1', 'mes2']
      actions = ['ac1', 'ac2']
    }); 
        
    it('mounts the tag with messages', function() { 
      tag = riot.mount('chat', {messages: messages})[0]
      expect(tag.messages).to.be.eq(messages)
    })
    
    it('mounts the tag with actions', function() { 
      tag = riot.mount('chat', {actions: actions})[0]
      expect(tag.actions).to.be.eq(actions)
    })  
           
  })

  afterEach(function() {
    tag.unmount()
  });          
})
