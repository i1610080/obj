
addpath('.');

clearvars;
addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');

load('img_list.mat','list');
load('random.mat','random');
list2 = [list random];

tic;
vl_setupnn;
net = load('imagenet-vgg-verydeep-16.mat') ;

dc = [];
for i = 1:size(list2,2)
    im = imread(list2{i}) ;
    im_ = single(im) ;
    im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
    im_ = im_ - repmat(net.meta.normalization.averageImage,net.meta.normalization.imageSize(1:2));
    res = vl_simplenn(net, im_);
    dcnnf = squeeze(res(end-3).x);
    dc = [dc, dcnnf/norm(dcnnf)];
end


dc = dc';

for m =1:2
    if m==1
        train = [dc(1:50,:);dc(701:1700,:)];
        test = dc(51:350,:);
    else
        train = [dc(351:400,:);dc(701:1700,:)];
        test = dc(401:700,:);
    end
    for n=[50 25]
        if n==25
            train(26:50,:) =[] ;
        end
        label=[ones(n,1); ones(1000,1)*(-1)];
        model=fitcsvm(train,label,'KernelFunction','linear');
        [plabel,score]=predict(model,test);
        [sorted_score,sorted_idx] = sort(score(:,2),'descend');
        mat_name1=strcat('sorted_score','(',int2str(m),',',int2str(n),')','.mat');
        mat_name2=strcat('sorted_idx','(',int2str(m),',',int2str(n),')','.mat');
        save(mat_name1,'sorted_score');
        save(mat_name2,'sorted_idx');
    end
end

toc;