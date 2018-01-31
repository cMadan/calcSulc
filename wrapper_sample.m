addpath('calcSulc')

subject_dir = '~/struct/datasets/oasisc/surf/';
subjects = {'.'};


% config settings that we would expect to be passed into the wrapper
options.list_sulc = {'S_central','S_front_sup','S_front_inf',...
                     'S_postcentral','S_oc_middle&Lunatus',...
                     'S_cingul-Marginalis','S_parieto_occipital','S_oc-temp_med&Lingual'};
                 
options.walk = 4;

% exec
output = calcSulc(subjects,subject_dir,options)