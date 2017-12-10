var kuromoji = require('kuromoji');
var kosoado = ['これ','それ','あれ','どれ','ここ','そこ','あそこ','どこ','こんな','そんな','あんな','どんな','こう','そう','ああ','どう','この','その','あの','どの','こっち','そっち','あっち','どっち','こちら','そちら','あちら','どちら'];

module.exports = function(robot) {
  robot.hear(/.*/, function(msg) {

    kuromoji.builder({
      dicPath: "node_modules/kuromoji/dict"
    }).build(function(err, tokenizer) {
      if (err) {
        throw err;
      }
      var tokens = tokenizer.tokenize(msg.message.text);
      //console.dir(tokens);

      var result = '';
      tokens.forEach(function(token) {
        if (kosoado.indexOf(token.surface_form) >=0){ 
          result = result + " `" + token.surface_form + "` ";
        } else {
          result = result + token.surface_form;
        }
        //msg.reply(token.pos + ' ' + token.basic_form);
      });
      msg.reply(result);

      //msg.reply(tokens);
    });
  });
};
