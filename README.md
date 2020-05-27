# calcSulc toolbox
A toolbox for MATLAB for calculating sulcal morphology (width and depth) from FreeSurfer surface files.

## Citing the toolbox
Please cite this paper if you use the toolbox:
* Madan, C. R. (2019). Robust estimation of sulcal morphology. *Brain Informatics 6*, 5. doi:10.1186/s40708-019-0098-1

## Documentation

```
function output = calcSulc(subjects,subject_dir,options)
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
%   Madan, C. R. (2019). Robust estimation of sulcal morphology.
%		Brain Informatics, 6, 5. doi:10.1186/s40708-019-0098-1
% 
% 20180808 CRM
% build 14
```

## Output caching
calcSulc also includes a 'caching' feature that allows you to re-use precalculated morphology measurements, as long as the options and input data remain unchanged. This feature was particularly designed for use on clusters, where you may want to run the estimation for different subsets of participants as separate cluster jobs. By caching the outputs, you can easily re-run calcSulc for the full sample, but it will be able to use the cached estimates. This function is optimized to only require re-calculating the the sulcal estimates if relevant options are changed.