<chat>
  <h1>Chat</h1>
  <ul>
    <li class="message" each={message in messages}>
      {message}
    </li>
  </ul>
  <form onsubmit={add}>
    <input name="input" onkeyup={edit}>
  </form>
    
  <script>
    this.inputMessage = ''
    this.messages = []
    
    this.add = function(e) {
      console.debug(e)
      e.preventDefault()
      if (this.inputMessage != '') {
        this.messages.push(this.inputMessage)
        this.input.value = ''
        this.inputMessage = ''
      }
    }
    
    this.edit = function(e) {
      this.inputMessage = e.currentTarget.value
  
    }    
  </script>
</chat>
