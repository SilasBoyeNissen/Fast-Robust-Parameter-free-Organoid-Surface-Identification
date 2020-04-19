clear; load('SAMPLES'); load('STAINS');
warning('off', 'MATLAB:triangulation:PtsNotInTriWarnId');
RES = zeros(4*size(SAMPLES, 1), 13);
for ID = 1:size(SAMPLES, 1)
    N = SAMPLES{ID, 1};
    dim = SAMPLES(ID, 2:4);
    stains = split(N, '_');
    INFO = imfinfo(['_data/' N '.tif']);
    for CH = 1:4
        tic; rng(1);
        j = 0;
        RAW = zeros(INFO(1).Width, INFO(1).Height, size(INFO, 1)/4);
        for i = CH:4:size(INFO, 1)
            j = j + 1;
            RAW(:, :, j) = imread(['_data/' N '.tif'], i);
        end
        RAW(RAW == 0) = 1;
        RAW = medfilt3(imresize(log10(RAW), dim{2}/dim{3}), 15*ones(1, 3), 'zeros');
        Xmin = min(RAW(:));
        CC = bwconncomp(imfill(imbinarize((RAW - Xmin) ./ (max(RAW(:)) - Xmin)), 'holes'));
        [~, I] = max(cellfun(@numel, CC.PixelIdxList));
        BW = false(CC.ImageSize);
        BW(CC.PixelIdxList{I}) = 1;
        [p, TRI] = calculate(BW);
        [p, AF, VF, AR, VR] = denoise(p*dim{3}, TRI);
        Ter = 2*size(p, 1)-4-size(TRI, 1);
        Ber = sum(BW(:, :, 1), 'all')/(size(BW, 1)*size(BW, 2))*100;
        Cer = sum(BW(:, :, end), 'all')/(size(BW, 1)*size(BW, 2))*100;
        stlwrite(triangulation(TRI, p), ['_stl/' N '_Ch' num2str(CH) '.stl']); % ID, N, id, age, Areal, Vreal, AF, VF, F, Ber, Cer, Ter, toc
        RES((ID-1)*4+CH, :) = [ID, str2double(N(1:3)), find(contains(STAINS, stains{end-5+CH})), str2double(N(1)), AR, VR, AF, VF, AF/(3*VF), Ber, Cer, Ter, toc];
        disp([num2str(ID) '-' N ': V=' num2str(round(VR)) ' F=' num2str(AF/(3*VF)) ' Ber=' num2str(Ber) ' Cer=' num2str(Cer) ' Ter=' num2str(Ter) ' toc=' num2str(toc)]);
    end
end
save('RESULTS', 'RES');