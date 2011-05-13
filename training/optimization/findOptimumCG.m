clear;
load '../../matfiles/finalPyramids.mat';
load '../../matfiles/finalPyramidLengths.mat';
load '../../matfiles/modelNames.mat';

addpath('../../utils/libsvm-mat-3.0-1');

p = 0.5;

labels={};
for j=1:12
   labels{j} = zeros(pyramidLengths{j}, 1);
end

bc=[];
bestcv = 0;

for k=1:12
    testLabels = labels;
    testLabels{k}(:) = 1;

    [ts, tl] = createTrainingSets(p, k, pyramids, pyramidLengths, testLabels);

    bestcv = 0;
    for log2c = -1:10,
      for log2g = -4:1,
        cmd = ['-v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
        cv = svmtrain(tl', ts', cmd);
        if (cv >= bestcv),
          bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
        end
      end
    end

    bc(1,i) = bestc;
    bc(2,i) = bestg;
    bc(3,i) = bestcv;
end;

save('../../matfiles/bestcg.mat','bc','bg','bcv');
