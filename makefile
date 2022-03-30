all: onecov/onecov twocov/twocov fullcov/fullcov

onecov/onecov: src/main.cpp src/world.hpp
	mkdir -p onecov
	g++ src/main.cpp src/world.cpp -o onecov/onecov --coverage -DONECOV -O0 -fno-inline -fno-inline-small-functions -fno-default-inline

twocov/twocov: src/main.cpp src/world.hpp
	mkdir -p twocov
	g++ src/main.cpp src/world.cpp -o twocov/twocov --coverage -DTWOCOV -O0 -fno-inline -fno-inline-small-functions -fno-default-inline

fullcov/fullcov: src/main.cpp src/world.hpp
	mkdir -p fullcov
	g++ src/main.cpp src/world.cpp -o fullcov/fullcov -DONECOV -DTWOCOV --coverage -O0 -fno-inline -fno-inline-small-functions -fno-default-inline

coverage: run

.PHONY: run

run:
	./onecov/onecov
	./twocov/twocov
	mkdir combined
	cp twocov/*.gcda twocov/*.gcno onecov/*.gcno onecov/*.gcda combined/
	lcov --directory combined --capture --output-file fullcov.info
	lcov  -a fullcov.info -o alpha.info

clean:
	rm -rf onecov twocov fullcov

