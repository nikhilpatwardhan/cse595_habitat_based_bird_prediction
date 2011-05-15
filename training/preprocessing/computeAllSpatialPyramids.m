% Computes spatial pyramids for all images
addpath('../../utils/spatial_pyramid/');

image_dir = '../../data/images/'; 
data_dir = '../../matfiles/spatial_pyramid_data/';

fnames = dir(fullfile(image_dir, '*.jpg'));
num_files = size(fnames,1);
filenames = cell(num_files,1);

for f = 1:num_files
	filenames{f} = fnames(f).name;
end

pyramid_all = BuildPyramid(filenames,image_dir,data_dir);

K = hist_isect(pyramid_all, pyramid_all);

save('../../matfiles/pyramid_all.mat','pyramid_all');
save('../../matfiles/kernel.mat','K');