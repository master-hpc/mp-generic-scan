#include <iostream>

__global__ void scan(int* v, const int n);

int main(int argc, char** argv) {

	const int size = 10;

	int h_v[size] = { 3, 7, 1, 10, 6, 9, 5, 2, 8, 4 };

	int *d_v = 0;

	cudaMalloc((void**)&d_v, size * sizeof(int));

	cudaMemcpy(d_v, h_v, size * sizeof(int), cudaMemcpyHostToDevice);

	dim3 grdDim(1, 1, 1);
	dim3 blkDim(size - 1, 1, 1);	

	scan <<<grdDim, blkDim>>>(d_v, size);

	cudaMemcpy(h_v, d_v, size * sizeof(int), cudaMemcpyDeviceToHost);

	cudaFree(d_v);

	for (int i = 0; i < size; i++) {
		std::cout << (i == 0 ? "{" : "") <<  h_v[i] << (i < size -1 ? " ," : "}");
	}
	std::cout << std::endl;

	return 0;
}


__global__ void scan(int *v, const int n)
{
        int tIdx = threadIdx.x;
	int step = 1;
	
        while (step < n) {

                int indiceDroite = tIdx;
                int indiceGauche = indiceDroite + step;

                if (indiceGauche < n) {
                        v[indiceDroite] = v[indiceDroite] + v[indiceGauche];
                }

                step = step * 2;
		__syncthreads();

        }

}
