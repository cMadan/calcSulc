function mesh = calcSulc_isolate(options,subject_hemi,sulc)

%% annot
% isolate vertices for the desired label
label_sulc  = subject_hemi.cmap.table(ismember(subject_hemi.cmap.struct_names,sulc),5);
label_v     = find(subject_hemi.label==label_sulc);
% if using subject_hemi.v, would need to add 1 to make things match

%% surface
% isolate faces that include all 3 vertices
sulc_f_member = ismember(subject_hemi.f+1,label_v);
sulc_f = sum(sulc_f_member,2)==3;

%% output
mesh.label_v        = label_v;
mesh.sulc_f_member  = sulc_f_member;