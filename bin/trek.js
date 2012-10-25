#!/usr/bin/env node

var path = require('path'),
    fs   = require('fs'),
    root = path.dirname(fs.realpathSync(__filename))

require(path.join(root, '..', 'trek')).command.run()
