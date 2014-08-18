# Description
#   A Hubot script that display random photos were uploaded to Hatena::Fotolife
#
# Dependencies:
#   "hatena-fotolife-api": "^0.2.2"
#
# Configuration:
#   HUBOT_HATENA_FOTOLIFE_USERNAME
#   HUBOT_HATENA_FOTOLIFE_APIKEY
#
# Commands:
#   hubot hatena-fotolife [<N>] - display random photos were uploaded to
#                                 Hatena::Fotolife
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  fotolife = require 'hatena-fotolife-api'

  USERNAME = process.env.HUBOT_HATENA_FOTOLIFE_USERNAME
  APIKEY = process.env.HUBOT_HATENA_FOTOLIFE_APIKEY

  robot.respond /hatena-fotolife(?:\s+(\d+))?\s*$/i, (res) ->
    count = parseInt (res.match[1] ? '1'), 10
    client = fotolife
      type: 'wsse'
      username: USERNAME
      apikey: APIKEY
    client.index (err, ret) ->
      photos = ret.feed.entry.map (e) -> e['hatena:imageurl']

      # shuffle photos
      for i in [(photos.length - 1)..0]
        j = Math.floor(Math.random() * i)
        w = photos[i]
        photos[i] = photos[j]
        photos[j] = w

      res.send photos[0...count].join('\n')
