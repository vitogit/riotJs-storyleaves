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
    this.actions = opts.actions || []
    this.user = opts.user || 'default'
    this.phases = [ {number:0, description:'Initial phase'},
                    {number:1, description:'first phase'},
                    {number:2, description:'second phase'},
                    {number:3, description:'third phase'},
                    {number:4, description:'fourth phase'}
    ]
    this.currentPhase = 0

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

    this.nextPhase = function(text, user) {
      this.currentPhase++
      if (this.currentPhase > this.phases.length) {
        this.currentPhase = 0
      }  
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
