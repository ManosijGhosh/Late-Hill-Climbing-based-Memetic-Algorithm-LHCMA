function []=featureClustering()
path='';
x=importdata(strcat(path,'train.mat'));
x=x'; % each feature is a row now
clusters=kmeans(population,k,'MaxIter',200,'Display','final','Distance','hamming','Replicates',3);

fp=fopen(strcat(path,'cluster.txt'),'w');
c=size(clusters,1);
for i=1:c
    fprintf(fp,'%d\t',clusters(i));
    fprintf('%d\t',clusters(i));
end
fclose(fp);
fprintf('\n');
end
