function [a, c] = faces(p, TRI)
c = cross([(p(TRI(:, 2), 1) - p(TRI(:, 3), 1)) (p(TRI(:, 2), 2) - p(TRI(:, 3), 2)) (p(TRI(:, 2), 3) - p(TRI(:, 3), 3))], ...
    [(p(TRI(:, 1), 1) - p(TRI(:, 2), 1)) (p(TRI(:, 1), 2) - p(TRI(:, 2), 2)) (p(TRI(:, 1), 3) - p(TRI(:, 2), 3))], 2);
a = sqrt(c(:, 1).^2 + c(:, 2).^2 + c(:, 3).^2)/2;