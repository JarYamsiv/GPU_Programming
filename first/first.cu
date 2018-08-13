#include <cuda.h>
#include <stdio.h>

__global__ void myKernal(void)
{
	
}

int main(void)
{
	myKernal<<<1,1>>>();
	printf("hello world!\n");
	return 0;
}