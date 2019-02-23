addpath('.');

list1=textread('url_cat.txt','%s');
list2=textread('url_dog.txt','%s');
list3=textread('url_wolf.txt','%s');

OUTDIR='imgs_cat';
mkdir(OUTDIR);
for i=1:size(list1,1)
  fname=strcat(OUTDIR,'/',num2str(i,'%04d'),'.jpg');
  websave(fname,list1{i});
end

OUTDIR2='imgs_dog';
mkdir(OUTDIR2);
for i=1:size(list2,1)
  fname=strcat(OUTDIR2,'/',num2str(i,'%04d'),'.jpg');
  websave(fname,list2{i});
end

OUTDIR3='imgs_wolf';
mkdir(OUTDIR3);
for i=1:size(list3,1)
  fname=strcat(OUTDIR3,'/',num2str(i,'%04d'),'.jpg');
  websave(fname,list3{i});
end

LIST = {'imgs_cat/' 'imgs_dog/' 'imgs_wolf/'};
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

cat_dog_list = list(1:400);
dog_wolf_list = list(201:600);

save('imgs_list.mat','list');
save('cat_dog_list.mat','cat_dog_list');
save('dog_wolf_list.mat','dog_wolf_list');