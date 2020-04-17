%% add path
addPATH()
%% load data
load Data/AR.mat
%% split data
train_x = Data;train_y = label;
test_x = data_glass;test_y = glass_label;
% test_x = data_scarf;test_y = scarf_label;

% y_CRC = CRC(train_x, train_y, test_x, 0.1);
% acc = sum(y_CRC == test_y) / length(test_y);
% disp(acc);

CLASS = length(unique(train_y));
[Mu, Cov, Alpha] = GetMCA(train_x, CLASS);

n_samples = length(test_y);
y_pred = zeros(size(test_y));
for i = 1 : 1
    y = test_x(:, i);
    idx = get_occlu('GMM', y, Mu, Cov, Alpha);
    D = train_x;
    D(idx, :) = [];
    y(idx) = [];
    y_p = CRC(D, train_y, y, 0.1);
    y_pred(i) = y_p;
end
acc_ = sum(y_pred == test_y) / length(test_y);
disp(acc_);