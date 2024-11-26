%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Оголошення функцій
int yylex(void);
int yyerror(const char *s);

// Таблиця змінних
#define MAX_VARIABLES 100
typedef struct {
    char *name;
    int value;
} Variable;

Variable symbol_table[MAX_VARIABLES];
int symbol_count = 0;

// Функції роботи з таблицею змінних
int get_variable_value(const char *name);
void set_variable_value(const char *name, int value);
void generate_code(const char *name, int value);

// AST
typedef struct ASTNode {
    char *type;
    char *label;
    int value;
    struct ASTNode *left;
    struct ASTNode *right;
} ASTNode;

ASTNode *root_node = NULL; // Корінь дерева AST
ASTNode *create_node(const char *type, const char *label, int value, ASTNode *left, ASTNode *right);
void add_to_program(ASTNode *expr);
void print_ast(ASTNode *node, FILE *file);
void free_ast(ASTNode *node);

// Файли для виводу
FILE *output_file;
FILE *ast_file;

%}

%union {
    int intval;
    char *strval;
    struct ASTNode *node;
}

%token <intval> NUMBER
%token <strval> IDENTIFIER
%type <node> expression term factor

%%
program:
    statements
;

statements:
    statements statement
    | statement
;

statement:
    IDENTIFIER '=' expression ';' {
        set_variable_value($1, $3->value);
        generate_code($1, $3->value);
        printf("Assignment: %s = %d\n", $1, $3->value);

        // Додаємо вираз до програми (AST)
        ASTNode *new_expr = create_node("EXPR", $1, $3->value, $3, NULL);
        add_to_program(new_expr);

        // Виводимо AST у файл
        if (ast_file) {
            print_ast(root_node, ast_file);
        }
        free($1);
    }
;

expression:
    expression '+' term    { $$ = create_node("ADD", "+", $1->value + $3->value, $1, $3); }
    | expression '-' term  { $$ = create_node("SUB", "-", $1->value - $3->value, $1, $3); }
    | term                 { $$ = $1; }
;

term:
    term '*' factor        { $$ = create_node("MUL", "*", $1->value * $3->value, $1, $3); }
    | term '/' factor      {
        if ($3->value == 0) {
            yyerror("Division by zero");
            exit(1);
        }
        $$ = create_node("DIV", "/", $1->value / $3->value, $1, $3);
    }
    | factor               { $$ = $1; }
;

factor:
    NUMBER                 { $$ = create_node("NUM", NULL, $1, NULL, NULL); }
    | IDENTIFIER           { $$ = create_node("VAR", $1, get_variable_value($1), NULL, NULL); free($1); }
    | '(' expression ')'   { $$ = $2; }
;

%%
int yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}

// Таблиця змінних
int get_variable_value(const char *name) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbol_table[i].name, name) == 0) {
            return symbol_table[i].value;
        }
    }
    fprintf(stderr, "Error: Undefined variable '%s'\n", name);
    exit(1);
}

void set_variable_value(const char *name, int value) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbol_table[i].name, name) == 0) {
            symbol_table[i].value = value;
            return;
        }
    }
    if (symbol_count < MAX_VARIABLES) {
        symbol_table[symbol_count].name = strdup(name);
        symbol_table[symbol_count].value = value;
        symbol_count++;
    } else {
        fprintf(stderr, "Error: Symbol table overflow\n");
    }
}

void generate_code(const char *name, int value) {
    if (output_file) {
        fprintf(output_file, "int %s = %d;\n", name, value);
    }
}

ASTNode *create_node(const char *type, const char *label, int value, ASTNode *left, ASTNode *right) {
    ASTNode *node = (ASTNode *)malloc(sizeof(ASTNode));
    if (!node) {
        fprintf(stderr, "Error: Memory allocation failed for AST node\n");
        exit(1);
    }
    node->type = strdup(type);
    node->label = label ? strdup(label) : NULL;
    node->value = value;
    node->left = left;
    node->right = right;
    return node;
}

// Додаємо новий вираз до кореня дерева AST
void add_to_program(ASTNode *expr) {
    if (!root_node) {
        root_node = create_node("PROGRAM", "root", 0, NULL, NULL);
    }
    ASTNode *current = root_node->left;
    if (!current) {
        root_node->left = expr;
    } else {
        while (current->right) {
            current = current->right;
        }
        current->right = expr;
    }
}

void print_ast(ASTNode *node, FILE *file) {
    static int counter = 0;
    if (!node) return;

    fprintf(file, "node%d [label=\"%s\\n%s%d\"];\n", counter, node->type,
            node->label ? node->label : "", node->value);
    int current = counter++;

    if (node->left) {
        fprintf(file, "node%d -> node%d;\n", current, counter);
        print_ast(node->left, file);
    }
    if (node->right) {
        fprintf(file, "node%d -> node%d;\n", current, counter);
        print_ast(node->right, file);
    }
}

void free_ast(ASTNode *node) {
    if (!node) return;
    free(node->type);
    if (node->label) free(node->label);
    free_ast(node->left);
    free_ast(node->right);
    free(node);
}

int main() {
    printf("Enter expressions:\n");

    output_file = fopen("output.c", "w");
    ast_file = fopen("ast.dot", "w");

    if (!output_file || !ast_file) {
        fprintf(stderr, "Error: Unable to open output or AST file\n");
        return 1;
    }

    fprintf(output_file, "#include <stdio.h>\n\nint main() {\n");
    fprintf(ast_file, "digraph AST {\n");

    yyparse();

    fprintf(output_file, "    return 0;\n}\n");
    fprintf(ast_file, "}\n");
    fclose(output_file);
    fclose(ast_file);

    printf("AST generated in 'ast.dot'.\n");
    printf("Code generated in 'output.c'.\n");
    return 0;
}
