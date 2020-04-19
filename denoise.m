function [p, AF, VF, AR, VR] = denoise(p, TRI)
% Mean face normal filter for smoothing/denoising triangular meshes. Containing the elements adjacent to each vertex within TRI
% References: 1) Yagou, Belayev, Ohtake (2002) Mesh smoothing via Mean and Median Filtering applied to face Normals, PGMP - Theory and Applications
%             2) Zhang and Hamza, (2006) Vertex-based anisotropic smoothing of 3D mesh data, IEEE CCECE
n = 0;
err = Inf;
a = faces(p, TRI);
pn = zeros(size(p));
c = cell(max(TRI(:)), 1);
nb = cell(size(TRI, 1), 1);
FN = faceNormal(triangulation(TRI, p));
FNn = zeros(size(FN));
for i = 1:size(TRI, 1) % Triangles adjacent to each vertex;
    for j = 1:size(TRI, 2) % create node neighbor list from a mesh
        c{TRI(i, j)} = [c{TRI(i, j)}, i]; % c{n} contains a list of all neighboring elem ID for node n
    end
end
for i = 1:size(TRI, 1) % Identify all the nodes in one triangle and get them all into one array, so that all elements surrounding one element are listed
    vi = TRI(i, :); % Vertices for the i'th element
    A = sort([c{vi(1)} c{vi(2)} c{vi(3)}]);
    nb{i} = A([diff(A) 1] > 0); % Containing each element adjacent to each elements
end
while err > 1e-2% && n < 30
    n = n + 1;
    for k = 1:length(TRI) % Find triangles neighborhood
        ind = nb{k}; % Element indices
        ai = a(ind);
        mti = sum(ai.*FN(ind, :))/sum(ai); % Step 1: Area weighted face normal
        FNn(k, :) = mti./sqrt(sum(mti.*mti, 2)); % Step 2: Normalize mti & update
        for i = 1:3 % Evaluate for each vertex in the central triangle
            s = c{TRI(k, i)}; % Elements containing current vertex
            as = a(s);
            t = TRI(s, :);
            f = FNn(s, :);
            cj = (p(t(:, 1), :) + p(t(:, 2), :) + p(t(:, 3), :))/3;
            pn(TRI(k, i), :) = p(TRI(k, i), :) + sum(as.*sum((cj - p(TRI(k, i), :))'.*f')'.*f)/sum(as);
        end
    end
    an = faces(pn, TRI);
    err = sum(an.*sqrt(sum((FN - FNn).*(FN - FNn), 2)))/sum(an); % Stopping criteria: face-normal error metric (L2-norm)
    FN = FNn; % Update triangle normal vectors
    p = pn; % Update coordinates
    a = an; % Update mesh areas
end
[AR, VR] = geometry(p, TRI);
t = unique(convhull(p));
[~, d] = knnsearch(p(t, :), p(t, :), 'k', 1e10);
p = 2*p/max(d(:));
[AF, VF] = geometry(p, TRI);