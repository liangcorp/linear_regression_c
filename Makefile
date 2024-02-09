CC = clang

all:
	mkdir -p bin libs
	${CC} -g -fPIC ./src/read_from_data_file.c -shared -o ./libs/libreaddata.so
	${CC} -g -fPIC ./src/linear_regression/cost_function.c -I ./src/include/ -shared -o ./libs/liblrcostfn.so
	${CC} -g -fPIC ./src/linear_regression/gradient_descent.c -I ./src/include/ -shared -o ./libs/liblrgrades.so
	${CC} -g -fPIC ./src/linear_regression/normal_equation.c -I ./src/include/ -shared -o ./libs/liblrnorequa.so
	${CC} -g -fPIC ./src/feature_scale.c -I ./src/include/ -shared -o ./libs/libfeatscale.so
	${CC} -g -I ./libs/ -I ./src/include/ -c ./src/main.c -o ./libs/main.o
	${CC} -g -o ./bin/ml_c ./libs/main.o -L ./libs/ -lm -l lrcostfn -l lrgrades -l readdata -l featscale -l lrnorequa

	chmod +x ./bin/ml_c

debug:
	mkdir -p bin libs
	${CC} -D DEBUG -g -fPIC ./src/read_from_data_file.c -shared -o ./libs/libreaddata.so
	${CC} -D DEBUG -g -fPIC ./src/linear_regression/cost_function.c -shared -o ./libs/liblrcostfn.so
	${CC} -D DEBUG -g -fPIC ./src/linear_regression/gradient_descent.c -shared -o ./libs/liblrgrades.so
	${CC} -D DEBUG -g -fPIC ./src/linear_regression/normal_equation.c -shared -o ./libs/liblrnorequa.so
	${CC} -D DEBUG -g -fPIC ./src/feature_scale.c -shared -o ./libs/libfeatscale.so
	${CC} -D DEBUG -g -I ./libs/ -c ./src/main.c -o ./libs/main.o
	${CC} -g -o ./bin/ml_c ./libs/main.o -L ./libs/ -lm -l lrgrades -l lrcostfn -l readdata -l featscale -l lrnorequa

	chmod +x ./bin/ml_c

timer:
	mkdir -p bin libs
	${CC} -D TIMER -g -fPIC ./src/read_from_data_file.c -shared -o ./libs/libreaddata.so
	${CC} -D TIMER -g -fPIC ./src/linear_regression/cost_function.c -shared -o ./libs/liblrcostfn.so
	${CC} -D TIMER -g -fPIC ./src/linear_regression/gradient_descent.c -shared -o ./libs/liblrgrades.so
	${CC} -D TIMER -g -fPIC ./src/linear_regression/normal_equation.c -shared -o ./libs/liblrnorequa.so
	${CC} -D TIMER -g -fPIC ./src/feature_scale.c -shared -o ./libs/libfeatscale.so
	${CC} -D TIMER -g -I ./libs/ -c ./src/main.c -o ./libs/main.o
	${CC} -D TIMER -g -o ./bin/ml_c ./libs/main.o -L ./libs/ -lm -l lrgrades -l lrcostfn -l readdata -l featscale -l lrnorequa

	chmod +x ./bin/ml_c

clean:
	rm -rf ./bin/*
	rm -rf ./libs/*
