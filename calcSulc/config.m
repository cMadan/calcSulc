sub = '0028505'; % 20 year old
%sub = '0028594'; % 80 year old


% config settings that we would expect to be passed into the wrapper
%options.list_sulc = {'S_central'};
options.list_sulc = {'S_central','S_front_sup','S_front_inf',...
                     'S_postcentral','S_oc_middle&Lunatus',...
                     'S_cingul-Marginalis',...
                     'S_parieto_occipital','S_oc-temp_med&Lingual',...
                     'S_orbital-H_Shaped','S_orbital_med-olfact'}
% 'S_intrapariet&P_trans','S_temporal_sup','S_temporal_inf'

options.subject_dir = 'D:\Research\calcSulc\data';

options.walk = 1;