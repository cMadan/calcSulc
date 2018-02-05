addpath('calcSulc')

subject_dir = 'D:\Research\calcSulc\data';
subjects = {'.'};

% config settings that we would expect to be passed into the wrapper
% FS60 labels
options.list_sulc = {'S_central','S_front_sup','S_front_inf',...
                     'S_postcentral','S_oc_middle&Lunatus',...
                     'S_cingul-Marginalis','S_parieto_occipital','S_oc-temp_med&Lingual'};
          
%{
% need slightly different aparc names for FS53 (than FS60)
options.list_sulc = {'S_central','S_front_sup','S_front_inf',...
                     'S_postcentral','S_oc_middle_and_Lunatus',...
                     'S_cingul-Marginalis','S_parieto_occipital','S_oc-temp_med_and_Lingual'};                 
%}
		  
% settings
options.setWidthWalk  = 4;
options.estimateWidth = 1;
options.estimateDepth = 1;
options.useCache      = 1;

% exec
output = calcSulc(subjects,subject_dir,options)