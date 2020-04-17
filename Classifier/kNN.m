function [Pred] = kNN(X, train_label, test_data)
    n_samples = size(test_data, 2);
    Pred = zeros(n_samples, 1);
    for i = 1:n_samples
        Dis = X - test_data(:, i);
        Dis = sum(Dis.*Dis);
        [~, idx] = find(Dis == min(min(Dis)));
        l = length(idx);
        Pred(i) = train_label(idx(l)); 
    end
    
end

