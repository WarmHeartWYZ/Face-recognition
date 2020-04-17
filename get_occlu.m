function [ res ] = get_occlu(method, y, Mu, Cov, Alpha, Z)
    n_feat = length(y);
    mask = zeros(size(y));
    CLASS = size(Alpha, 1);
    if strcmp(method, 'GMM')
%         Z = size(Alpha, 1) * 4;
        for i = 1 : n_feat
            mu = Mu(:, i);
            alpha = Alpha(:, i);
            cov = Cov(1, i, :);
            dst = zeros(CLASS, 1);
            for k = 1 : CLASS
                dst(k) = (abs(y(i) - mu(k))) / (cov(:, : ,k) * alpha(k));
            end
            if min(dst) > Z %这个Z和数据集有某种内在联系
                mask(i) = 1;
                y(i) = 1;
            end
        end
        res = find(mask == 1);
%         figure(1)
%         img = reshape(mask, [60, 60]);
%         imshow(img);
%         figure(2)
%         img_ = reshape(y, [60, 60]);
%         imshow(img_);
    end
end

