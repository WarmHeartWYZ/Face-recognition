function [Pred] = CRC(X, train_label, test_data, lamda)
    [~, n] = size(X);%X = normalize(X);
    I = eye(n);
    P = (X' * X + lamda * I);
    P = P\X';
    
    class = length(unique(train_label));
    n_samples = size(test_data, 2);
    Pred = zeros(n_samples, 1);
    for idx = 1 : n_samples
        y = test_data(:, idx);
        x = P * y;
        ri = zeros(class, 1);
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
