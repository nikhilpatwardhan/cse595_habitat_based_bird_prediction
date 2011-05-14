%% Color + GIST accuracies
load '../../matfiles/colorgist.mat';

addpath('../../utils/libsvm-mat-3.0-1');
addpath('../');

cd ..;

features = colorgist;

acc=zeros(14,18);
p=0.5;
i=1;
for log2c = 5:9,
  for log2g = -4:3,
      disp(log2c);
      disp(log2g);
      
    generateModels(features,log2c,log2g,p);
    ans=calcAccForAll(features,p);
    acc(3:14,i) = ans;
    acc(1,i) = 2^log2c;
    acc(2,i) = 2^log2g;
    i=i+1;
  end
end

save('../matfiles/colorgistacc.mat','acc');

%% Only GIST accuracies
load '../matfiles/finalGists.mat';
features = finalGists;

acc=zeros(14,18);
p=0.5;
i=1;
for log2c = 5:9,
  for log2g = -4:3,
      disp(log2c);
      disp(log2g);
      
    generateModels(features,log2c,log2g,p);
    ans=calcAccForAll(features,p);
    acc(3:14,i) = ans;
    acc(1,i) = 2^log2c;
    acc(2,i) = 2^log2g;
    i=i+1;
  end
end

save('../matfiles/onlygistacc.mat','acc');