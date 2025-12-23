CC = clang

all:
	mkdir -p bin lib
	${CC} -g -Wall -fPIC ./src/read_from_data_file.c -I ./src/include/ -shared -o ./lib/libreaddata.so
	${CC} -g -Wall -fPIC ./src/linear_regression/cost_function.c -I ./src/include/ -shared -o ./lib/liblrcostfn.so
	${CC} -g -Wall -fPIC ./src/linear_regression/gradient_descent.c -I ./src/include/ -shared -o ./lib/liblrgrades.so
	${CC} -g -Wall -fPIC ./src/linear_regression/normal_equation.c -I ./src/include/ -shared -o ./lib/liblrnormalequation.so
	${CC} -g -Wall -o ./bin/feature_scale -lm ./src/feature_scale.c
	${CC} -g -Wall -I ./lib/ -I ./src/include/ -c ./src/main.c -o ./lib/linear_regression.o
	${CC} -g -Wall -o ./bin/linear_regression ./lib/linear_regression.o -L ./lib/ -lm -l lrcostfn -l lrgrades -l readdata -l lrnormalequation

	chmod +x ./bin/*

debug:
	mkdir -p bin lib
	${CC} -Wall -D DEBUG -g -fPIC ./src/read_from_data_file.c -I ./src/include/ -shared -o ./lib/libreaddata.so
	${CC} -Wall -D DEBUG -g -fPIC ./src/linear_regression/cost_function.c -I ./src/include/ -shared -o ./lib/liblrcostfn.so
	${CC} -Wall -D DEBUG -g -fPIC ./src/linear_regression/gradient_descent.c -I ./src/include/ -shared -o ./lib/liblrgrades.so
	${CC} -Wall -D DEBUG -g -fPIC ./src/linear_regression/normal_equation.c -I ./src/include/ -shared -o ./lib/liblrnormalequation.so
	${CC} -Wall -D DEBUG -g -o ./bin/feature_scale -lm ./src/feature_scale.c
	${CC} -Wall -D DEBUG -g -I ./lib/ -I ./src/include/ -c ./src/main.c -o ./lib/linear_regression.o
	${CC} -Wall -g -o ./bin/linear_regression ./lib/linear_regression.o -L ./lib/ -lm -l lrgrades -l lrcostfn -l readdata -l lrnormalequation

	chmod +x ./bin/*

timer:
	mkdir -p bin lib
	${CC} -Wall -D TIMER -g -fPIC ./src/read_from_data_file.c -I ./src/include/ -shared -o ./lib/libreaddata.so
	${CC} -Wall -D TIMER -g -fPIC ./src/linear_regression/cost_function.c -I ./src/include/ -shared -o ./lib/liblrcostfn.so
	${CC} -Wall -D TIMER -g -fPIC ./src/linear_regression/gradient_descent.c -I ./src/include/ -shared -o ./lib/liblrgrades.so
	${CC} -Wall -D TIMER -g -fPIC ./src/linear_regression/normal_equation.c -I ./src/include/ -shared -o ./lib/liblrnormalequation.so
	${CC} -Wall -D TIMER -g -o ./bin/feature_scale -lm ./src/feature_scale.c
	${CC} -Wall -D TIMER -g -I ./lib/ -I ./src/include/ -c ./src/main.c -o ./lib/linear_regression.o
	${CC} -g -o ./bin/linear_regression ./lib/linear_regression.o -L ./lib/ -lm -l lrgrades -l lrcostfn -l readdata -l lrnormalequation

	chmod +x ./bin/*

memory_debug:
	mkdir -p bin libs
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -I ./libs/ -I ./src/include -c ./src/memory_debug/memory_debug.c -o ./libs/memory_debug.o
	ar rcs ./libs/memory_debug.a ./libs/memory_debug.o
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -I ./libs/ -I ./src/include -I ./src/memory_debug -c ./src/read_from_data_file.c -o ./libs/read_from_data_file.o
	ar rcs ./libs/read_from_data_file.a ./libs/read_from_data_file.o
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -I ./libs/ -I ./src/include -c ./src/linear_regression/cost_function.c -o ./libs/cost_function.o
	ar rcs ./libs/cost_function.a ./libs/cost_function.o
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -I ./libs/ -I ./src/include -c ./src/linear_regression/gradient_descent.c -o ./libs/gradient_descent.o
	ar rcs ./libs/gradient_descent.a ./libs/gradient_descent.o
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -I ./libs/ -I ./src/include -I ./src/memory_debug -c ./src/linear_regression/normal_equation.c -o ./libs/normal_equation.o
	ar rcs ./libs/normal_equation.a ./libs/normal_equation.o
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -I ./libs/ -I ./src/include -I ./src/memory_debug -c ./src/main.c -o ./libs/main.o
	ar rcs ./libs/main.a ./libs/main.o
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -I ./libs/ -I ./src/include -I ./src/memory_debug -c ./src/feature_scale.c -o ./libs/feature_scale.o
	ar rcs ./libs/feature_scale.a ./libs/feature_scale.o
	cd ..
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -o ./bin/feature_scale ./libs/feature_scale.a ./libs/memory_debug.a
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -o ./bin/linear_regression ./libs/main.o ./libs/cost_function.a ./libs/memory_debug.a ./libs/gradient_descent.a  ./libs/read_from_data_file.a ./libs/normal_equation.a
	chmod +x ./bin/*

release:
	mkdir -p bin lib
	${CC} -fPIC ./src/read_from_data_file.c -I ./src/include/ -shared -o ./lib/libreaddata.so
	${CC} -fPIC ./src/linear_regression/cost_function.c -I ./src/include/ -shared -o ./lib/liblrcostfn.so
	${CC} -fPIC ./src/linear_regression/gradient_descent.c -I ./src/include/ -shared -o ./lib/liblrgrades.so
	${CC} -fPIC ./src/linear_regression/normal_equation.c -I ./src/include/ -shared -o ./lib/liblrnormalequation.so
	${CC} -o ./bin/feature_scale -lm ./src/feature_scale.c
	${CC} -I ./lib/ -I ./src/include/ -c ./src/main.c -o ./lib/linear_regression.o
	${CC} -o ./bin/linear_regression ./lib/linear_regression.o -L ./lib/ -lm -l lrcostfn -l lrgrades -l readdata -l lrnormalequation

	chmod +x ./bin/*

static:
	mkdir -p bin lib
	${CC} -Wall -fPIC ./src/read_from_data_file.c -I ./src/include/ ./src/linear_regression/cost_function.c ./src/linear_regression/gradient_descent.c ./src/linear_regression/normal_equation.c ./src/main.c -o ./bin/linear_regression
	${CC} -Wall -o ./bin/feature_scale -lm ./src/feature_scale.c
	chmod +x ./bin/*

format:
	find -name *.h -exec clang-format -i {} \;
	find -name *.c -exec clang-format -i {} \;

clean:
	rm -rf ./bin
	rm -rf ./lib
