addpath('.');
clearvars;

tic;
cv=5;
idx=[1:400];
r=zeros(2,5);
for a=1:2
    if a==1
        load('cat_dog_bovw1.mat','code');
        data = code';
    else
        load('dog_wolf_bovw1.mat','code');
        data = code';
    end
    for b=1:5
        eval = data(find(mod(idx,cv)==(b-1)),:);
        train = data(find(mod(idx,cv)~=(b-1)),:);
        label=[ones(160,1); ones(160,1)*(-1)];
        label2=[ones(40,1); ones(40,1)*(-1)];
        model=fitcsvm(train,label,'KernelFunction','rbf','KernelScale','auto');
        [plabel,~]=predict(model,eval);
        r(a,b)=numel(find(label2==plabel))/numel(label2);
    end
end

fprintf('猫と犬の分類率: %.4f\n',mean(r(1,:)))
fprintf('犬とオオカミの分類率: %.4f\n',mean(r(2,:)))
toc;