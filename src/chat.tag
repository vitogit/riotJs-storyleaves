<chat>
  <h1>Chat</h1>
  <ul>
    <li class="message" each={message in messages}>
      {message}
    </li>
  </ul>
  <form onsubmit={add}>
    <input name="input" >
  </form>
    
  <script>
    this.messages = []
    
    this.add = function(e) {
      if (this.input.value != '') {
        this.messages.push(this.input.value)
        this.input.value = ''
      }
      return false
    }
  </script>
</chat>
