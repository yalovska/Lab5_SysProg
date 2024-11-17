%{
#include "parser.tab.h"
#include <stdlib.h>
#include <string.h>

%}

identifier [_a-zA-Z][_a-zA-Z0-9]*
number     [0-9]+
float_num  [0-9]+\.[0-9]*|[0-9]*\.[0-9]+

%%
[ \t\n]+                 ; // Пропуск пробільних символів
"include"                { return INCLUDE; }
"int"                    { return INT; }
"char"                   { return CHAR; }
"float"                  { return FLOAT; }
"+"                      { return PLUS; }
"-"                      { return MINUS; }
"*"                      { return STAR; }
"/"                      { return SLASH; }
"="                      { return EQUAL; }
";"                      { return SEMICOLON; }
"("                      { return LPAREN; }
")"                      { return RPAREN; }
"{"                      { return LCBRACE; }
"}"                      { return RCBRACE; }
{identifier}             { yylval.strval = strdup(yytext); return ID; }
{number}                 { yylval.num = atoi(yytext); return INT_VALUE; }
{float_num}              { yylval.fval = atof(yytext); return FLOAT_VALUE; }
.                        { return yytext[0]; }
%%

int yywrap() {
    return 1;
}
