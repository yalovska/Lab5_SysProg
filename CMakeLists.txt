cmake_minimum_required(VERSION 3.10)
project(niyacc)

set(CMAKE_C_STANDARD 11)

# Задаємо шлях до бібліотеки libfl
set(FL_LIBRARY /usr/local/Cellar/flex/2.6.4_2/lib/libfl.dylib)

# Пакети Flex та Bison
find_package(FLEX REQUIRED)
find_package(BISON REQUIRED)

# Генеруємо цільові файли для Flex та Bison
FLEX_TARGET(Lexer lexer.l ${CMAKE_CURRENT_BINARY_DIR}/lex.yy.c)
BISON_TARGET(Parser parser.y ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.c)

# Додаємо загальний виконуваний файл
add_executable(niyacc ${BISON_Parser_OUTPUTS} ${FLEX_Lexer_OUTPUTS} ast.c)

# Додаємо каталоги заголовкових файлів та бібліотеку libfl
target_include_directories(niyacc PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(niyacc ${FL_LIBRARY})
