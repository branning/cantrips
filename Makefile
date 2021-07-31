
all: bin/thing 

bin/thing: EnumThing.cpp
	g++ --std=c++11 -o bin/thing EnumThing.cpp

