#include <cuda.h>
#include <stdio.h>

int N=512;

__global__ void add(int *a , int* b , int* c)
{
    c[blockIdx.x]=a[blockIdx.x]+b[blockIdx.x];
}

__global__ void addThread(int* a,int* b,int* c)
{
    c[threadIdx.x]=a[threadIdx.x]+b[threadIdx.x];
}

void rand_init(int* a,int N)
{
    int i=0;
    for(i=0; i<N; i++)
    {
        a[i]=rand()%100;
    }
    return;
}

int main(void)
{
    int *a,*b,*c;
    int *device_a , *device_b , *device_c;
    int size = N * sizeof(int);

    a=(int*)malloc(size);  rand_init(a,N);
    b=(int*)malloc(size);  rand_init(b,N);
    c=(int*)malloc(size);

    cudaMalloc((void **)&device_a,size);
    cudaMalloc((void **)&device_b,size);
    cudaMalloc((void **)&device_c,size);

    cudaMemcpy(device_a , a , size ,cudaMemcpyHostToDevice);
    cudaMemcpy(device_b , b , size ,cudaMemcpyHostToDevice);

    add<<<N,1>>>(device_a,device_b,device_c);
    addThread<<<1,N>>>(device_a,device_b,device_c);

    cudaMemcpy(c , device_c , size ,cudaMemcpyDeviceToHost);

    int i;
    for(i=0; i<N; i++)
    {
        printf("%d ",c[i]);
    }
    printf("\n");

    free(a); free(b); free(c);
    cudaFree(device_a); cudaFree(device_b); cudaFree(device_c);

    return 0;
}

