function [mu, cov, alpha] = GMM_EM(Y, K, times)
%     K --------------   component
%     times ----------   iters
%     Y --------------   N x D
    Y = scale_data(Y);
    [mu, cov, alpha] = init_param(Y, K);
    for i = 1 : times
        gamma = getExpection(Y, mu, cov, alpha);
        [mu, cov, alpha] = maxmize(Y, gamma);
    end
end
function [mu, cov, alpha] = init_param(Y, K)
    [~, D] = size(Y);
    mu = rand(K, D);
    cov = zeros(D, D, K);
    for i = 1 : K
        cov(:, :, i) = eye(D);
    end
    alpha = (1 / K) * ones(K, 1);
    
end
function [Y] = scale_data(Y)
    for i = 1 : size(Y, 2)
        max_ = max(Y(:, i));
        min_ = min(Y(:, i));
        Y(:, i) = (Y(:, i) - min_) / (max_ - min_);
    end
end
function [mu, cov, alpha] = maxmize(Y, gamma)
    [N, D] = size(Y);
    K = size(gamma, 2);
    
    mu = zeros(K, D);
    cov = zeros(D, D, K);
    alpha = zeros(K, 1);
    
    for k = 1 : K
        Nk = sum(gamma(:, k));
        mu(k, :) = sum(Y .* gamma(:, k), 1) / Nk;
        cov_k = (Y - mu(k, :))' * ((Y - mu(k, :)) .* gamma(:, k)) / Nk;
        cov(:, :, k) = cov_k;
        alpha(k) = Nk / N;
    end
end
function [gamma] = getExpection(Y, mu, cov, alpha)
    N = size(Y, 1);
    K = size(alpha, 1);
    
    gamma = zeros(N, K);
    
    prob = zeros(N, K);
    for k = 1 : K
        prob(:, k) = phi(Y, mu(k, :), cov(:, :, k));
    end
    for k = 1 : K
        gamma(:, k) = alpha(k) * prob(:, k);
    end
    for i = 1 : N
        gamma(i, :) = gamma(i, :) / sum(gamma(i, :));
    end
end
function [prob] = phi(Y, mu_k, cov_k)
    prob = GaussPDF(Y', mu_k', cov_k);
end
function prob = GaussPDF(Data, Mu, Sigma)
%
% 根据高斯分布函数计算每组数据的概率密度 Probability Density Function (PDF)
% 输入 -----------------------------------------------------------------
%   o Data:  D x N ，N个D维数据
%   o Mu:    D x 1 ，M个Gauss模型的中心初始值
%   o Sigma: M x M ，每个Gauss模型的方差（假设每个方差矩阵都是对角阵，
%                                   即一个数和单位矩阵的乘积）
% Outputs ----------------------------------------------------------------
%   o prob:  1 x N array representing the probabilities for the
%            N datapoints.    
[dim,N] = size(Data);
Data = Data' - repmat(Mu',N,1);
prob = sum((Data * inv(Sigma)) .* Data, 2);
prob = exp(-0.5*prob) / sqrt((2*pi)^dim * (abs(det(Sigma))+realmin));
end

