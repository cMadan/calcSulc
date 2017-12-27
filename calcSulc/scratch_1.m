sub = '0028505';
options.subject_dir = 'D:\Research\calcSulc\data';

% we need the list of Dest sulci names
for hemi = {'rh'} % no need to load other hemi for this
fname_annot = fullfile(options.subject_dir,sub,'label',sprintf('%s.aparc.a2009s.annot',hemi{:}));

% require FreeSurfer functions to be able to load files
% i.e., should already be in matlab path
[v,label,cmap] = read_annotation(fname_annot);

end

list_annot = cmap.struct_names;
% this is all of the Dest labels

sulc = list_annot{47};
% sulc = 'S_central'



