# Description:
#   全ての発言に対して返答します。
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot おはよう - "おはようございます！"と返答
#
# Notes:
#   None
#
# Author:
#   toatsushi

kuromoji = require 'kuromoji'

class Tokenizer
  constructor: ->
    kuromoji
    .builder(dicPath: 'node_modules/kuromoji/dist/dict/')
    .build (err, tokenizer) => @_tokenizer = tokenizer

  tokenize: (text, cb) ->
    if @_tokenizer then cb @_tokenizer.tokenize text

tokenizer = new Tokenizer()

module.exports = (robot) ->
  robot.hear /(.+)/, (msg) ->
    tokenizer.tokenize msg.message.text, (tokens) ->
      filtered = tokens.filter (token) -> token.pos == '名詞'
      words = filtered.map (token) -> token.surface_form
      msg.reply msg.random words


module.exports = (robot) ->

  robot.hear /((疲|つか)れた|I'm tired.)/i, (msg) ->
    msg.reply "おはようございます！"
