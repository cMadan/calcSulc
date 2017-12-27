%
figure
pt = pial_v(label_v,:);
scatter3(pt(:,1),pt(:,2),pt(:,3))

% map colors
mv      = (mv-min(mv))/range(mv);
cc      = gray(101);
c       = cc(ceil(mv*100)+1,:);

%
figure
patch('Faces',f+1,'Vertices',inflated_v,'FaceVertexCData',c,...
    'CDataMapping','direct','facecolor','interp','edgecolor','none')

%
vcmap = zeros(size(c));
for i = 1:length(cmap.table)
    idx = find(label==cmap.table(i,5));
    vcmap(idx,:) = repmat(cmap.table(i,1:3)/255,length(idx),1);
end
figure
patch('Faces',f+1,'Vertices',inflated_v,'FaceVertexCData',vcmap,...
    'CDataMapping','direct','facecolor','interp','edgecolor','none')

%
figure
patch('Faces',f+1,'Vertices',inflated_v,'FaceVertexCData',c.*vcmap,...
    'CDataMapping','direct','facecolor','interp','edgecolor','none')

%
figure
patch('Faces',f+1,'Vertices',pial_v,'FaceVertexCData',c,...
    'CDataMapping','direct','facecolor','interp','edgecolor','none')

%
figure
patch('Faces',f(sulc_f,:)+1,'Vertices',inflated_v,'FaceVertexCData',vcmap,...
    'CDataMapping','direct','facecolor','interp','edgecolor','none')

%
figure
patch('Faces',f(sulc_f,:)+1,'Vertices',pial_v,'FaceVertexCData',c,...
    'CDataMapping','direct','facecolor','interp','edgecolor','none')

figure
patch('Faces',f(sulc_e,:)+1,'Vertices',pial_v,'FaceVertexCData',c,...
    'CDataMapping','direct','facecolor','interp','edgecolor','none')
