function [Pred] = SRC(X, train_label, test_data, alpha)
    
    rho = 1.0;
    class = length(unique(train_label));
    n_samples = size(test_data, 2);
    ri = zeros(class, 1);
    Pred = zeros(n_samples, 1);
    for idx = 1 : n_samples
        y = test_data(:, idx);
        [x, ~] = basis_pursuit(X, y, rho, alpha);
        for c = 1:class
            [row, ~] = find(train_label == c);
            D = X(:, row);
            xi = x(row);
            ri(c) = norm(y - D * xi, 2) / norm(xi, 2);
        end
        [id, ~] = find(ri == min(min(ri)));
        Pred(idx) = id(length(id));
    end
end

function [ A ] = normalize( A )

[m,n] = size(A);
for i = 1:n
    Az(1,i) = norm(A(:,i));
end
Az = repmat(Az,m,1);
A = A./Az;
end
