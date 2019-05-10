function []=frankingfile()
    x=importdata('DataIAM/train.mat');
    t=importdata('DataIAM/trainLabel.mat');
    tar=zeros(size(t,1),1);
    for i=1:size(t,1)
        tar(i,1)=find(t(i,:),1);
    end
    k=10;tar=tar';
    disp(tar);
    [ftrank,weights] = relieff(x,tar,k,'method','classification');%feature ranking
    bar(weights);
    xlabel('Predictor rank');
    ylabel('Predictor importance weight');
    clear tar k;
    fp=fopen('DataIAM/franks.txt','w');
    [~,c]=size(x);
    for i=1:c
        fprintf(fp,'%d\t',ftrank(i));
        fprintf('%d\t',ftrank(i));
    end
    fclose(fp);
    fprintf('\n');
end
    