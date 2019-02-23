run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');

n=0;
list1=[];
load('imgs_list.mat','list');

tic;
for j=1:size(list,2)
    I=imread(list{j});
    R=I(:,:,1);
    G=I(:,:,2);
    B=I(:,:,3);
    X64= floor(double(R)/64) *4*4 +  floor(double(G)/64) *4 +  floor(double(B)/64);
    X64_vec=reshape(X64,1,numel(X64));
    h=histc(X64_vec,[0:63]);
    h=h./sum(h);
    list1=[list1; h];
end

r=zeros(2, 5);
cv=5;
idx=[1:400];
for a=1:2
    if a == 1
        data = list1(1:400,:);
    else
        data = list1(201:600,:);
    end
    for b=1:cv
        eval = data(find(mod(idx,cv)==(b-1)),:);
        train = data(find(mod(idx,cv)~=(b-1)),:);
        for c=1:size(eval,1)
            eval2=repmat(eval(c,:), size(train, 1), 1);
            D = sum((train - eval2).^2, 2);
            [~, n] = min(D);
            if c<=size(eval,1)/2 && n<=size(train,1)/2 || c>size(eval,1)/2 && n>size(train,1)/2
                r(a,b)=r(a,b)+1;
            end
        end
        r(a,b)=r(a,b)/size(eval,1);
    end
end

fprintf('猫と犬の分類率: %.4f\n',mean(r(1,:)))
fprintf('犬とオオカミの分類率: %.4f\n',mean(r(2,:)))
toc;

