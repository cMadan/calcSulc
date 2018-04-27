addpath('calcSulc')

subject_dir = 'D:\Research\calcSulc\data';
subjects = {'.'};

% config settings that we would expect to be passed into the wrapper

% file name to use when writing output CSV files
% not needed if don't want CSV files output
output.fname = 'sample';

% which sulci do we want to measure?
% FS60 labels
options.list_sulc = {'S_central','S_front_sup','S_front_inf',...
                     'S_postcentral','S_oc_middle&Lunatus',...
                     'S_cingul-Marginalis','S_parieto_occipital','S_oc-temp_med&Lingual'};
					 
% need slightly different names for FS53 than FS60
% options.list_sulc = {'S_central','S_front_sup','S_front_inf',...
%                      'S_postcentral','S_oc_middle_and_Lunatus',...
%                      'S_cingul-Marginalis','S_parieto_occipital','S_oc-temp_med_and_Lingual'};                 

% which measures do we want to estimate?
options.estimateWidth = 1;
options.estimateDepth = 1;

% for estimating the width, how many edges should we search to find the nearest vertex on the other side of the sulci?
options.setWidthWalk  = 4;

% should we cache the individual estimates
% (useful if using cluster computing and dividing subsets of 
% participants across different cluster nodes, 
% then re-run to get all outputs together)
options.useCache      = 1;

% exec
output = calcSulc(subjects,subject_dir,options)