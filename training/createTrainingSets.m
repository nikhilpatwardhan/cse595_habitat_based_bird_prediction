function [trainingSet, trainingLabels] = createTrainingSets(percentageOfImagesToUse, trainingIndex, pyramids, lengths, labels)
    % number of images for training as a percent of total images
    p = percentageOfImagesToUse;
    numOfSets = size(pyramids, 2);
    trainingSet = [];
    tempLabels = [];
    
    for i=1:numOfSets
        trainingSet = [trainingSet, pyramids{i}(1:uint32(lengths{i}*p), :)'];
    end

    for i=1:numOfSets
        tmp = labels{i}(1:uint32(lengths{i}*p));
        if i ~= trainingIndex
           tmp(:) = 0;
        end
        tempLabels = [tempLabels, tmp'];      
    end
    trainingLabels = tempLabels;
end