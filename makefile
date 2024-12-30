CXX = clang++

SOURCE = flatten.cpp
OUTPUT = pass.so

all: $(OUTPUT)

$(OUTPUT): $(SOURCE)
	$(CXX) -shared -fPIC -o $@ $<

clean:
	rm -f $(OUTPUT)
