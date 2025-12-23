CC = clang
all:
	mkdir -p bin
	mkdir -p lib
	${CC} -Wall -Werror -Wpedantic -std=c89 -g -I ./lib/ -I ./src/include -c ./src/read_from_data_file.c -o ./lib/read_from_data_file.o
	${CC} -Wall -Werror -Wpedantic -std=c89 -g -I ./lib/ -I ./src/include -c ./src/linear_regression/cost_function.c -o ./lib/cost_function.o
	${CC} -Wall -Werror -Wpedantic -std=c89 -g -I ./lib/ -I ./src/include -c ./src/linear_regression/gradient_descent.c -o ./lib/gradient_descent.o
	${CC} -Wall -Werror -Wpedantic -std=c89 -g -I ./lib/ -I ./src/include -c ./src/linear_regression/normal_equation.c -o ./lib/normal_equation.o
	${CC} -Wall -Werror -Wpedantic -std=c89 -g -I ./lib/ -I ./src/include -c ./src/main.c -o ./lib/main.o
	${CC} -Wall -Werror -Wpedantic -std=c89 -g -I ./lib/ -I ./src/include -c ./src/feature_scale.c -o ./lib/feature_scale.o
	ar rcs ./lib/libread_from_data_file.a ./lib/read_from_data_file.o
	ar rcs ./lib/libcost_function.a ./lib/cost_function.o
	ar rcs ./lib/libgradient_descent.a ./lib/gradient_descent.o
	ar rcs ./lib/libnormal_equation.a ./lib/normal_equation.o
	ar rcs ./lib/libfeature_scale.a ./lib/feature_scale.o
	cd ..
	${CC} -Wall -Werror -Wpedantic -std=c89 -g -o ./bin/feature_scale ./lib/libfeature_scale.a
	${CC} -Wall -Werror -Wpedantic -std=c89 -g -o ./bin/linear_regression ./lib/main.o ./lib/libcost_function.a ./lib/libgradient_descent.a  ./lib/libread_from_data_file.a ./lib/libnormal_equation.a
	chmod +x ./bin/*

dynamic_linked:
	mkdir -p bin
	mkdir -p lib
	${CC} -g -Wall -Werror -Wpedantic -std=c89 -fPIC ./src/read_from_data_file.c -I ./src/include/ -shared -o ./lib/libreaddata.so
	${CC} -g -Wall -Werror -Wpedantic -std=c89 -fPIC ./src/linear_regression/cost_function.c -I ./src/include/ -shared -o ./lib/liblrcostfn.so
	${CC} -g -Wall -Werror -Wpedantic -std=c89 -fPIC ./src/linear_regression/gradient_descent.c -I ./src/include/ -shared -o ./lib/liblrgrades.so
	${CC} -g -Wall -Werror -Wpedantic -std=c89 -fPIC ./src/linear_regression/normal_equation.c -I ./src/include/ -shared -o ./lib/liblrnormalequation.so
	${CC} -g -Wall -Werror -Wpedantic -std=c89 -o ./bin/feature_scale -lm ./src/feature_scale.c
	${CC} -g -Wall -Werror -Wpedantic -std=c89 -I ./lib/ -I ./src/include/ -c ./src/main.c -o ./lib/linear_regression.o
	${CC} -g -Wall -Werror -Wpedantic -std=c89 -o ./bin/linear_regression ./lib/linear_regression.o -L ./lib/ -lm -l lrcostfn -l lrgrades -l readdata -l lrnormalequation
	chmod +x ./bin/*

debug:
	mkdir -p bin
	mkdir -p lib
	${CC} -Wall -Werror -Wpedantic -D DEBUG -std=c89 -g -I ./lib/ -I ./src/include -c ./src/read_from_data_file.c -o ./lib/read_from_data_file.o
	${CC} -Wall -Werror -Wpedantic -D DEBUG -std=c89 -g -I ./lib/ -I ./src/include -c ./src/linear_regression/cost_function.c -o ./lib/cost_function.o
	${CC} -Wall -Werror -Wpedantic -D DEBUG -std=c89 -g -I ./lib/ -I ./src/include -c ./src/linear_regression/gradient_descent.c -o ./lib/gradient_descent.o
	${CC} -Wall -Werror -Wpedantic -D DEBUG -std=c89 -g -I ./lib/ -I ./src/include -c ./src/linear_regression/normal_equation.c -o ./lib/normal_equation.o
	${CC} -Wall -Werror -Wpedantic -D DEBUG -std=c89 -g -I ./lib/ -I ./src/include -c ./src/main.c -o ./lib/main.o
	${CC} -Wall -Werror -Wpedantic -D DEBUG -std=c89 -g -I ./lib/ -I ./src/include -c ./src/feature_scale.c -o ./lib/feature_scale.o
	ar rcs ./lib/libread_from_data_file.a ./lib/read_from_data_file.o
	ar rcs ./lib/libcost_function.a ./lib/cost_function.o
	ar rcs ./lib/libgradient_descent.a ./lib/gradient_descent.o
	ar rcs ./lib/libnormal_equation.a ./lib/normal_equation.o
	ar rcs ./lib/libfeature_scale.a ./lib/feature_scale.o
	cd ..
	${CC} -Wall -Werror -Wpedantic -D DEBUG -std=c89 -g -o ./bin/feature_scale ./lib/libfeature_scale.a
	${CC} -Wall -Werror -Wpedantic -D DEBUG -std=c89 -g -o ./bin/linear_regression ./lib/main.o ./lib/libcost_function.a ./lib/libgradient_descent.a  ./lib/libread_from_data_file.a ./lib/libnormal_equation.a
	chmod +x ./bin/*

timer:
	mkdir -p bin
	mkdir -p lib
	${CC} -Wall -Werror -Wpedantic -D TIMER -std=c89 -g -I ./lib/ -I ./src/include -c ./src/read_from_data_file.c -o ./lib/read_from_data_file.o
	${CC} -Wall -Werror -Wpedantic -D TIMER -std=c89 -g -I ./lib/ -I ./src/include -c ./src/linear_regression/cost_function.c -o ./lib/cost_function.o
	${CC} -Wall -Werror -Wpedantic -D TIMER -std=c89 -g -I ./lib/ -I ./src/include -c ./src/linear_regression/gradient_descent.c -o ./lib/gradient_descent.o
	${CC} -Wall -Werror -Wpedantic -D TIMER -std=c89 -g -I ./lib/ -I ./src/include -c ./src/linear_regression/normal_equation.c -o ./lib/normal_equation.o
	${CC} -Wall -Werror -Wpedantic -D TIMER -std=c89 -g -I ./lib/ -I ./src/include -c ./src/main.c -o ./lib/main.o
	${CC} -Wall -Werror -Wpedantic -D TIMER -std=c89 -g -I ./lib/ -I ./src/include -c ./src/feature_scale.c -o ./lib/feature_scale.o
	ar rcs ./lib/libread_from_data_file.a ./lib/read_from_data_file.o
	ar rcs ./lib/libcost_function.a ./lib/cost_function.o
	ar rcs ./lib/libgradient_descent.a ./lib/gradient_descent.o
	ar rcs ./lib/libnormal_equation.a ./lib/normal_equation.o
	ar rcs ./lib/libfeature_scale.a ./lib/feature_scale.o
	cd ..
	${CC} -Wall -Werror -Wpedantic -D TIMER -std=c89 -g -o ./bin/feature_scale ./lib/libfeature_scale.a
	${CC} -Wall -Werror -Wpedantic -D TIMER -std=c89 -g -o ./bin/linear_regression ./lib/main.o ./lib/libcost_function.a ./lib/libgradient_descent.a  ./lib/libread_from_data_file.a ./lib/libnormal_equation.a
	chmod +x ./bin/*

memory_debug:
	mkdir -p bin
	mkdir -p lib
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -I ./lib/ -I ./src/include -c ./src/memory_debug/memory_debug.c -o ./lib/memory_debug.o
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -I ./lib/ -I ./src/include -I ./src/memory_debug -c ./src/read_from_data_file.c -o ./lib/read_from_data_file.o
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -I ./lib/ -I ./src/include -c ./src/linear_regression/cost_function.c -o ./lib/cost_function.o
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -I ./lib/ -I ./src/include -c ./src/linear_regression/gradient_descent.c -o ./lib/gradient_descent.o
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -I ./lib/ -I ./src/include -I ./src/memory_debug -c ./src/linear_regression/normal_equation.c -o ./lib/normal_equation.o
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -I ./lib/ -I ./src/include -I ./src/memory_debug -c ./src/main.c -o ./lib/main.o
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -I ./lib/ -I ./src/include -I ./src/memory_debug -c ./src/feature_scale.c -o ./lib/feature_scale.o
	ar rcs ./lib/libmemory_debug.a ./lib/memory_debug.o
	ar rcs ./lib/libread_from_data_file.a ./lib/read_from_data_file.o
	ar rcs ./lib/libcost_function.a ./lib/cost_function.o
	ar rcs ./lib/libgradient_descent.a ./lib/gradient_descent.o
	ar rcs ./lib/libnormal_equation.a ./lib/normal_equation.o
	ar rcs ./lib/libfeature_scale.a ./lib/feature_scale.o
	cd ..
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -o ./bin/feature_scale ./lib/libfeature_scale.a ./lib/libmemory_debug.a
	${CC} -Wall -Werror -Wpedantic -D F_MEMORY_DEBUG -std=c89 -g -o ./bin/linear_regression ./lib/main.o ./lib/libcost_function.a ./lib/libmemory_debug.a ./lib/libgradient_descent.a  ./lib/libread_from_data_file.a ./lib/libnormal_equation.a
	chmod +x ./bin/*

release:
	mkdir -p bin
	mkdir -p lib
	${CC} -Wall -Werror -Wpedantic -std=c89 -I ./lib/ -I ./src/include -c ./src/read_from_data_file.c -o ./lib/read_from_data_file.o
	${CC} -Wall -Werror -Wpedantic -std=c89 -I ./lib/ -I ./src/include -c ./src/linear_regression/cost_function.c -o ./lib/cost_function.o
	${CC} -Wall -Werror -Wpedantic -std=c89 -I ./lib/ -I ./src/include -c ./src/linear_regression/gradient_descent.c -o ./lib/gradient_descent.o
	${CC} -Wall -Werror -Wpedantic -std=c89 -I ./lib/ -I ./src/include -c ./src/linear_regression/normal_equation.c -o ./lib/normal_equation.o
	${CC} -Wall -Werror -Wpedantic -std=c89 -I ./lib/ -I ./src/include -c ./src/main.c -o ./lib/main.o
	${CC} -Wall -Werror -Wpedantic -std=c89 -I ./lib/ -I ./src/include -c ./src/feature_scale.c -o ./lib/feature_scale.o
	ar rcs ./lib/libread_from_data_file.a ./lib/read_from_data_file.o
	ar rcs ./lib/libcost_function.a ./lib/cost_function.o
	ar rcs ./lib/libgradient_descent.a ./lib/gradient_descent.o
	ar rcs ./lib/libnormal_equation.a ./lib/normal_equation.o
	ar rcs ./lib/libfeature_scale.a ./lib/feature_scale.o
	cd ..
	${CC} -Wall -Werror -Wpedantic -std=c89 -o ./bin/feature_scale ./lib/libfeature_scale.a
	${CC} -Wall -Werror -Wpedantic -std=c89 -o ./bin/linear_regression ./lib/main.o ./lib/libcost_function.a ./lib/libgradient_descent.a  ./lib/libread_from_data_file.a ./lib/libnormal_equation.a
	chmod +x ./bin/*

format:
	find -name *.h -exec clang-format -i {} \;
	find -name *.c -exec clang-format -i {} \;

clean:
	rm -rf ./bin
	rm -rf ./lib
