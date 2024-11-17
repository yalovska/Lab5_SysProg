#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"

ASTNode* createNode(char *value, ASTNode *left, ASTNode *right) {
    ASTNode *node = (ASTNode *)malloc(sizeof(ASTNode));
    node->value = strdup(value);
    node->left = left;
    node->right = right;
    return node;
}

void printAST(ASTNode *node, int level) {
    if (!node) return;
    for (int i = 0; i < level; i++) printf("   ");
    printf("%s\n", node->value);
    printAST(node->left, level + 1);
    printAST(node->right, level + 1);
}

void freeAST(ASTNode *node) {
    if (!node) return;
    freeAST(node->left);
    freeAST(node->right);
    free(node->value);
    free(node);
}

void exportASTToJson(ASTNode *node, FILE *file) {
    if (!node) return;
    fprintf(file, "{\"value\": \"%s\"", node->value);
    if (node->left || node->right) {
        fprintf(file, ", \"children\": [");
        if (node->left) exportASTToJson(node->left, file);
        if (node->left && node->right) fprintf(file, ", ");
        if (node->right) exportASTToJson(node->right, file);
        fprintf(file, "]");
    }
    fprintf(file, "}");
}

void generateCode(ASTNode *node) {
    if (!node) return;
    generateCode(node->left);
    generateCode(node->right);
    printf("PUSH %s\n", node->value);
}
