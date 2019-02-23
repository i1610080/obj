addpath('.');

list1=textread('train_yakisoba.txt','%s');
list2=textread('test_yakisoba.txt','%s');
list3=textread('train_elephant.txt','%s');
list4=textread('test_elephant.txt','%s');

OUTDIR='imgs_train_yakisoba';
mkdir(OUTDIR);
for i=1:size(list1,1)
    fname=strcat(OUTDIR,'/',num2str(i,'%04d'),'.jpg');
    websave(fname,list1{i});
end

OUTDIR2='imgs_test_yakisoba';
mkdir(OUTDIR2);
for i=1:size(list2,1)
    fname=strcat(OUTDIR2,'/',num2str(i,'%04d'),'.jpg');
    websave(fname,list2{i});
end

OUTDIR3='imgs_train_elephant';
mkdir(OUTDIR3);
for i=1:size(list3,1)
    fname=strcat(OUTDIR3,'/',num2str(i,'%04d'),'.jpg');
    websave(fname,list3{i});
end

OUTDIR4='imgs_test_elephant';
mkdir(OUTDIR4);
for i=1:size(list4,1)
    fname=strcat(OUTDIR4,'/',num2str(i,'%04d'),'.jpg');
    websave(fname,list4{i});
end

LIST = {'imgs_train_yakisoba/' 'imgs_test_yakisoba/' 'imgs_train_elephant/' 'imgs_test_elephant/'};
list = {};

for i=1:length(LIST)
    d=dir(LIST{i});
    
    for j=1:size(d)
        if (strfind(d(j).name,'.jpg'))
            fn=strcat(LIST{i},d(j).name);
            list={list{:} fn};
        end
    end
end

random={};
DIR = '/usr/local/class/object/bgimg/';
W=dir(DIR);
for i=1:1002
    if (strfind(W(i).name ,'.jpg'))
        fn=strcat(DIR,W(i).name);
        random={random{:} fn};
    end
end

save('img_list.mat','list');
save('random.mat','random');
