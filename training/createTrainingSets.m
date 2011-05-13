function [trainingSet, trainingLabels] = createTrainingSets(percentageOfImagesToUse, trainingIndex, pyramids, lengths, labels)
    % number of images for training as a percent of total images
    p = percentageOfImagesToUse;
    numOfSets = size(pyramids, 2);
    trainingSet = [];
    tempLabels = [];
    
    for i=1:numOfSets
        if trainingIndex ~= i
            trainingSet = [trainingSet, pyramids{i}(1:uint32(lengths{i}*p),:)'];
        end
    end   
    trainingSet = [pyramids{trainingIndex}(1:uint32(lengths{trainingIndex}*p),:)', trainingSet];
    
    for i=1:numOfSets        
        if i ~= trainingIndex
            tmp = labels{i}(1:uint32(lengths{i}*p));
           tmp(:) = 0;
           tempLabels = [tempLabels, tmp'];
        end        
    end
    trainingLabels = [labels{trainingIndex}(1:uint32(lengths{trainingIndex}*p))', tempLabels];
end