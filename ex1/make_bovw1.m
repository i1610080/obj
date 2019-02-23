

k=1000;

addpath('/usr/local/class/object/MATLAB/sift');

for a=1:2
    if a == 1
        load('cat_dog_list.mat');
        load('cat_dog_cb.mat','codebook');
        list = cat_dog_list;
    else
        load('dog_wolf_list.mat');
        load('dog_wolf_cb.mat','codebook');
        list = dog_wolf_list;
    end
    code=[];
    
    for i=1:length(list)
        c=zeros(k,1);
        I=im2double(rgb2gray(imread(list{i})));
        fprintf('reading [%d] %s\n',i,list{i});
        [f d]=sift_rand(I,'randn',3000);
        
        for j=1:size(d,2)
            s=zeros(1,k);
            for t=1:128
                s=s+(codebook(t,:)-d(t,j)).^2;
            end
            [dist sidx]=min(s);
            c(sidx,1)=c(sidx,1)+1.0;
        end
        c=c/sum(c);
        code=[code c];
    end
    
    if a == 1
        save('cat_dog_bovw1.mat','code');
    else
        save('dog_wolf_bovw1.mat','code');
    end
    
end
