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
% The calcSulc toolbox is available from: http://cmadan.github.io/calcFD/.
% 
% Please cite this paper if you use the toolbox:
%   Madan, C. R. (under review). Age differences in estimates of 
%   sulcal morphology.
%
% 
% 20180524 CRM
% build 13


%% prep
% get full list of subjects if asked
if strcmp(subjects{1},'.')
    list = dir(fullfile(subject_dir));
    list = {list([list.isdir]).name};
    
    % excl the non-subject folders
    excl = [1:2 find(cellfun(@length,strfind(list,'average')))];
    list = list(setdiff(1:length(list),excl));
    list_subject = list;
elseif length(strfind(subjects{1},'*'))==1
    % subjects name has a wildcard, but only expect one entry then
    list = dir(fullfile(subjectpath,subjects{1}));
    list = {list([list.isdir]).name};
    list_subject = list;
else
    list_subject = subjects;
end

% set defaults for options if not set
% see if we are doing both width and depth
% default is yes
if ~isfield(options,'estimateWidth')
    options.estimateWidth = 1;
end
if ~isfield(options,'setWidthWalk')
    options.setWidthWalk = 4;
end
if ~isfield(options,'estimateDepth')
    options.estimateDepth = 1;
end


% use caching?
% default is not
if ~isfield(options,'useCache')
    options.useCache = 0;
end


%% exec
sub_s_w = [];
sub_s_d = [];

for s = 1:length(list_subject)
    fprintf('Calculating sulci for subject %s...',list_subject{s})
    
    s_w = [];
    s_d = [];
    count = 0;
    
    % do all of the sulci for each hemi
    for hemi = {'lh','rh'}
        hemi = char(hemi);
        % load the surfaces and annot
        subject_hemi = calcSulc_load(options,subject_dir,list_subject{s},hemi);
        
        % process each sulci
        for sulc    = options.list_sulc
            % process each sulci and measure in individual functions
            % to keep namespace more organized
            
            % isolate the mesh for the specific sulci
            mesh    = calcSulc_isolate(options,subject_hemi,sulc);
            
            % calculate the width
            if options.estimateWidth
                if ~options.useCache
                    sulci_w = calcSulc_width(options,subject_hemi,mesh);
                else
                    sulci_w = cache_results(@calcSulc_width,{options,subject_hemi,mesh});
                end
                % store values
                s_w = [s_w sulci_w];
            end
            
            % calculate the depth
            if options.estimateDepth
                if ~options.useCache
                    sulci_d = calcSulc_depth(options,subject_hemi,mesh);
                else
                    sulci_d = cache_results(@calcSulc_depth,{options,subject_hemi,mesh});
                end
                % store values
                s_d = [s_d sulci_d];
            end
            
            % continue to next sulci
            count = count +1;
            fprintf('%g.',count)
        end
    end
    
    sub_s_w = [sub_s_w; s_w];
    sub_s_d = [sub_s_d; s_d];
    
    fprintf('...done.\n')
end

% push outputs
output.options          = options;
output.list_subject     = list_subject;
output.list_sulc        = options.list_sulc;
if options.estimateWidth
    output.sulci_width  = sub_s_w;
end
if options.estimateDepth
    output.sulci_depth  = sub_s_d;
end

% write CSVs out too
calcSulc_save

% return output