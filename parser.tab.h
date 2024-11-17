/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     INCLUDE = 258,
     HEADER = 259,
     LIBRARY = 260,
     CHAR = 261,
     DOUBLE = 262,
     FLOAT = 263,
     INT = 264,
     LONG = 265,
     UNSIGNED = 266,
     SHORT = 267,
     SIGNED = 268,
     STRUCT = 269,
     AUTO = 270,
     CONST = 271,
     VOID = 272,
     STRING_VALUE = 273,
     CHAR_VALUE = 274,
     INT_VALUE = 275,
     FLOAT_VALUE = 276,
     ID = 277,
     COLON = 278,
     DOT = 279,
     COMMA = 280,
     SEMICOLON = 281,
     IF = 282,
     FOR = 283,
     DO = 284,
     WHILE = 285,
     ELSE = 286,
     LPAREN = 287,
     RPAREN = 288,
     LCBRACE = 289,
     RCBRACE = 290,
     LSBRACE = 291,
     RSBRACE = 292,
     LABRACE = 293,
     RABRACE = 294,
     STAR = 295,
     AMPERSAND = 296,
     HASH = 297,
     EQUAL = 298,
     EXCLAMATION = 299,
     VBAR = 300,
     QMARK = 301,
     ARROW = 302,
     PLUS = 303,
     MINUS = 304,
     SLASH = 305,
     PERCENT = 306,
     GOTO = 307,
     CONTINUE = 308,
     BREAK = 309,
     RETURN = 310,
     SIZEOF = 311,
     STATIC = 312,
     TYPEDEF = 313,
     UNION = 314,
     VOLATILE = 315,
     OTHER = 316
   };
#endif
/* Tokens.  */
#define INCLUDE 258
#define HEADER 259
#define LIBRARY 260
#define CHAR 261
#define DOUBLE 262
#define FLOAT 263
#define INT 264
#define LONG 265
#define UNSIGNED 266
#define SHORT 267
#define SIGNED 268
#define STRUCT 269
#define AUTO 270
#define CONST 271
#define VOID 272
#define STRING_VALUE 273
#define CHAR_VALUE 274
#define INT_VALUE 275
#define FLOAT_VALUE 276
#define ID 277
#define COLON 278
#define DOT 279
#define COMMA 280
#define SEMICOLON 281
#define IF 282
#define FOR 283
#define DO 284
#define WHILE 285
#define ELSE 286
#define LPAREN 287
#define RPAREN 288
#define LCBRACE 289
#define RCBRACE 290
#define LSBRACE 291
#define RSBRACE 292
#define LABRACE 293
#define RABRACE 294
#define STAR 295
#define AMPERSAND 296
#define HASH 297
#define EQUAL 298
#define EXCLAMATION 299
#define VBAR 300
#define QMARK 301
#define ARROW 302
#define PLUS 303
#define MINUS 304
#define SLASH 305
#define PERCENT 306
#define GOTO 307
#define CONTINUE 308
#define BREAK 309
#define RETURN 310
#define SIZEOF 311
#define STATIC 312
#define TYPEDEF 313
#define UNION 314
#define VOLATILE 315
#define OTHER 316




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 13 "parser.y"
{
    int num;
    float fval;
    char* strval;
    ASTNode* node;
}
/* Line 1529 of yacc.c.  */
#line 178 "parser.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

