function [ Result ] = faceRecognition(Dataset, Z)
    K = [0.1, 0.2, 0.3, 0.4, 0.5];
    num_loop = 2;
    disp(Dataset);
    Result = [];
    for occlu = 1 : length(K) 
        k = K(occlu); %遮挡比例
        acc = 0;acc_ = 0;
        for loop = 1 : num_loop
            %% split data
            [train_x, train_y, test_x, test_y] = load_data(Dataset, k);
            CLASS = length(unique(train_y));
            [Mu, Cov, Alpha] = GetMCA(train_x, CLASS);
            %% CRC
            y_CRC = CRC(train_x, train_y, test_x, 0.1);
            tmp = sum(y_CRC == test_y) / length(test_y);
            acc = acc + tmp;
            %% GMM rest
            n_samples = length(test_y);
            y_pred = zeros(size(test_y));
            for i = 1 : n_samples
                %% 找到遮挡
                y = test_x(:, i);
                idx = get_occlu('GMM', y, Mu, Cov, Alpha, Z);
                %% 剩余部分进行识别
                D = train_x;
                D(idx, :) = [];
                y(idx) = [];
                y_p = CRC(D, train_y, y, 0.1);
                y_pred(i) = y_p;
            end
            tmp = sum(y_pred == test_y) / length(test_y);
            acc_ = acc_ + tmp;
        end
        acc = acc / num_loop;
        acc_ = acc_ / num_loop;
        Result = [Result, acc_];
        fprintf('k: %d, acc = %d, acc_gmm = %d\n', k, acc, acc_);
    end
end

