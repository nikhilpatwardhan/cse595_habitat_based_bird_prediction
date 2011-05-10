function generateModels(log2c,log2g)

load '../matfiles/finalPyramids.mat';
load '../matfiles/finalPyramidLengths.mat';
load '../matfiles/modelNames.mat';

p = 0.5;

numOfModels = size(model_names, 2);
labels = cell(1, numOfModels);

for i=1:numOfModels
   labels{i} = zeros(pyramidLengths{i}, 1);
end

classifiers = cell(1, numOfModels);

cmd = ['-c ', num2str(2^log2c), ' -g ', num2str(2^log2g), ' -b 1'];
for i=1:numOfModels
%     disp(i);
    testLabels = labels;
    testLabels{i}(:) = 1;
    [ts, tl] = createTrainingSets(p, i, pyramids, pyramidLengths, testLabels);
    classifiers{i} = svmtrain(tl', ts', cmd);
end

save('../matfiles/classifiers.mat', 'classifiers');