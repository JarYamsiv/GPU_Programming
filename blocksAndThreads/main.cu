  #include <stdio.h>
__global__ void add(int *a,int *b,int *c)
{
	int index = threadIdx.x + blockIdx.x*blockDim.x;
	c[index] = a[index] + b[index];
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
#define N (2048*2048)
#define THREADS_PER_BLOCK 512
int main()
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
    //run gpu
    printf("gpu started\n");
    add<<<N/THREADS_PER_BLOCK,THREADS_PER_BLOCK>>>(device_a, device_b, device_c);
    printf("gpu ended\n");
    cudaMemcpy(c , device_c , size ,cudaMemcpyDeviceToHost);

    /*int i;
    for(i=0; i<N; i++)
    {
        printf("%d ",c[i]);
    }
    printf("\n");*/

    free(a); free(b); free(c);
    cudaFree(device_a); cudaFree(device_b); cudaFree(device_c);
	return 0;
}