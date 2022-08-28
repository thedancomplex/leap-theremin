OS := $(shell uname)
ARCH := $(shell uname -m)
SYS_NAME=leap-theremin


ifeq ($(OS), Linux)
  ifeq ($(ARCH), x86_64)
    LEAP_LIBRARY := ~/LeapSDK/lib/x64/libLeap.so -Wl,-rpath,~/LeapSDK/lib/x64
  else
    LEAP_LIBRARY := ~/LeapSDK/lib/x86/libLeap.so -Wl,-rpath,~/LeapSDK/lib/x86
  endif
else
  # OS X
  LEAP_LIBRARY := ~/LeapSDK/lib/libLeap.dylib
endif

CXX=g++
CLIBS=-lstk -lpthread -ljack -lrt --std=c++17
CFLAGS=-Wall -D__UNIX_JACK__ -D__LITTLE_ENDIAN__ 

$(SYS_NAME): src/$(SYS_NAME).cpp
	$(CXX) $(CFLAGS) -g -Iinclude/  src/$(SYS_NAME).cpp -o $(SYS_NAME) $(LEAP_LIBRARY) $(CLIBS)
ifeq ($(OS), Darwin)
	install_name_tool -change @loader_path/libLeap.dylib ~/LeapSDK/lib/libLeap.dylib Sample
endif

clean:
	rm -rf $(SYS_NAME) $(SYS_NAME).dSYM
