objects = main.o

all: $(objects)
	g++ $(objects) -lcudart -o app

main.o: main.cu
	nvcc -c main.cu -o main.o

clean:
	rm -f *.o app
