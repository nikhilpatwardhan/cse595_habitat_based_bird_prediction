%% This script looks for black and white images and displays them
%  These are the images for whom a color histogram cannot be computed and
%  hence must be removed from the training dataset.

baseDir = '../../data/images/';

list = dir(strcat(baseDir,'*.jpg'));

for i= 1:length(list)
    I = imread(strcat(baseDir,list(i).name));
    
    [x y z] = size(I);
    
    if (z ~= 3)
        disp(list(i).name);
    end;
end;