all: basic halfcov fullcov

basic: main.cpp world.hpp
	g++ main.cpp -o basic

halfcov: main.cpp world.hpp
	g++ main.cpp -o halfcov

fullcov: main.cpp world.hpp
	g++ main.cpp -o fullcov -DFULLCOV

clean: basic halfcov fullcov
	rm basic halfcov fullcov
