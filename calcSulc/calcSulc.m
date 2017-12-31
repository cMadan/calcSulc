function output = calcSulc(subjects,subject_dir,options)

%% prep
% get full list of subjects if asked
if strcmp(subjects{1},'.');
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

%% exec
sub_s_w = [];
%sub_s_d = [];

for s = 1:length(list_subject)
    fprintf('Calculating sulci for subject %s...',list_subject{s})
    
    s_w = [];
    %s_d = [];
    
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
            sulci_w = calcSulc_width(options,subject_hemi,mesh);
            
            % calculate the depth
            %sulci_d = calcSulc_depth(options,mesh);
            
            % store values
            s_w = [s_w sulci_w];
            %s_d = [s_d sulci_d];
        end
    end
    
    sub_s_w = [sub_s_w; s_w];
    %sub_s_d = [sub_s_w; s_d];
    
    fprintf('done.\n')
end

output.list_subjects    = options.list_subjects;
output.list_sulc        = options.list_sulc;
output.sulci_width      = sub_s_w;
%output.sulci_depth      = sub_s_d;

% some save functionality...