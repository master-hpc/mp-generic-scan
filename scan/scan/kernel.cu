
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>


__global__ void prefixSumKernel(int *v, int n)
{
	int step = 1;
	while (step < n) {

		int indice1 = threadIdx.x;
		int indice2 = threadIdx.x + step;

		if (indice2 < n) {
			v[indice2] = v[indice1] + v[indice2];
		}

		step = step * 2;
	}

}

int main()
{
	const int arraySize = 10;
	int v[arraySize] = { 3, 7, 1, 10, 6, 9, 5, 2, 8, 4 };

	int *dev_v = 0;

	cudaMalloc((void**)&dev_v, arraySize * sizeof(int));

	cudaMemcpy(dev_v, v, arraySize * sizeof(int), cudaMemcpyHostToDevice);

	prefixSumKernel << <1, arraySize - 1 >> >(dev_v, arraySize);

	cudaMemcpy(v, dev_v, arraySize * sizeof(int), cudaMemcpyDeviceToHost);

	cudaFree(dev_v);

	for (int i = 0; i < arraySize; i++) {
		printf(" %d ", v[i]);
	}

	return 0;
}

