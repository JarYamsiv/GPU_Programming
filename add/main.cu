#include <cuda.h>
#include <stdio.h>


__global__ void add(int *a,int* b,int* c)
{
	*c= *a + *b;
}

int main(void)
{
	int a,b,c;
	int *device_a,*device_b,*device_c;

	int size = sizeof(int);

	cudaMalloc((void **)&device_a,size);
	cudaMalloc((void **)&device_b,size);
	cudaMalloc((void **)&device_c,size);

	a=2; b=7;

	cudaMemcpy(device_a, &a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(device_b, &b, size, cudaMemcpyHostToDevice);

	add<<<1,1>>>(device_a,device_b,device_c);

	cudaMemcpy(&c, device_c, size, cudaMemcpyDeviceToHost);

	printf("%d\n",c);

	cudaFree(device_a); cudaFree(device_b); cudaFree(device_c);

	return 0;
}
