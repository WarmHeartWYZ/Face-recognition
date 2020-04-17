load Data/AR.mat

for i = 15 : 17
    img = reshape(Data(:, i), [60, 60]);
    % imshow(img);
    imwrite(img, strcat('Result/png/', num2str(i), '.bmp'));
end