addpath('/usr/local/class/object/MATLAB/sift');
run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');
k=1000;

for j=2:2
    if j == 1
        load('cat_dog_list.mat');
        list = cat_dog_list;
    else
        load('dog_wolf_list.mat');
        list = dog_wolf_list;
    end
    desc=[];
    for i=1:length(list)
        I=im2double(rgb2gray(imread(list{i})));
        fprintf('reading [%d] %s\n',i,list{i});
        [f d]=sift_rand(I,'randn',3000);
        desc=[desc d];
    end
    
    size(desc)
    [codebook, idx]=vl_kmeans(desc,k);
    size(codebook)
    % codebook を save します．
    if j == 1
        save('cat_dog_cb.mat','codebook');
    else
        save('dog_wolf_cb.mat','codebook');
    end
    
end

