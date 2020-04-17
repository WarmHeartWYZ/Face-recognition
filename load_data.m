function [train_data, train_label, test_data, test_label] = load_data(Dataset, k)
    p = strcat('Data/', Dataset, '.mat');
    load(p);    
    [train_data, train_label, test_data, test_label] = addOcclusion(Data, label, k);
end

