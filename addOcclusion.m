function [train_data, train_label, test_data, test_label] = addOcclusion(Data, label, k)
%           Data - D x N , D - dimension, N - number of data
%           label - N x 1
%           k - the percent of occusion area of face image

    train_data = Data;
    train_label = label;
    test_label = label;
    
    SIZE = 60;
    area = size(Data, 1) * k;
    test_data = [];
    for i = 1 : size(Data, 2)
        img = reshape(Data(:, i), [SIZE, SIZE]);
        [occlu_x,occlu_y] = occlu_area(SIZE, area);
        % add occlusion
        %img(occlu_x, occlu_y) = 1;
        img(occlu_x, occlu_y) = 1;
        %img(occlu_x, occlu_y) = imresize(imgnoise, [length(occlu_x), length(occlu_y)]) ;
        test_data = [test_data, img(:)];
    end
end
function [occlu_x,occlu_y] = occlu_area(size, area)

    min_ = area / size;
    max_ = size;
    size_a = floor(randperm(max_ - min_, 1) + min_);
    size_b = floor(area / size_a);
    idx = randperm(size - size_a + 1, 1);
    idy = randperm(size - size_b + 1, 1);

    occlu_x = idx:(idx + size_a - 1);
    occlu_y = idy:(idy + size_b - 1);
end