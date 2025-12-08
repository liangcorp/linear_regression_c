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
	mkdir -p bin lib
	${CC} -Wall -D F_MEMORY_DEBUG -g -fPIC ./src/read_from_data_file.c -I ./src/include/ -I ./src/memory_debug/ -shared -o ./lib/libreaddata.so
	${CC} -Wall -D F_MEMORY_DEBUG -g -fPIC ./src/linear_regression/cost_function.c -I ./src/include/ -I ./src/memory_debug/ -shared -o ./lib/liblrcostfn.so
	${CC} -Wall -D F_MEMORY_DEBUG -g -fPIC ./src/linear_regression/gradient_descent.c -I ./src/include/ -I ./src/memory_debug/ -shared -o ./lib/liblrgrades.so
	${CC} -Wall -D F_MEMORY_DEBUG -g -fPIC ./src/linear_regression/normal_equation.c -I ./src/include/ -I ./src/memory_debug/ -shared -o ./lib/liblrnormalequation.so
	${CC} -Wall -D F_MEMORY_DEBUG -g -fPIC ./src/memory_debug/memory_debug.c -I ./src/include/ -I ./src/memory_debug/ -shared -o ./lib/libmemorydebug.so
	${CC} -Wall -D F_MEMORY_DEBUG -g -I ./src/memory_debug/ -L ./lib/ -o ./bin/feature_scale -lm ./src/feature_scale.c -l memorydebug
	${CC} -Wall -D F_MEMORY_DEBUG -g -I ./lib/ -I ./src/include/ -I ./src/memory_debug/ -c ./src/main.c -o ./lib/linear_regression.o
	${CC} -Wall -g -o ./bin/linear_regression ./lib/linear_regression.o -L ./lib/ -lm -l lrgrades -l lrcostfn -l readdata -l lrnormalequation -l memorydebug

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

clean:
	rm -rf ./bin
	rm -rf ./lib
