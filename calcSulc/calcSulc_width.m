function width = calcSulc_width(options,subject_hemi,mesh)

%try
    %% edge (for width)
    % isolate edge vertices
    sulc_e = sum(mesh.sulc_f_member,2)==2;
    v_e = subject_hemi.f(sulc_e,:)+1;
    v_e = unique(v_e(:));
    v_e = subject_hemi.pial_v(v_e,:);
    
    % get loop of edges along boundary of sulci
    try
    [~,edgeloop] = calcSulc_getEdgeLoop(subject_hemi.f(sulc_e,:)+1,mesh.label_v);
    catch
    try
        [~,edgeloop] = calcSulc_getEdgeLoopRobust(subject_hemi.f(sulc_e,:)+1,mesh.label_v);
    catch
        width = NaN;
        return
    end
    end
    p_e = length(edgeloop)-1;
    % make edgeloop easier to wrap around
    edgeloop = [edgeloop(1:end); edgeloop(2:(end-1)); edgeloop(1:end)];
    
    %% find nearest point along edge that isn't adjacent
    % this will give us a coarse sulcal width, but then correct for
    % differences in sulcal depth
    v_p = subject_hemi.pial_v(edgeloop,:);
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
                seed_walk = subject_hemi.f(sum(subject_hemi.f==seed(s),2)>0,:)+1;
                seed_iter = [seed_iter; unique(seed_walk(:))];
            end
            seed = unique(seed_iter);
        end
        
        % calc distance for each seed
        v_p_dist = pdist2(subject_hemi.pial_v(seed,:),v_p(p,:));
        [d,idx]=min(v_p_dist);
        idx = seed(idx);
        % did we find something better than the loop?
        if idx == width(p,2)
            % do nothing
        else
            width(p,:) = [d idx 1];
        end
    end
    
    width = nanmedian(width(:,1));
    
%catch
%    width = NaN;
%end