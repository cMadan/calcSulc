clear,clc

config

sulc_width = [];

% make for-loop later
hemi    = 'rh';

% make for-loop through list of sulci later
for sulc    = options.list_sulc
    sulc
    
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
    
    % isolate edge vertices
    sulc_e = sum(sulc_f_member,2)==2;
    v_e = f(sulc_e,:)+1;
    v_e = unique(v_e(:));
    v_e = pial_v(v_e,:);
    
    % get loop of edges along boundary of sulci
    [~,edgeloop] = getEdgeLoop(f(sulc_e,:)+1,label_v);
    p_e = length(edgeloop)-1;
    % make edgeloop a bit easier to wrap around
    edgeloop = [edgeloop(1:end); edgeloop(2:(end-1)); edgeloop(1:end)];
    
    %% find nearest point along edge that isn't adjacent
    % this will give us a coarse sulcal width, but then correct for
    % differences in sulcal depth
    v_p = pial_v(edgeloop,:);
    for p = 1:p_e
        v_p_dist = pdist2(v_p,v_p(p,:));
        mask = 1-conv(edgeloop==edgeloop(p),repmat(1,1,round(p_e/10)),'same');
        v_p_dist = v_p_dist .* mask;
        mask = zeros(length(edgeloop),1);
        mask([(p+p_e-ceil(p_e/2)):(p+p_e+ceil(p_e/2))],:) = 1;
        v_p_dist = v_p_dist .* mask;
        v_p_dist(v_p_dist==0) = NaN;
        
        [d,idx]=min(v_p_dist);
        width(p,:) = [d edgeloop(idx) 0];
        % third value means still from edgeloop
    end
    width_edge = width;
    
    % travel around the point found along the sulcal boundary edge and see if
    % another is closer
    for p = 1:p_e
        % wander
        seed = width(p,2);
        for walk = 1:options.walk
            seed_iter = seed;
            for s = 1:length(seed)
                seed_walk = f(sum(f==seed(s),2)>0,:);
                seed_iter = [seed_iter; unique(seed_walk(:))];
            end
            seed = unique(seed_iter);
        end
        
        % calc distance for each seed
        v_p_dist = pdist2(pial_v(seed,:),v_p(p,:));
        [d,idx]=min(v_p_dist);
        idx = seed(idx);
        % did we find something better than the loop?
        if idx == width(p,2)
            % do nothing
        else
            width(p,:) = [d idx 1];
        end
    end
    keyboard
    
    
    
    sulc_width = [sulc_width; median(width(:,1))];
    
end


sulc_width'



% load sulc map
fname_map   = fullfile(options.subject_dir,sub,'surf',sprintf('%s.%s',hemi,'sulc'));
[mv,mf]     = read_curv(fname_map);




