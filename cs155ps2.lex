/* CS 155 Problem Set Part 2 */
/* This is a simple lexical analyzer for the EASY language */
/* RULE, Camille P. */

%option noyywrap  

%{
  #include <stdio.h>
  #include <stdlib.h>

  int lineno = 1;
  void ret_print(char *token_type);
  void yyerror();
%}

%%
\/\/[^\n]*                                                                              {ret_print("COMMENT");}
"procedure"|"end"|"call"|"return"|"stop"                                                {ret_print("RESERVED_CONTROL_OPERATOR");}
"go to"|"exit"                                                                          {ret_print("RESERVED_UNCONDITIONAL_TRANSFER");}
"if"|"then"|"else if"|"else"|"case"|"endcase"                                           {ret_print("RESERVED_CONDITIONAL_TRANSFER");}
"while"|"do"|"endwhile"|"repeat"|"until"|"loop"|"forever"|"for"|"to"|"by"|"endfor"      {ret_print("RESERVED_ITERATION");}
"input"                                                                                 {ret_print("RESERVED_INPUT");}
"output"                                                                                {ret_print("RESERVED_OUTPUT");}
"array"|"node"                                                                          {ret_print("RESERVED_DECLARATION");}
"and"|"or"|"not"                                                                        {ret_print("LOGICAL_OPERATOR");}
"ceil"|"floor"|"mod"|"log"|"log2"                                                       {ret_print("MISC_MATH_OPERATOR");}
"true"|"false"|"True"|"False"                                                           {ret_print("BOOLEAN_VALUE");}
[a-zA-Z]|([a-zA-Z_][a-zA-Z0-9_]*)                                                       {ret_print("IDENTIFIER");}
"<-"                                                                                    {ret_print("ASSIGNMENT");}
"+"|"-"|"/"|"x"|"^"                                                                     {ret_print("ARITHMETIC_OPERATOR");}
"<"|"<="|"!="|">"|">="|"=="                                                             {ret_print("RELATIONAL_OPERATOR");}
"="                                                                                     {ret_print("ASSIGNMENT");}
":"|";"|","                                                                             {ret_print("DELIMITER");}
"("|")"|"["|"]"                                                                         {ret_print("GROUPING");}
\'(\\.|[^\'])*\'                                                                        {ret_print("STRING");}
[1-9][0-9]*|0                                                                           {ret_print("INT");}
[0-9]*\.?[0-9]+                                                                         {ret_print("FLOAT");}
[ \t\s\r\f]+                                                                            
\n                                                                                      {lineno++;}
.                                                                                       {ret_print("Unrecognized character");}
%%

void ret_print(char *token_type) {
    printf("--------------------\nyytext: %s\ntoken: %s\nlineno:%d\n", yytext, token_type, lineno);
}

void yyerror(char *message){
    printf("Error: \"%s\" in line %d. Token = %s\n", message, lineno, yytext);
    exit(1);
}

int main(int argc, char **argv) {
  if (argc < 2) {
    printf("No input file specified.\n");
    return 1;
  }

  FILE *input_file = fopen(argv[1], "r");
  if (!input_file) {
    printf("Error: Unable to open input file '%s'.\n", argv[1]);
    return 1;
  }

  yyin = input_file;
  yylex();
  fclose(input_file);

  return 0;
}