function [Mu, Cov, Alpha] = GetMCA(train_data, K)
    Mu = [];
    Cov = [];
    Alpha = [];
    times = 1;
    for i = 1 : size(train_data, 1)
        Y = train_data(i,:)';
        [mu, cov, alpha] = GMM_EM(Y, K, times);
        Mu = [Mu, mu];
        Cov = [Cov, cov];
        Alpha = [Alpha, alpha];
    end
end

