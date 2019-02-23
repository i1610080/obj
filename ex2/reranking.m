addpath('.');

load('img_list.mat','list');

for m =1:2
    if m==1
        list2=list(51:350);
    else
        list2=list(401:700);
    end
    for n = [25 50]
        mat_name1=strcat('sorted_score','(',int2str(m),',',int2str(n),')','.mat');
        mat_name2=strcat('sorted_idx','(',int2str(m),',',int2str(n),')','.mat');
        load(mat_name1,'sorted_score');
        load(mat_name2,'sorted_idx');
        filename=strcat('reranking','(',int2str(m),',',int2str(n),')','.txt');
        FID = fopen(filename,'w');
        for i=1:100
            fprintf(FID,'%s %f\n',list2{sorted_idx(i)},sorted_score(i));
        end
        fclose(FID);
    end
end