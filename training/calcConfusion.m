function confusion = calcConfusion(index, listOfFeatures, listOfModels, modelNames, p)
%% Returns a column for the confusion matrix for one category
    % listOfFeatures is n*m matrix with n = number of images, m = number of
    % features
        display(modelNames{index});
        length = size(listOfFeatures{index}, 1);
        
        startIndex = uint32(length*p);
        labelsYes = ones(length - startIndex + 1,1);
        labelsNo = zeros(length - startIndex + 1,1);

%         display(startIndex);
%         display(length);
        testData = listOfFeatures{index}(startIndex :length, :);

        %arr = zeros(length - startIndex  + 1, 14);
        numOfModels = size(listOfModels, 2);
        arr = zeros(length - startIndex  + 1, numOfModels+2);
        for i=1:size(listOfFeatures, 2)
            if(i == index)
                testLabels = labelsYes;
            else
                testLabels = labelsNo;
            end
            
            [pl, acc, prob] = svmpredict(testLabels, testData,  listOfModels{i}, '-b 1');
            arr(:,i) = prob(:,1);
        end

        for i=1:length - length*p + 1
            maxp = 0;
            tmpID = 0;
            for j=1:numOfModels
                if(maxp<arr(i,j))
                    maxp = arr(i,j);
                    tmpID = j;
                end
            end
            arr(i, numOfModels + 1) = maxp;
            arr(i, numOfModels + 2) = tmpID ;
        end
        
    confusion = zeros(1, numOfModels+1);
    confusion(1, numOfModels+1) = size(arr,1);
    for k=1:numOfModels
        confusion(1, k) =  numel(find(arr(:,numOfModels+2)==k));
    end
end