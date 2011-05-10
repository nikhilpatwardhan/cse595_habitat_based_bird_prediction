clear; clc;

load '../matfiles/modelNames.mat';
load '../matfiles/groupIndices.mat';
load '../matfiles/pyramid_all.mat';

numOfModels = size(model_names, 2);
pyramidLengths = cell(1, numOfModels);
pyramids = cell(1, numOfModels);

for i=1:numOfModels-1
    startId = habitatIndices(i);
    endId   = habitatIndices(i+1) - 1;
    length  = endId - startId + 1;
    pyramids{i} = pyramid_all(startId : endId, :);
    pyramidLengths{i} = length;
end


startId = habitatIndices(numOfModels);
pyramids{numOfModels} = pyramid_all(startId : end, :);
pyramidLengths{numOfModels} =  size(pyramid_all, 1) - startId + 1;

save('../matfiles/finalPyramids.mat', 'pyramids');
save('../matfiles/finalPyramidLengths.mat', 'pyramidLengths');
