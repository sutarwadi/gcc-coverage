all: onecov/onecov twocov/twocov fullcov/fullcov

profdir := "$(shell pwd)/profile"
curdir := "$(shell pwd)"

onecov/onecov: src/main.cpp src/world.hpp
	mkdir -p onecov
	g++ src/main.cpp src/world.cpp -o onecov/onecov --coverage -DONECOV -O0 -fno-inline -fno-inline-small-functions -fno-default-inline

twocov/twocov: src/main.cpp src/world.hpp
	mkdir -p twocov
	g++ src/main.cpp src/world.cpp -o twocov/twocov --coverage -DTWOCOV -O0 -fno-inline -fno-inline-small-functions -fno-default-inline

fullcov/fullcov: src/main.cpp src/world.hpp
	mkdir -p fullcov
	g++ src/main.cpp src/world.cpp -o fullcov/fullcov -DONECOV -DTWOCOV --coverage -O0 -fno-inline -fno-inline-small-functions -fno-default-inline

coverage: single combined

.PHONY: single combined

single:
	mkdir -p $(curdir)/profile
	GCOV_PREFIX=$(curdir)/profile/singlecov && ./onecov/onecov
	cp onecov/*.gcno profile/singlecov/home/work/xlab/gcc-cov/onecov/
	lcov --directory profile/singlecov --capture --output-file single.info
	genhtml -o profile/singlecov single.info


combined:
	mkdir -p $(curdir)/profile
	GCOV_PREFIX=$(curdir)/profile/combined && ./onecov/onecov
	GCOV_PREFIX=$(curdir)/profile/combined && ./twocov/twocov
	cp twocov/*.gcno profile/combined/home/work/xlab/gcc-cov/twocov
	cp onecov/*.gcno profile/combined/home/work/xlab/gcc-cov/onecov/
	lcov --directory profile/combined --capture --output-file combined.info
	genhtml -o profile/combined combined.info


clean:
	rm -rf onecov twocov fullcov combined profile

