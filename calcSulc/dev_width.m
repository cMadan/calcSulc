clear,clc

sub = '0028505'; % 20 year old
%sub = '0028594'; % 80 year old

%% config settings that we would expect to be passed into the wrapper
options.list_sulc = {'S_central'};

options.subject_dir = 'D:\Research\calcSulc\data';

%% config end

% make for-loop through list of sulci later
sulc    = options.list_sulc{1};

% make for-loop later
hemi    = 'rh';



%% annot

% load the annot file
fname_annot     = fullfile(options.subject_dir,sub,'label',sprintf('%s.aparc.a2009s.annot',hemi));
[v,label,cmap]  = read_annotation(fname_annot);

% isolate vertices for the desired label
label_sulc  = cmap.table(ismember(cmap.struct_names,sulc),5);
label_v     = v(label==label_sulc)+1;

%clear v label cmap


%% surf

% load the surface mesh
fname_surf      = fullfile(options.subject_dir,sub,'surf',sprintf('%s.%s',hemi,'pial'));
[pial_v,f]      = read_surf(fname_surf);
fname_surf      = fullfile(options.subject_dir,sub,'surf',sprintf('%s.%s',hemi,'inflated'));
[inflated_v,f]  = read_surf(fname_surf);
% faces are common regardless of surf, just the v that shift

% isolate faces that include all 3 vertices
sulc_f_member = ismember(f+1,label_v);
sulc_f = sum(sulc_f_member,2)==3;
sulc_e = sum(sulc_f_member,2)==2; % edges only

% isolate edge vertices
v_e = f(sulc_e,:)+1;
v_e = unique(v_e(:));
v_e = pial_v(v_e,:);

% get loop of edges along boundary of sulci
[~,edgeloop] = getEdgeLoop(f(sulc_e,:)+1,label_v);

% load sulc map
fname_map   = fullfile(options.subject_dir,sub,'surf',sprintf('%s.%s',hemi,'sulc'));
[mv,mf]     = read_curv(fname_map);




