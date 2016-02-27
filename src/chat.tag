<chat>
  <h1>Chat</h1>
  <ul>
    <li class="message { message.user == 'master' ? 'master' : '' }" each={message in messages}>
      {message.text}
    </li>
  </ul>
  <form onsubmit={add}>
    <input name="input" >
  </form>

  <script>
    this.messages = opts.messages || []
    this.actions = opts.actions || [{name:'initGame', label:'Sacar 5 cartas'}

    ]
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

  </script>

  <style>
    chat { }
    chat li { }
    chat li .master {
      background-color: red
    }
  </style>
</chat>
