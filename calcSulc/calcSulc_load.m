function subject_hemi = calcSulc_load(options,subject_dir,subject,hemi)

%% there are some files we need no matter what
subject = char(subject);

% load the annot file
fname_annot     = fullfile(subject_dir,subject,'label',sprintf('%s.aparc.a2009s.annot',hemi));
[v,label,cmap]  = read_annotation(fname_annot);

% load the surface mesh
fname_surf      = fullfile(subject_dir,subject,'surf',sprintf('%s.%s',hemi,'pial'));
[pial_v,f]      = read_surf(fname_surf);
fname_surf      = fullfile(subject_dir,subject,'surf',sprintf('%s.%s',hemi,'inflated'));
[inflated_v,f]  = read_surf(fname_surf);

% package the data together for better namespace management
%subject_hemi.v          = v;
subject_hemi.label      = label;
subject_hemi.cmap       = cmap;
%
subject_hemi.f          = f;
subject_hemi.pial_v     = pial_v;
subject_hemi.inflated_v = inflated_v;


%% if we're going to estimate depth, will also need some additional files

if options.estimateDepth
    try
    % sulcal map
    fname_sulcmap     = fullfile(subject_dir,subject,'surf',sprintf('%s.sulc',hemi));
    sulcmap           = read_curv(fname_sulcmap);
    subject_hemi.sulcmap    = sulcmap;
    
    % gyrification surface (smoothed outer surface, nearly convex hull)
    fname_surf      = fullfile(subject_dir,subject,'surf',sprintf('%s.%s',hemi,'pial-outer-smoothed'));
    [gyrif_v,gyrif_f]       = read_surf(fname_surf);
    subject_hemi.gyrif_v    = gyrif_v;
    subject_hemi.gyrif_f    = gyrif_f;
    catch
        % gyrif wasn't successful
        % do nothing
    end
    
end

