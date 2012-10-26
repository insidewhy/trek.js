# trek.js

A parser generator based on the TPEG variant of PEGs that can build a parser that stores text to an AST structure, both from a single grammar.

# Example

You can write parsers directly in JavaScript or in a shortened form:

```JavaScript
// first create a parser
var p = require('trek.js').parse

// create a whitespace and comment skipping parser
// p.star(q)  - matches `q' zero or more times, stores a string.
// p.plus(q)  - matches `q' one or more times, stores a non-empty string.
var comment = p.lexeme("//", p.star(p.notChar("\n")), "\n"),
    spacing = p.plus(p.or(p.whitespace(), p.char(comment)))

// trek parsers use the whitespace parser as part of the grammar to
// do good things which you will see below.
var parser = p.parser(spacing)

var idFirst = p.or("_", "$", p.range("az")),
    identifier = p.lexeme(idFirst, p.star(p.or(idFirst, p.range("09"))))

// star/plus on a string/object storing parser allows the space parser
// to match in between elements and stores an array of the contents.
var manyIdentifiers = p.plus(identifier)

var ast = parser.parse(manyIdentifiers, "hello totoro    friend")
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
