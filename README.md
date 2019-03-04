# "Generic Scan"
> Single block generic parallel scan (CUDA)

## Compilation

    # run from repo dir
    nvcc -o out/generic-scan generic-scan.cu

## TODOs
- [x] push the integer version (done by [Nadhir](https://github.com/nzingo))
- [ ] fix running prefix sum direction (right to left currently)
- [ ] write a generic kernel (using C++ templates and functors)
- [ ] write a generic prescan (exclusive scan)
- [ ] cite Hillis & Steele's paper
