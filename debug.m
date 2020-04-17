load Data/AR.mat

k = 0.4;
% [train_data, train_label, test_data, test_label] = addOcclusion(Data, label, k);

train_data = Data;train_label = label;
test_data = data_glass;test_label = glass_label;
% test_data = data_scarf;test_label = scarf_label;

CLASS = length(unique(train_label));
[Mu, Cov, Alpha] = GetMCA(train_data, CLASS);
% GMM rest
for i = 1:6
    n_samples = length(train_data);
    y_pred = zeros(size(test_data));
    n_feat = size(train_data, 1);
    SIZE = 60;
    %% test
    % i = 1;
    y = test_data(:, i);

    %% 找到遮挡
    Z = 450;
    mask = zeros(size(y));
    idx = get_occlu('GMM', y, Mu, Cov, Alpha, Z);
    %% 剩余部分进行识别
    y(idx) = 1;
    mask(idx) = 1;

    img_original = reshape(test_data(:, i), [60, 60]);
    img = reshape(mask, [60, 60]);
    img_ = reshape(y, [60, 60]);

    subplot(131);imshow(img_original);title('original');imwrite(img_original, strcat('Result/', 'original_', num2str(i), '.bmp'));
    subplot(132);imshow(img);title('mask');imwrite(img, strcat('Result/','mask_', num2str(i), '.bmp'));
    subplot(133);imshow(img_);title('img');imwrite(img_, strcat('Result/','res_', num2str(i), '.bmp'));

end



