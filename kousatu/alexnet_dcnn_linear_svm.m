
addpath('.');
clearvars;
addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');

tic;
vl_setupnn;
net = load('imagenet-caffe-alex.mat') ;

load('imgs_list','list');

dc = [];
for i = 1:600
    im = imread(list{i}) ;
    im_ = single(im) ;
    im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
    im_ = im_ - net.meta.normalization.averageImage ;
    res = vl_simplenn(net, im_);
    dcnnf = squeeze(res(end-3).x);
    dc = [dc, dcnnf/norm(dcnnf)];
end


r=zeros(2, 5);
cv=5;
dc = dc';
idx = [1:400];
FID = fopen('error_alaxnet_dcc_linear_svm.txt','w');
for a =1:2
    if a==1
        dc2 = dc(1:400,:);
    else
        dc2 = dc(201:600,:);
    end
    for b=1:cv
        eval = dc2(find(mod(idx,cv)==(b-1)),:);
        train = dc2(find(mod(idx,cv)~=(b-1)),:);
        label=[ones(160,1); ones(160,1)*(-1)];
        label2=[ones(40,1); ones(40,1)*(-1)];
        model=fitcsvm(train,label,'KernelFunction','linear');
        [plabel,~]=predict(model,eval);
        r(a,b)=numel(find(label2==plabel))/numel(label2);
        for e=find(label2~=plabel)
            fprintf(FID,'%s\n',list{5*(e-1)+b+200*(a-1)});
        end
    end
end
fclose(FID);

fprintf('猫と犬の分類率: %.4f\n',mean(r(1,:)))
fprintf('犬とオオカミの分類率: %.4f\n',mean(r(2,:)))
toc;