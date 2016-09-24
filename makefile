CC = g++
CXXFLAGS =-fPIC -std=c++14 -g -shared -ldl

SOURCES :=./src/AimTux.cpp ./src/draw.cpp ./src/NetVarManager.cpp ./src/Offsets.cpp ./src/hooker.cpp ./src/aimbot.cpp ./src/settings.cpp ./src/esp.cpp
OBJECTS:= ./src/AimTux.o ./src/draw.o ./src/NetVarManager.o ./src/Offsets.o ./src/hooker.o ./src/aimbot.o ./src/settings.o ./src/esp.o
OUT := aimtux-csgo.so

all: clean build

clean:
	rm -vf $(OBJECTS) $(OUT)

%.cpp: ../%.cpp
	$(CC) $(CFLAGS) -o "$@" "$<" -ldl

%.o: ../%.cpp
	$(CC) $(CFLAGS) -o "$@" "$<" -ldl

build: $(OBJECTS)
	rm "libstdc++.a"
	ln -s `g++ -print-file-name=libstdc++.a`
	
	$(CC) $(CXXFLAGS) -static-libgcc -L. -o $(OUT) $(OBJECTS) -ldl
	rm  ./src/*.o