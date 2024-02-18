CC = clang

all:
	mkdir -p bin libs
	${CC} -g -fPIC ./src/read_from_data_file.c -I ./src/include/ -shared -o ./libs/libreaddata.so
	${CC} -g -fPIC ./src/linear_regression/cost_function.c -I ./src/include/ -shared -o ./libs/liblrcostfn.so
	${CC} -g -fPIC ./src/linear_regression/gradient_descent.c -I ./src/include/ -shared -o ./libs/liblrgrades.so
	${CC} -g -fPIC ./src/linear_regression/normal_equation.c -I ./src/include/ -shared -o ./libs/liblrnormalequation.so
	${CC} -g -o ./bin/feature_scale -lm ./src/feature_scale.c
	${CC} -g -I ./libs/ -I ./src/include/ -c ./src/lr.c -o ./libs/lr.o
	${CC} -g -o ./bin/lr ./libs/lr.o -L ./libs/ -lm -l lrcostfn -l lrgrades -l readdata -l lrnormalequation

	chmod +x ./bin/*

debug:
	mkdir -p bin libs
	${CC} -D DEBUG -g -fPIC ./src/read_from_data_file.c -I ./src/include/ -shared -o ./libs/libreaddata.so
	${CC} -D DEBUG -g -fPIC ./src/linear_regression/cost_function.c -I ./src/include/ -shared -o ./libs/liblrcostfn.so
	${CC} -D DEBUG -g -fPIC ./src/linear_regression/gradient_descent.c -I ./src/include/ -shared -o ./libs/liblrgrades.so
	${CC} -D DEBUG -g -fPIC ./src/linear_regression/normal_equation.c -I ./src/include/ -shared -o ./libs/liblrnormalequation.so
	${CC} -D DEBUG -g -o ./bin/feature_scale -lm ./src/feature_scale.c
	${CC} -D DEBUG -g -I ./libs/ -I ./src/include/ -c ./src/lr.c -o ./libs/lr.o
	${CC} -g -o ./bin/lr ./libs/lr.o -L ./libs/ -lm -l lrgrades -l lrcostfn -l readdata -l lrnormalequation

	chmod +x ./bin/*

timer:
	mkdir -p bin libs
	${CC} -D TIMER -g -fPIC ./src/read_from_data_file.c -I ./src/include/ -shared -o ./libs/libreaddata.so
	${CC} -D TIMER -g -fPIC ./src/linear_regression/cost_function.c -I ./src/include/ -shared -o ./libs/liblrcostfn.so
	${CC} -D TIMER -g -fPIC ./src/linear_regression/gradient_descent.c -I ./src/include/ -shared -o ./libs/liblrgrades.so
	${CC} -D TIMER -g -fPIC ./src/linear_regression/normal_equation.c -I ./src/include/ -shared -o ./libs/liblrnormalequation.so
	${CC} -D TIMER -g -o ./bin/feature_scale -lm ./src/feature_scale.c
	${CC} -D TIMER -g -I ./libs/ -I ./src/include/ -c ./src/lr.c -o ./libs/lr.o
	${CC} -g -o ./bin/lr ./libs/lr.o -L ./libs/ -lm -l lrgrades -l lrcostfn -l readdata -l lrnormalequation

	chmod +x ./bin/*


release:
	mkdir -p bin libs
	${CC} -fPIC ./src/read_from_data_file.c -I ./src/include/ -shared -o ./libs/libreaddata.so
	${CC} -fPIC ./src/linear_regression/cost_function.c -I ./src/include/ -shared -o ./libs/liblrcostfn.so
	${CC} -fPIC ./src/linear_regression/gradient_descent.c -I ./src/include/ -shared -o ./libs/liblrgrades.so
	${CC} -fPIC ./src/linear_regression/normal_equation.c -I ./src/include/ -shared -o ./libs/liblrnormalequation.so
	${CC} -o ./bin/feature_scale -lm ./src/feature_scale.c
	${CC} -I ./libs/ -I ./src/include/ -c ./src/lr.c -o ./libs/lr.o
	${CC} -o ./bin/lr ./libs/lr.o -L ./libs/ -lm -l lrcostfn -l lrgrades -l readdata -l lrnormalequation

	chmod +x ./bin/*

static:
	mkdir -p bin libs
	${CC} -fPIC ./src/read_from_data_file.c -I ./src/include/ ./src/linear_regression/cost_function.c ./src/linear_regression/gradient_descent.c ./src/linear_regression/normal_equation.c ./src/lr.c -o ./bin/lr
	${CC} -o ./bin/feature_scale -lm ./src/feature_scale.c

	chmod +x ./bin/*

clean:
	rm -rf ./bin/*
	rm -rf ./libs/*
