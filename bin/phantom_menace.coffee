USER_AGENT = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) ' +
  'AppleWebKit/A.B (KHTML, like Gecko) Chrome/X.Y.Z.W Safari/A.B.'

class Page
  constructor: ->
    @_loaded = false
    @_page = require('webpage').create()

  open: (url) ->
    @_page.open url

  isLoaded: ->
    @_loaded

class Browser
  constructor: ->
    # This is the response container
    # Always clean this up.
    @command = ''
    @resp    = null

    @history = []
    @state   = 'default'
    this._initPage()

  click: (left, top) ->
    @page.sendEvent left, top

  find: (selector) ->
    console.log 'Finding it'

    ret = @page.evaluate ->
      elements = []
      jQuery('a').each (i, obj) ->
        attrs = {}
        attrs[attr.name] = attr.value for attr in obj.attributes

        elements.push
          attrs: attrs
          text:  jQuery(obj).text()
          pos:   jQuery(obj).offset()
      elements

    @resp =
      success: true
      ret: ret

    @state = 'default'


  findAll: ->
    console.log 'Finding all'

  goforward: ->
    console.log 'Going forward a page'

  goto: (url) ->
    @page.open decodeURIComponent(url)

  goback: ->
    this.goto @history.pop

  getResp: ->
    @resp

  reload: ->
    this.goto @history[@history.length - 1]

  render: ->
    @page.render()

  content: ->
    @page.content

  reset: ->
    @page.release()
    this._initPage()

  runCommand: (command, args...) ->
    @state = 'loading'
    @command = command
    this[command].apply(this, args)

  _initPage: ->
    @page = require('webpage').create()
    @page.settings.userAgent = USER_AGENT
    @page.onLoadStarted    = this._onLoadStarted
    @page.onLoadFinished   = this._onLoadFinished
    @page.onConsoleMessage = this._onConsoleMessage

  _onLoadStarted: =>
    console.log 'Started loading'
    @state = 'loading'

  _onLoadFinished: (status) =>
    console.log 'Finished loading'
    @page.injectJs 'jquery.js'

    @page.evaluate ->
      console.log JSON.stringify($('a').eq(0).offset())

    if @command is 'goto'
      @resp =
        success: true
        command: "goto"

    @state = 'default'

  _onConsoleMessage: (msg) =>
    console.log 'MSG: ' + msg

class Server
  constructor: ->
    @browser = new Browser()
    @server  = require('webserver').create()

  run: ->
    @server.listen 8080, this._handleRequest

  _handleRequest: (req, res) =>
    params = req.post

    if @browser[params.command]
      @browser.runCommand(params.command, params.data)
      this._runLoop(req, res)
    else
      res.statusCode = 200
      res.write JSON.stringify({
        success: false
        message: "Command not found"
      })
      res.close()

  _runLoop: (req, res) =>
    setTimeout =>
      console.log 'THE STATE: ' + @browser.state

      if @browser.state is 'loading'
        this._runLoop(req, res)
      else if @browser.state is 'default'
        res.statusCode = 200
        res.write JSON.stringify(@browser.getResp())
        res.close()
    , 1000

server = new Server()
server.run()
console.log '=> Server running at 8080'
