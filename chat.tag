<chat>
  <div class="text-box" id="text-box">
    <ul>
      <li class="message {message.user}" each={message in messages} data-id={message.id}>
        {message.text}
      </li>
    </ul>
  </div>

  <div class="input-box">
    <form onsubmit={add}>
      <input name="input" autocomplete="off" >
    </form>
  </div>


  <script>
    this.messages = opts.messages || []

    this.user = opts.user || 'default'

    this.add = function(e) {
      if (this.input.value != '') {
        this.addGeneric(this.input.value, this.user)
        this.input.value = ''        
      }
    }

    this.addGeneric = function(text, user) {
      this.messages.push({text:text, user: user})
      self.scrollDownChat()      
    }
    
    this.scrollDownChat = function() {
      var chat_box = $('#text-box')
      chat_box.scrollTop(chat_box.prop('scrollHeight'))       
    }
        
    var self = this

    riot.actionStore.on('add_chat', function(message) {
      self.addGeneric(message, 'master')
      self.update()
      self.scrollDownChat()      
    })
    
    riot.actionStore.on('add_chat_new_line', function() {
      self.addGeneric('', 'new_line')
      self.update()
      self.scrollDownChat()      
    })    

    riot.actionStore.on('update_chat', function(messages) {
      self.messages = messages
      self.update()
      self.scrollDownChat()
    })
  </script>


</chat>
