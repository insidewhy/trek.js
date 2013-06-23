# trek.js

A PEG parsing system in which the AST and parser are described by a single grammar. The constructed parser is then capable of populating the AST directly from source texts.

# Example

Parsers can be written using the JavaScript API or compiled from a shortened form.

```JavaScript
// first create a parser
var p = require('trek.js').parse

// create a whitespace and comment skipping parser
// p.star(q)  - matches `q' zero or more times, stores a string.
// p.plus(q)  - matches `q' one or more times, stores a non-empty string.
var comment = p.lexeme("//", p.star(p.notChar("\n")), "\n"),
    spacing = p.plus(p.or(p.whitespace(), p.char(comment)))

// trek parsers use the whitespace parser as part of the stream.
var stream = p.stream(spacing)

var idFirst = p.or("_", "$", p.range("az")),
    identifier = p.lexeme(idFirst, p.star(p.or(idFirst, p.range("09"))))

// star/plus on a string/object storing parser allows the space parser
// to match in between elements and stores an array of the contents.
var manyIdentifiers = p.plus(identifier)

var ast = stream.parse(manyIdentifiers, "hello totoro    friend")
// ast now contains ["hello", "totoro", "friend"]
```

The same parser in short:

```
Comment         <- "//" ^ (!\n)* ^ \n
Spacing         <- (\s / Comment)^+
IdFirst         <- [a-z$_]
Identifier      <- IdFirst ^ (IdFirst / [0-9])*
ManyIdentifiers <- Identifier+
```

# TODO
* Test for tree optional
* Tree join
* Bootstrap grammar compiler
