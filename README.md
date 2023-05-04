
# CS 155 Problem Set 2
## Lexical Analyzer using Flex

### RULE, Camille P. | 201909414

This program is a simple lexical analyzer for the EASY language.




## Preliminaries

The program developed eats up whitespaces such as `[ \s\t\f\r\n]` but increments the line number as expected. Note that this program was developed on a Windows Subsystem for Linux (WSL) on a Windows 11 machine. 
## Files

- `cs155ps2.lex` is the input file containing the specifications of the lexical analyzer to be generated
- `testfiles` is a folder containing 5 testfiles 
## Compilation

To compile and run, the following commands can be executed.

```bash
flex cs155ps2.lex
gcc lex.yy.c -o <output_name>
./<output_name> <filename or path to file>
```

Where `flex cs155ps2.lex` compiles the flex file and generates a corresponding `lex.yy.c` file.

Running `gcc lex.yy.c -o <output_name>` compiles `lex.yy.c` and outputs an executable which can be named. 

Lastly, we open the executable file and specify a filename or a filepath to the input file.


    
## Running Tests

An example run can be:

```bash
flex cs155ps2.lex
gcc lex.yy.c -o hanoi_test
./hanoi_test ~/testfiles/hanoi.easy
```

Where `hanoi_test` is the executable generated, and `~/testfiles/hanoi.easy` is the path to the input file to be tested.

## Sample Input

We have the input file:

```
// This is a comment - you may edit this out if you did not handle comments
// hanoi.easy

procedure THP(n,S,T,I) 
  if n = 1 then output 'Move disk from peg' S 'to peg' T
  else [ 
    call THP(n - 1, S, I, T)
    output 'Move disk from peg' S 'to peg' T
    call THP(n-1, I, T, S)
  ]
end THP
```

## Sample output (snipped)
The program is expected to output the following to the terminal:

```
--------------------
yytext: // This is a comment - you may edit this out if you did not handle comments
token class: COMMENT
lineno:1
--------------------
yytext: // hanoi.easy
token class: COMMENT
lineno:2
--------------------
yytext: procedure
token class: RESERVED_CONTROL_OPERATOR
lineno:4
--------------------
yytext: THP
token class: IDENTIFIER
lineno:4
--------------------
yytext: (
token class: GROUPING
lineno:4
--------------------
yytext: n
token class: IDENTIFIER
lineno:4
--------------------
yytext: ,
token class: DELIMITER
lineno:4
--------------------
yytext: S
token class: IDENTIFIER
lineno:4
--------------------
yytext: ,
token class: DELIMITER
lineno:4
--------------------
yytext: T
token class: IDENTIFIER
lineno:4
--------------------
yytext: ,
token class: DELIMITER
lineno:4
--------------------
yytext: I
token class: IDENTIFIER
lineno:4
--------------------
yytext: )
token class: GROUPING
lineno:4
--------------------
```
Where `yytext` is the matched token, `token class` is the token classification, and `lineno` is the line number where the token was found.
