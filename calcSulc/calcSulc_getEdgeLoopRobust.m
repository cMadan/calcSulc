function  [return_edges,return_link,link_solve] = calcSulc_getEdgeLoopRobust(faces,label)
% Convert a face array to an array of edges.
% Additionally outputs a list of vertices, such that the edges form a loop
% (circle).
% More thorough than the 'regular' variant.

%% Edges
% convert face array to edge array
edges = [];
for fi = 1:size(faces,1)
    edges = [edges; faces(fi,1) faces(fi,2)];
    edges = [edges; faces(fi,2) faces(fi,3)];
    edges = [edges; faces(fi,1) faces(fi,3)];
end

% only keep the edges where both vertices are from the determined list
% (if provided)
if nargin == 2
    edges = edges(sum(ismember(edges,label),2)==2,:);
end

% re-organize edge array to always have lower vertex number first
edges = [min(edges,[],2) max(edges,[],2)];

% clean up duplicate edges (vertex pairs)
edges = sortrows(unique(sort(edges,2),'rows'));

return_edges = edges;

%% Construct the loop
v = unique(edges(:));
attempt = 1;
%textprogressbar('Calculating sulci boundary:  ')

% solve with *all* possible starts
% else may solve, but have a sub-optimal path
while attempt <= length(v)
    % solve the loop
    link_closed(attempt) = 0;
    % reset
    link = v(attempt);
    edges = return_edges;
    
    % append a hash
    edges = [edges edges(:,1).*edges(:,2)];
    
    % begin the attempt
    while link_closed(attempt) == 0 & length(edges) > 1
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
                    link_closed(attempt) = 1;
                    link_solve{attempt} = link;
                end
            end
        end
    end
    attempt = attempt+1;
    %textprogressbar(attempt/length(v)*100)
end


if sum(link_closed==1)>0 == 1
    % we did solve it!
    link_length = cellfun(@length,link_solve);
    link_length(link_length==0) = NaN;
    [~,idx] = min(link_length);
    
    return_link = link_solve{idx};
else
    return_link = NaN;
end

%textprogressbar(' done.');

