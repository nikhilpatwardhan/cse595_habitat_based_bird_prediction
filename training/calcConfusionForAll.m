function [accCount accPerc]=calcConfusionForAll(features,p)
%% This function tests the models for all categories and outputs a
%% confusion matrix in two forms (one having just the counts / the other
%% haivng percentages) The last column is the total number of test images.
load '../matfiles/classifiers.mat';
load '../matfiles/groupIndices.mat';

len = length(features);
accCount = zeros(len,len+1);

for i=1:len
    accCount(i, :) = calcConfusion(i, features, classifiers, model_names, p);
end

accPerc = zeros(len,len+1);
for i=1:12
    accPerc(i, 1:len) = accCount(i, 1:len)/accCount(i, len+1);
    accPerc(i, len+1) = accCount(i, len+1);
end
accPerc(:,1:len)=accPerc(:,1:len)*100;      % Convert counts to %

save(sprintf('../matfiles/accuracies.mat'), 'accCount');