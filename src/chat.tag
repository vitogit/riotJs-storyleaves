<chat>
  <h1>Chat</h1>
  <ul>
    <li class="message { this.user == 'master' ? 'master' : '' }" each={message in messages}>
      {message.text}
    </li>
  </ul>
  <form onsubmit={add}>
    <input name="input" >
  </form>
    
  <script>
    this.messages = opts.messages || []
    this.actions = opts.actions || []
    this.user = opts.user || 'default'
    
    this.add = function(e) {
      if (this.input.value != '') {
        this.messages.push({text:this.input.value, user: this.user})
        this.input.value = ''
      }
      return false
    }
  </script>
  
  <style>
    chat { }
    chat li { }
    chat li .master {
      background-color: red
    }
  </style>  
</chat>
