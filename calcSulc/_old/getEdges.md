# Note on getEdgesRobost and getEdgeLoop

An earlier version of getEdges did not have this snippet

'''
edges = edges(sum(ismember(edges,label),2)==2,:);
'''

Without this line, it required brute force to find a possible loop, as well as determine if it was the best possible loop. (There was also a mistake in build 2 that led to the edgeloop not actually being used, as opposed to a temporary variable.)

With the inclusion of this line, the work required to compute getEdgeLoop became nearly trivial *and* several orders of magnitude faster. I am still keeping `getEdgesRobust` for now as this may be useful for a later stage.