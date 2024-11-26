%{
#include "parser.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap

%%
[0-9]+               { yylval.intval = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.strval = strdup(yytext); return IDENTIFIER; }
"="                  { return '='; }
"+"                  { return '+'; }
"-"                  { return '-'; }
"*"                  { return '*'; }
"/"                  { return '/'; }
"("                  { return '('; }
")"                  { return ')'; }
";"                  { return ';'; }
[ \t\n]+             { /* Пропускаємо пробіли */ }
.                    { printf("Unknown token: %s\n", yytext); }
