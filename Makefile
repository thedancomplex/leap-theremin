OS := $(shell uname)
ARCH := $(shell uname -m)
SYS_NAME=leap-theremin


ifeq ($(OS), Linux)
  ifeq ($(ARCH), x86_64)
    LEAP_LIBRARY := ~/LeapSDK/lib/x64/libLeap.so -Wl,-rpath,../lib/x64
  else
    LEAP_LIBRARY := ~/LeapSDK/lib/x86/libLeap.so -Wl,-rpath,../lib/x86
  endif
else
  # OS X
  LEAP_LIBRARY := ~/LeapSDK/lib/libLeap.dylib
endif

$(SYS_NAME): src/$(SYS_NAME).cpp
	$(CXX) -Wall -g -Iinclude/  src/$(SYS_NAME).cpp -o $(SYS_NAME) $(LEAP_LIBRARY) -lstk -lpthread -ljack -lrt
ifeq ($(OS), Darwin)
	install_name_tool -change @loader_path/libLeap.dylib ../lib/libLeap.dylib Sample
endif

clean:
	rm -rf $(SYS_NAME) $(SYS_NAME).dSYM
