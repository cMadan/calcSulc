function width = calcSulc_depth(options,subject_hemi,mesh,sulcmap,gyrifmesh)

%% fundus (valley) (for depth)
% find vertices for lowest points in map, using sulcal map
% lowest 100 vertices

keyboard

% calculate distance between vertex on pial surface and gyrif surface vertex