cmake_minimum_required(VERSION 3.23)
project(Lab5_sys C)

set(CMAKE_C_STANDARD 11)

find_package(FLEX REQUIRED)
find_package(BISON REQUIRED)

FLEX_TARGET(Lexer lexer.l ${CMAKE_CURRENT_BINARY_DIR}/lex.yy.c)
BISON_TARGET(Parser parser.y ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.c)


add_executable(Lab5_sys
        ${FLEX_Lexer_OUTPUTS}
        ${BISON_Parser_OUTPUTS}
        )

target_link_libraries(Lab5_sys -lfl)
