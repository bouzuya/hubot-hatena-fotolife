{Robot, User, TextMessage} = require 'hubot'
assert = require 'power-assert'
path = require 'path'
sinon = require 'sinon'

describe 'hatena-fotolife', ->
  beforeEach (done) ->
    @sinon = sinon.sandbox.create()
    # for warning: possible EventEmitter memory leak detected.
    # process.on 'uncaughtException'
    @sinon.stub process, 'on', -> null
    @robot = new Robot(path.resolve(__dirname, '..'), 'shell', false, 'hubot')
    @robot.adapter.on 'connected', =>
      @robot.load path.resolve(__dirname, '../../src/scripts')
      done()
    @robot.run()

  afterEach (done) ->
    @robot.brain.on 'close', =>
      @sinon.restore()
      done()
    @robot.shutdown()

  describe 'listeners[0].regex', ->
    beforeEach ->
      @sender = new User 'bouzuya', room: 'hitoridokusho'
      @callback = @sinon.spy()
      @robot.listeners[0].callback = @callback

    describe 'receive "@hubot hatena-fotolife"', ->
      beforeEach ->
        message = '@hubot hatena-fotolife'
        @robot.adapter.receive new TextMessage(@sender, message)

      it 'matches', ->
        assert @callback.callCount is 1
        match = @callback.firstCall.args[0].match
        assert match.length is 2
        assert match[0] is '@hubot hatena-fotolife'
        assert match[1] is undefined

    describe 'receive "@hubot hatena-fotolife 3 "', ->
      beforeEach ->
        message = '@hubot hatena-fotolife 3 '
        @robot.adapter.receive new TextMessage(@sender, message)

      it 'matches', ->
        assert @callback.callCount is 1
        match = @callback.firstCall.args[0].match
        assert match.length is 2
        assert match[0] is '@hubot hatena-fotolife 3 '
        assert match[1] is '3'

  describe 'listeners[0].callback', ->
    beforeEach ->
      @callback = @robot.listeners[0].callback
      @send = @sinon.spy()

    describe 'receive "@hubot hatena-fotolife"', ->
      beforeEach ->
        {Fotolife} = require 'hatena-fotolife-api'
        @sinon.stub Fotolife.prototype, 'index', (callback) ->
          callback null, feed: entry: [
            'hatena:imageurl': 'http://example.com/hoge'
          ,
            'hatena:imageurl': 'http://example.com/fuga'
          ]
        @callback
          match: ['@hubot hatena-fotolife']
          send: @send

      it 'send "http://example.com/hoge" or "http://example.com/fuga"', ->
        assert @send.callCount is 1
        assert @send.firstCall.args[0] is 'http://example.com/hoge' or \
               @send.firstCall.args[0] is 'http://example.com/fuga'

    describe 'receive "@hubot hatena-fotolife 2 "', ->
      beforeEach ->
        {Fotolife} = require 'hatena-fotolife-api'
        @sinon.stub Fotolife.prototype, 'index', (callback) ->
          callback null, feed: entry: [
            'hatena:imageurl': 'http://example.com/hoge'
          ,
            'hatena:imageurl': 'http://example.com/fuga'
          ]
        @callback
          match: ['@hubot hatena-fotolife 2 ', '2']
          send: @send

      it 'send "http://.../hoge\\n...fuga" or "http://.../fuga\\n...hoge"', ->
        assert @send.callCount is 1
        assert @send.firstCall.args[0] is \
          'http://example.com/hoge\nhttp://example.com/fuga' or \
          @send.firstCall.args[0] is \
          'http://example.com/fuga\nhttp://example.com/hoge'
