// ast.h
#ifndef AST_H
#define AST_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct ASTNode {
    char *value;
    struct ASTNode *left;
    struct ASTNode *right;
} ASTNode;

ASTNode* createNode(char *value, ASTNode *left, ASTNode *right);
void printAST(ASTNode *node, int level);
void freeAST(ASTNode *node);
void exportASTToJson(ASTNode *node, FILE *file);
void generateCode(ASTNode *node);

#endif
