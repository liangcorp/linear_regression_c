CC = clang

all:
	mkdir -p bin libs
	${CC} -g -Wall -fPIC ./src/read_from_data_file.c -I ./src/include/ -shared -o ./libs/libreaddata.so
	${CC} -g -Wall -fPIC ./src/linear_regression/cost_function.c -I ./src/include/ -shared -o ./libs/liblrcostfn.so
	${CC} -g -Wall -fPIC ./src/linear_regression/gradient_descent.c -I ./src/include/ -shared -o ./libs/liblrgrades.so
	${CC} -g -Wall -fPIC ./src/linear_regression/normal_equation.c -I ./src/include/ -shared -o ./libs/liblrnormalequation.so
	${CC} -g -Wall -o ./bin/feature_scale -lm ./src/feature_scale.c
	${CC} -g -Wall -I ./libs/ -I ./src/include/ -c ./src/main.c -o ./libs/linear_regression.o
	${CC} -g -Wall -o ./bin/linear_regression ./libs/linear_regression.o -L ./libs/ -lm -l lrcostfn -l lrgrades -l readdata -l lrnormalequation

	chmod +x ./bin/*

debug:
	mkdir -p bin libs
	${CC} -Wall -D DEBUG -g -fPIC ./src/read_from_data_file.c -I ./src/include/ -shared -o ./libs/libreaddata.so
	${CC} -Wall -D DEBUG -g -fPIC ./src/linear_regression/cost_function.c -I ./src/include/ -shared -o ./libs/liblrcostfn.so
	${CC} -Wall -D DEBUG -g -fPIC ./src/linear_regression/gradient_descent.c -I ./src/include/ -shared -o ./libs/liblrgrades.so
	${CC} -Wall -D DEBUG -g -fPIC ./src/linear_regression/normal_equation.c -I ./src/include/ -shared -o ./libs/liblrnormalequation.so
	${CC} -Wall -D DEBUG -g -o ./bin/feature_scale -lm ./src/feature_scale.c
	${CC} -Wall -D DEBUG -g -I ./libs/ -I ./src/include/ -c ./src/main.c -o ./libs/linear_regression.o
	${CC} -Wall -g -o ./bin/linear_regression ./libs/linear_regression.o -L ./libs/ -lm -l lrgrades -l lrcostfn -l readdata -l lrnormalequation

	chmod +x ./bin/*

timer:
	mkdir -p bin libs
	${CC} -Wall -D TIMER -g -fPIC ./src/read_from_data_file.c -I ./src/include/ -shared -o ./libs/libreaddata.so
	${CC} -Wall -D TIMER -g -fPIC ./src/linear_regression/cost_function.c -I ./src/include/ -shared -o ./libs/liblrcostfn.so
	${CC} -Wall -D TIMER -g -fPIC ./src/linear_regression/gradient_descent.c -I ./src/include/ -shared -o ./libs/liblrgrades.so
	${CC} -Wall -D TIMER -g -fPIC ./src/linear_regression/normal_equation.c -I ./src/include/ -shared -o ./libs/liblrnormalequation.so
	${CC} -Wall -D TIMER -g -o ./bin/feature_scale -lm ./src/feature_scale.c
	${CC} -Wall -D TIMER -g -I ./libs/ -I ./src/include/ -c ./src/main.c -o ./libs/linear_regression.o
	${CC} -g -o ./bin/linear_regression ./libs/linear_regression.o -L ./libs/ -lm -l lrgrades -l lrcostfn -l readdata -l lrnormalequation

	chmod +x ./bin/*


release:
	mkdir -p bin libs
	${CC} -fPIC ./src/read_from_data_file.c -I ./src/include/ -shared -o ./libs/libreaddata.so
	${CC} -fPIC ./src/linear_regression/cost_function.c -I ./src/include/ -shared -o ./libs/liblrcostfn.so
	${CC} -fPIC ./src/linear_regression/gradient_descent.c -I ./src/include/ -shared -o ./libs/liblrgrades.so
	${CC} -fPIC ./src/linear_regression/normal_equation.c -I ./src/include/ -shared -o ./libs/liblrnormalequation.so
	${CC} -o ./bin/feature_scale -lm ./src/feature_scale.c
	${CC} -I ./libs/ -I ./src/include/ -c ./src/main.c -o ./libs/linear_regression.o
	${CC} -o ./bin/linear_regression ./libs/linear_regression.o -L ./libs/ -lm -l lrcostfn -l lrgrades -l readdata -l lrnormalequation

	chmod +x ./bin/*

static:
	mkdir -p bin libs
	${CC} -Wall -fPIC ./src/read_from_data_file.c -I ./src/include/ ./src/linear_regression/cost_function.c ./src/linear_regression/gradient_descent.c ./src/linear_regression/normal_equation.c ./src/main.c -o ./bin/linear_regression
	${CC} -Wall -o ./bin/feature_scale -lm ./src/feature_scale.c

	chmod +x ./bin/*

clean:
	rm -rf ./bin
	rm -rf ./libs
