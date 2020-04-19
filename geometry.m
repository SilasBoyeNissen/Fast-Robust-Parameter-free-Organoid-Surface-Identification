function [A, V] = geometry(p, TRI)
[a, c] = faces(p, TRI);
A = sum(a);
V = -sum(a.*(p(TRI(:, 1), 3) + p(TRI(:, 2), 3) + p(TRI(:, 3), 3))/3.*c(:, 3)./sqrt(c(:, 1).^2 + c(:, 2).^2 + c(:, 3).^2));