CXX = clang++

CXXFLAGS = -fPIC

SOURCE = flatten.cpp
OUTPUT = pass.so

all: $(OUTPUT)

$(OUTPUT): $(SOURCE)
	$(CXX) -shared $(CXXFLAGS) -o $@ $<

clean:
	rm -f $(OUTPUT)
