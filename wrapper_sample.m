addpath('calcSulc')

subject_dir = 'D:\Research\calcSulc\data';
subjects = {'.'};


% config settings that we would expect to be passed into the wrapper
options.list_sulc = {'S_central','S_front_sup','S_front_inf',...
                     'S_postcentral','S_oc_middle&Lunatus','S_intrapariet&P_trans',...
                     'S_cingul-Marginalis','S_temporal_sup','S_temporal_inf',...
                     'S_parieto_occipital','S_oc-temp_med&Lingual',...
                     'S_orbital-H_Shaped',};
                 
options.walk = 1;

% exec
output = calcSulc(subjects,subject_dir,options)