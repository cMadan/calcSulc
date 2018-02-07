addpath('calcSulc')

subject_dir = 'D:\Research\calcSulc\data';
subjects = {'.'};

% config settings that we would expect to be passed into the wrapper
% FS60 labels
options.list_sulc = {'S_central','S_postcentral',...
					'S_front_sup','S_front_inf',...
					'S_parieto_occipital','S_oc-temp_med&Lingual','S_oc_middle&Lunatus',...
                    'S_cingul-Marginalis'};
          

% settings
options.setWidthWalk  = 4;
options.estimateWidth = 1;
options.estimateDepth = 1;
options.useCache      = 1;

% exec
output = calcSulc(subjects,subject_dir,options)