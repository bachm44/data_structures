LIB_NAME = libdata_structures

CC = gcc
GCOV = gcov
GCOVR = gcovr

TST_LIBS = -lcheck -lm -lpthread -lrt -lsubunit
COV_LIBS = -lgcov -coverage

SRC_DIR = src
TST_DIR = test
OUT_DIR = build
COV_DIR = coverage
UTL_DIR = util

SRCS = $(wildcard $(SRC_DIR)/*.c)
COVS = $(wildcard $(COV_DIR)/*.gcno)
OBJS = $(SRCS:$(SRC_DIR)/%.c=$(OUT_DIR)/%.o)
TST_SRCS = $(wildcard $(TST_DIR)/*.c)
TST_OBJS = $(TST_SRCS:$(TST_DIR)/%.c=$(OUT_DIR/%.o))

GCOV_FLAGS = -r . --html --html-details
CFLAGS = -c -Wall -Wextra
DEBUG_FLAGS = -g -Wall -Wextra
PROFILE_FLAGS = -fprofile-arcs -ftest-coverage


.PHONY: clean valgrind valgrind-v test coverage format

	
$(LIB_NAME):
	mkdir -p $(OUT_DIR)
	$(CC) $(DEBUG_FLAGS) $(PROFILE_FLAGS) -c $(SRC_DIR)/*.c $(UTL_DIR)/*.c -I$(UTL_DIR) -I$(SRC_DIR)
	ar -rcs $(OUT_DIR)/$(LIB_NAME).a *.o 
	rm -f *.o

test_src: $(LIB_NAME)
	$(CC) $(DEBUG_FLAGS) $(PROFILE_FLAGS) $(TST_DIR)/*.c $(UTL_DIR)/*.c $(TST_LIBS) -L$(OUT_DIR) -l:$(LIB_NAME).a -o $(OUT_DIR)/test_src -I$(UTL_DIR) -I$(SRC_DIR) 
	mkdir -p $(COV_DIR)
	mv *.gcno $(COV_DIR)

test: test_src
	./$(OUT_DIR)/test_src
	mv *.gcda $(COV_DIR)

coverage.gcov: test
	$(GCOV) $(SRCS) $(COVS)
	mkdir -p $(COV_DIR)
	mv *.gcov $(COV_DIR)

coverage: coverage.gcov

valgrind: test_src
	valgrind --tool=memcheck --leak-check=full --show-reachable=yes -s ./$(OUT_DIR)/test_src 
	mv *.gcda $(COV_DIR)

valgrind-v: test_src
	valgrind --tool=memcheck -v --leak-check=full --show-reachable=yes ./$(OUT_DIR)/test_src
	mv *.gcda $(COV_DIR)

format:
	clang-format -i $(UTL_DIR)/*.[ch] $(SRC_DIR)/*.[ch] $(TST_DIR)/*.[ch]

clean:
	-rm -rf $(OUT_DIR) $(COV_DIR)

gdb:
	gdb ./build/test_src