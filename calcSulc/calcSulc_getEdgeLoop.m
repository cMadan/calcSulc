function  [return_edges,return_link,link_solve] = calcSulc_getEdgeLoop(faces,label)
% Convert a face array to an array of edges.
% Additionally outputs a list of vertices, such that the edges form a loop
% (circle).

%% Edges
% convert face array to edge array
edges = [];
for fi = 1:size(faces,1)
    edges = [edges; faces(fi,1) faces(fi,2)];
    edges = [edges; faces(fi,2) faces(fi,3)];
    edges = [edges; faces(fi,1) faces(fi,3)];
end
edges = edges(sum(ismember(edges,label),2)==2,:);

% re-organize edge array to always have lower vertex number first
edges = [min(edges,[],2) max(edges,[],2)];

% clean up duplicate edges (vertex pairs)
edges = sortrows(unique(sort(edges,2),'rows'));

return_edges = edges;


%% Construct the loop
link_closed = 0;
v = unique(edges(:));

% append a hash
edges = [edges edges(:,1).*edges(:,2)];

% begin
link = v(1);
while link_closed == 0
    if length(edges) > 1
        linked  = edges(sum(edges == link(end),2)>0,:);
        adjacent= setdiff(reshape(linked(:,1:2),[],1),link(end));
        
        % is there a potential link?
        if length(adjacent) > 0
            % add to chain
            link        = [link; adjacent(1)];
            
            % remove the edge from the available list
            edges(edges(:,3) == link(end-1).*link(end),:) = [];
            
        else
            % no good match
            % remove last link and try again
            link = link(1:end-1);
        end
        
        % success, loop closed!
        if length(link) > length(faces)/3
            if link(1) == link(end)
                link_closed = 1;
                link_solve = link;
            end
        end
    else
        % edge isolation failed :(
        link_solve = NaN;
        return
    end
end


if link_closed == 1
    % we did solve it!
    return_link = link_solve;
else
    return_link = NaN;
end
