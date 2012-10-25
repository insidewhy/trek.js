require('six-jpike');

var desc = {},
    trek = require('./lib/trek');

Object.keys(trek).forEach(function(key) {
  desc[key] = Object.getOwnPropertyDescriptor(trek, key)
})

Object.defineProperties(exports, desc)
