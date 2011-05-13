% Author:   Nikhil Patwardhan
% Date:     07 April 2011
% Program:  To find the gist descriptor of all images in a folder

function findGist(directory,savefile)
list = dir(directory);
[rows,cols] = size(list);
gist = zeros(512,rows-2);

clearvars 'cols';

% Parameters:
clear param
param.imageSize = [400 300]; % it works also with non-square images
param.orientationsPerScale = [8 8 8 8];
param.numberBlocks = 4;
param.fc_prefilt = 4;

%Loop through all the images in the folder. rows also includes entries for '.' and '..'
for j=1:rows-2
    disp(strcat(directory,list(j+2).name));
    % Load image
    img = imread(strcat(directory,list(j+2).name));

    % Computing gist requires 1) prefilter image, 2) filter image and collect
    % output energies
    [g, param] = LMgist(img, '', param);
    gist(:,j) = g;
end;

save(savefile,'gist');