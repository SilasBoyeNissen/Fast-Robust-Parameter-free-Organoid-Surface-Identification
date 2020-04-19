function [p, TRI] = calculate(BW)
if mod(size(BW, 1), 2) == 0
    BW(end+1, :, :) = 0;
end
if mod(size(BW, 2), 2) == 0
    BW(:, end+1, :) = 0;
end
if mod(size(BW, 3), 2) == 0
    BW(:, :, end+1) = 0;
end

kant = find(bwperim(BW, 26));
j = 1;
BW(kant) = 0;
inde = sort([kant; find(bwperim(BW, 26))]);
TRI = zeros(1e6, 3);
Ly = size(BW, 1);
Lz = size(BW, 2);

for i = kant(mod(kant, 2) == 1)'
    if all(ismembc([i-1 i+Ly], kant))
        if any(~ismembc([i-Ly*Lz i+Ly-Ly*Lz i-1-Ly*Lz i+Ly-1-Ly*Lz], inde))
            TRI(j, :) = [i i-1 i+Ly];
            j = j + 1;
        elseif any(~ismembc([i+Ly*Lz i+Ly+Ly*Lz i-1+Ly*Lz i+Ly-1+Ly*Lz], inde))
            TRI(j, :) = [i i+Ly i-1];
            j = j + 1;
        end
    end
    if all(ismembc([i+1 i+Ly], kant))
        if any(~ismembc([i-Ly*Lz i+1-Ly*Lz i+Ly-Ly*Lz i+1+Ly-Ly*Lz], inde))
            TRI(j, :) = [i i+Ly i+1];
            j = j + 1;
        elseif any(~ismembc([i+Ly*Lz i+1+Ly*Lz i+Ly+Ly*Lz i+1+Ly+Ly*Lz], inde))
            TRI(j, :) = [i i+1 i+Ly];
            j = j + 1;
        end
    end
    if all(ismembc([i+1 i-Ly], kant))
        if any(~ismembc([i-Ly*Lz i-Ly-Ly*Lz i+1-Ly*Lz i-Ly+1-Ly*Lz], inde))
            TRI(j, :) = [i i+1 i-Ly];
            j = j + 1;
        elseif any(~ismembc([i+Ly*Lz i-Ly+Ly*Lz i+1+Ly*Lz i-Ly+1+Ly*Lz], inde))
            TRI(j, :) = [i i-Ly i+1];
            j = j + 1;
        end
    end
    if all(ismembc([i-1 i-Ly], kant))
        if any(~ismembc([i-Ly*Lz i-1-Ly*Lz i-Ly-Ly*Lz i-1-Ly-Ly*Lz], inde))
            TRI(j, :) = [i i-Ly i-1];
            j = j + 1;
        elseif any(~ismembc([i+Ly*Lz i-1+Ly*Lz i-Ly+Ly*Lz i-1-Ly+Ly*Lz], inde))
            TRI(j, :) = [i i-1 i-Ly];
            j = j + 1;
        end
    end
    %%
    if all(ismembc([i-Ly*Lz i+Ly], kant))
        if any(~ismembc([i-1 i-Ly*Lz-1 i+Ly-1 i-Ly*Lz+Ly-1], inde))
            TRI(j, :) = [i i+Ly i-Ly*Lz];
            j = j + 1;
        elseif any(~ismembc([i+1 i-Ly*Lz+1 i+Ly+1 i-Ly*Lz+Ly+1], inde))
            TRI(j, :) = [i i-Ly*Lz i+Ly];
            j = j + 1;
        end
    end
    if all(ismembc([i+Ly*Lz i+Ly], kant))
        if any(~ismembc([i-1 i+Ly-1 i+Ly*Lz-1 i+Ly+Ly*Lz-1], inde))
            TRI(j, :) = [i i+Ly*Lz i+Ly];
            j = j + 1;
        elseif any(~ismembc([i+1 i+Ly+1 i+Ly*Lz+1 i+Ly+Ly*Lz+1], inde))
            TRI(j, :) = [i i+Ly i+Ly*Lz];
            j = j + 1;
        end
    end
    if all(ismembc([i+Ly*Lz i-Ly], kant))
        if any(~ismembc([i-1 i+Ly*Lz-1 i-Ly-1 i+Ly*Lz-Ly-1], inde))
            TRI(j, :) = [i i-Ly i+Ly*Lz];
            j = j + 1;
        elseif any(~ismembc([i+1 i+Ly*Lz+1 i-Ly+1 i+Ly*Lz-Ly+1], inde))
            TRI(j, :) = [i i+Ly*Lz i-Ly];
            j = j + 1;
        end
    end
    if all(ismembc([i-Ly*Lz i-Ly], kant))
        if any(~ismembc([i-1 i-Ly-1 i-Ly*Lz-1 i-Ly-Ly*Lz-1], inde))
            TRI(j, :) = [i i-Ly*Lz i-Ly];
            j = j + 1;
        elseif any(~ismembc([i+1 i-Ly+1 i-Ly*Lz+1 i-Ly-Ly*Lz+1], inde))
            TRI(j, :) = [i i-Ly i-Ly*Lz];
            j = j + 1;
        end
    end
    %%
    if all(ismembc([i-1 i+Ly*Lz], kant))
        if any(~ismembc([i-Ly i-1-Ly i+Ly*Lz-Ly i-1+Ly*Lz-Ly], inde))
            TRI(j, :) = [i i+Ly*Lz i-1];
            j = j + 1;
        elseif any(~ismembc([i+Ly i-1+Ly i+Ly*Lz+Ly i-1+Ly*Lz+Ly], inde))
            TRI(j, :) = [i i-1 i+Ly*Lz];
            j = j + 1;
        end
    end
    if all(ismembc([i+1 i+Ly*Lz], kant))
        if any(~ismembc([i-Ly i+Ly*Lz-Ly i+1-Ly i+Ly*Lz+1-Ly], inde))
            TRI(j, :) = [i i+1 i+Ly*Lz];
            j = j + 1;
        elseif any(~ismembc([i+Ly i+Ly*Lz+Ly i+1+Ly i+Ly*Lz+1+Ly], inde))
            TRI(j, :) = [i i+Ly*Lz i+1];
            j = j + 1;
        end
    end
    if all(ismembc([i+1 i-Ly*Lz], kant))
        if any(~ismembc([i-Ly i+1-Ly i-Ly*Lz-Ly i+1-Ly*Lz-Ly], inde))
            TRI(j, :) = [i i-Ly*Lz i+1];
            j = j + 1;
        elseif any(~ismembc([i+Ly i+1+Ly i-Ly*Lz+Ly i+1-Ly*Lz+Ly], inde))
            TRI(j, :) = [i i+1 i-Ly*Lz];
            j = j + 1;
        end
    end
    if all(ismembc([i-1 i-Ly*Lz], kant))
        if any(~ismembc([i-Ly i-Ly*Lz-Ly i-1-Ly i-Ly*Lz-1-Ly], inde))
            TRI(j, :) = [i i-1 i-Ly*Lz];
            j = j + 1;
        elseif any(~ismembc([i+Ly i-Ly*Lz+Ly i-1+Ly i-Ly*Lz-1+Ly], inde))
            TRI(j, :) = [i i-Ly*Lz i-1];
            j = j + 1;
        end
    end
end
TRI(j:end, :) = [];
[C, ~, ic] = unique(TRI);
TRI = reshape(ic, size(TRI));
[x, y, z] = ind2sub(size(BW), C);
p = [x y z];
F = [1 1];
while ~isempty(F)
    F = freeBoundary(triangulation(TRI, p));
    if ~isempty(F)
        TRI(ismember(TRI(:, [1 2]), F, 'rows') + ismember(TRI(:, [2 3]), F, 'rows') + ismember(TRI(:, [3 1]), F, 'rows') + ...
            ismember(TRI(:, [3 2]), F, 'rows') + ismember(TRI(:, [2 1]), F, 'rows') + ismember(TRI(:, [1 3]), F, 'rows') > 0, :) = [];
    end
end
A = adjacency(digraph(TRI, TRI(:, [2 3 1])));
[bins, binsizes] = conncomp(graph(A | A'));
[~, I] = max(binsizes);
TRI(bins(TRI(:, 1)) ~= I, :) = [];
[C, ~, ic] = unique(TRI);
p = p(C, :);
TRI = reshape(ic, size(TRI));