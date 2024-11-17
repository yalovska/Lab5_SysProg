%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"

void yyerror(const char *str);
int yylex(void);
ASTNode *root;
int yydebug = 1;
%}

%union {
    int num;
    float fval;
    char* strval;
    ASTNode* node;
}

%token <strval> INCLUDE HEADER LIBRARY
%token <strval> CHAR DOUBLE FLOAT INT LONG UNSIGNED SHORT SIGNED STRUCT AUTO CONST VOID
%token <strval> STRING_VALUE CHAR_VALUE
%token <num> INT_VALUE
%token <fval> FLOAT_VALUE
%token <strval> ID
%token COLON DOT COMMA SEMICOLON
%token IF FOR DO WHILE ELSE
%token LPAREN RPAREN LCBRACE RCBRACE LSBRACE RSBRACE LABRACE RABRACE
%token STAR AMPERSAND HASH
%token EQUAL EXCLAMATION VBAR QMARK ARROW
%token PLUS MINUS SLASH PERCENT
%token GOTO CONTINUE BREAK RETURN SIZEOF STATIC TYPEDEF UNION VOLATILE
%token OTHER

%type <node> expression term factor declaration initialization assignment
%start input

%left PLUS MINUS
%left STAR SLASH
%right EQUAL

%%

input:
    | input include
    | input func_declaration
    | input declaration SEMICOLON
;

include:
    HASH INCLUDE HEADER { printf("Including header: %s\n", $3); }
;

declaration:
    initialization
    | assignment
;

initialization:
    type_name ID EQUAL expression { $$ = createNode("init", createNode($2, NULL, NULL), $4); }
;

assignment:
    ID EQUAL expression %prec EQUAL { $$ = createNode("=", createNode($1, NULL, NULL), $3); }
;

func_declaration:
    type_name ID LPAREN RPAREN LCBRACE RCBRACE
    { printf("Function %s defined.\n", $2); }
;

type_name:
    INT | CHAR | FLOAT
;

expression:
    expression PLUS term { $$ = createNode("+", $1, $3); }
    | expression MINUS term { $$ = createNode("-", $1, $3); }
    | term { $$ = $1; }
;


term:
    term STAR factor { $$ = createNode("*", $1, $3); }
    | term SLASH factor { $$ = createNode("/", $1, $3); }
    | factor { $$ = $1; }
;

factor:
    LPAREN expression RPAREN { $$ = $2; }
    | INT_VALUE {
        char buffer[20];
        snprintf(buffer, sizeof(buffer), "%d", $1);
        $$ = createNode(buffer, NULL, NULL);
    }
    | FLOAT_VALUE {
        char buffer[20];
        snprintf(buffer, sizeof(buffer), "%f", $1);
        $$ = createNode(buffer, NULL, NULL);
    }
;

%%

void yyerror(const char *str) {
    fprintf(stderr, "Error: %s\n", str);
}

int main() {
    if (!yyparse()) {
        printf("Abstract Syntax Tree:\n");
        printAST(root, 0);

        printf("\nGenerated Code:\n");
        generateCode(root);

        FILE *file = fopen("ast.json", "w");
        if (file) {
            exportASTToJson(root, file);
            fclose(file);
            printf("\nAST exported to ast.json for visualization.\n");
        }
        freeAST(root);
    }
    return 0;
}
