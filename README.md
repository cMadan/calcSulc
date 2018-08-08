# calcSulc toolbox
A toolbox for MATLAB for calculating sulcal morphology (width and depth) from FreeSurfer surface files.

Current version: build 14

## Citing the toolbox
Please cite this paper if you use the toolbox:
* Madan, C. R. (under review). TBD

## Documentation

```
***code snippet***
```

## Output caching
calcSulc also includes a 'caching' feature that allows you to re-use precalculated morphology measurements, as long as the options and input data remain unchanged. This feature was particularly designed for use on clusters, where you may want to run the estimation for different subsets of participants as separate cluster jobs. By caching the outputs, you can easily re-run calcSulc for the full sample, but it will be able to use the cached estimates. This function is optimized to only require re-calculating the the sulcal estimates if relevant options are changed.