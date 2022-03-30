all: twocov/onecov twocov/twocov fullcov/fullcov

twocov/onecov: src/main.cpp src/world.hpp
	mkdir -p twocov
	g++ src/main.cpp src/world.cpp -o twocov/onecov --coverage -DONECOV -O0 -fno-inline -fno-inline-small-functions -fno-default-inline

twocov/twocov: src/main.cpp src/world.hpp
	mkdir -p twocov
	g++ src/main.cpp src/world.cpp -o twocov/twocov --coverage -DTWOCOV -O0 -fno-inline -fno-inline-small-functions -fno-default-inline

fullcov/fullcov: src/main.cpp src/world.hpp
	mkdir -p fullcov
	g++ src/main.cpp src/world.cpp -o fullcov/fullcov -DONECOV -DTWOCOV --coverage -O0 -fno-inline -fno-inline-small-functions -fno-default-inline

coverage: run

.PHONY: run

run:
	./twocov/onecov
	./twocov/twocov
	lcov --directory twocov --capture --output-file twocov.info
	lcov  -a twocov.info -o alpha.info

clean:
	rm -rf onecov twocov fullcov

