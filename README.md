# calcSulc toolbox
A toolbox for MATLAB for calculating sulcal morphology (width and depth) from FreeSurfer surface files.

Current version: build 13

## Citing the toolbox
Please cite this paper if you use the toolbox:
* Madan, C. R. (under review). Age differences in estimates of sulcal morphology.

## Documentation

```
% Calculate sulcal morphology from a FreeSurfer estimated surface mesh.
% Designed to work with intermediate files from FreeSurfer analysis
% pipeline.
% 
% REQUIRED INPUTS:
% subjects      = list of subjects names in a cell array
%                 alternatively accepts {'.'} to run on all subjects in folder
%
% subject_dir   = FreeSurfer 'SUBJECTDIR' where standard directory structure is
%
% options       = specify details of running the analysis
%                 See wrapper_sample for details.
% ----
%
% The calcSulc toolbox is available from: http://cmadan.github.io/calcSulc/.
% 
% Please cite this paper if you use the toolbox:
%   Madan, C. R. (under review). Age differences in estimates of 
%   sulcal morphology.
%
% 
% 20180524 CRM
% build 13
```

## Output caching
calcSulc also includes a 'caching' feature that allows you to re-use precalculated morphology measurements, as long as the options and input data remain unchanged. This feature was particularly designed for use on clusters, where you may want to run the estimation for different subsets of participants as separate cluster jobs. By caching the outputs, you can easily re-run calcSulc for the full sample, but it will be able to use the cached estimates. Note that this function is not 'intelligent' to modifying options that are not related to a specific estimation, such that changing width-related options will still lead to re-calculating sulcal depth measurements.