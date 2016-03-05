<chat>
  <div class="text-box">
    <ul>
      <li class="message { message.user == 'master' ? 'master' : '' }" each={message in messages}>
        {message.text}
      </li>
    </ul>
  </div>

  <div class="input-box">
    <form onsubmit={add}>
      <input name="input" >
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
      return false
    }

    this.addGeneric = function(text, user) {
      this.messages.push({text:text, user: user})
    }
    var self = this

    riot.actionStore.on('add_chat', function(message) {
      self.addGeneric(message, 'master')
      self.update()
    })

    riot.actionStore.on('update_chat', function(messages) {
      self.messages = messages
      self.update()
    })
  </script>

  <style>
    chat { }
    chat li { }
    chat li .master {
      background-color: red
    }
  </style>
</chat>
