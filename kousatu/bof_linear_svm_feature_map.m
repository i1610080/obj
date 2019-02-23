addpath('.');
clearvars;

tic;
cv=5;
idx=[1:400];
load('imgs_list','list');
FID = fopen('error_bof_linear_svm_feature_map.txt','w');

for a=1:2
    if a==1
        load('cat_dog_bovw1.mat','code');
        data = code';
    else
        load('dog_wolf_bovw1.mat','code');
        data = code';
    end
    for b=1:cv
        eval = data(find(mod(idx,cv)==(b-1)),:);
        train = data(find(mod(idx,cv)~=(b-1)),:);
        label=[ones(160,1); ones(160,1)*(-1)];
        label2=[ones(40,1); ones(40,1)*(-1)];
        bovw3=repmat(sqrt(abs(train)).*sign(train),[1 3]).*[0.8*ones(size(train)) 0.6*cos(0.6*log(abs(train)+eps)) 0.6*sin(0.6*log(abs(train)+eps))];
        bovw4=repmat(sqrt(abs(eval)).*sign(eval),[1 3]).*[0.8*ones(size(eval)) 0.6*cos(0.6*log(abs(eval)+eps)) 0.6*sin(0.6*log(abs(eval)+eps))];
        model=fitcsvm(bovw3,label,'KernelFunction','linear');
        [plabel,~]=predict(model,bovw4);
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