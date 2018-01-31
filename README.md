# calcSulc
Calculate sulcal morphology from FreeSurfer surface files


### Output caching
calcSulc also includes a 'caching' feature that allows you to re-use precalculated morphology measurements, as long as the options and input data remain unchanged. This feature was particularly designed for use on clusters, where you may want to run the estimation for different subsets of participants as separate cluster jobs. By caching the outputs, you can easily re-run calcSulc for the full sample, but it will be able to use the cached estimates. Note that this function is not 'intelligent' to modifying options that are not related to a specific estimation, such that changing width-related options will still lead to re-calculating sulcal depth measurements.