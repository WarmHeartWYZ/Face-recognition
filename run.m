
    %% add path
    addPATH()
    Result = [];
    for d = 1 : 6
        if d == 1
            Dataset = 'EYaleB';Z = 150;
        elseif d == 2
            Dataset = 'FERET';Z = 900;
        elseif d == 3
            Dataset = 'PIE';Z = 400;
        elseif d == 4
            Dataset = 'LFW_A';Z = 1000;
        elseif d == 5
            Dataset = 'YaleA';Z = 80;
        else
            Dataset = 'AR';Z = 800;
        end
        acc = faceRecognition(Dataset, Z);
        Result = [Result;acc];
    end


