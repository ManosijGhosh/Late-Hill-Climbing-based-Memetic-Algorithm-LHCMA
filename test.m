function []=test()
%{
    x=load('Data/Gabor/train.mat');   % Training File 
    x=x.train;
    t=load('Data/Gabor/trainTargets.mat');  % Training label
    t=t.trainTargets;
    x2=load('Data/Gabor/test.mat');   % Test File
    x2=x2.test;
    t2=load('Data/Gabor/testTargets.mat');   % Test Label
    t2=t2.testTargets;
    
    size(x)
    size(t)
    size(x2)
    size(t2)
    disp('Imports are done');
    [~,c]=size(x);
    [temp,~]=groupSelection(x,t,x2,t2,'Gabor');
    %}
    temp=load('ResultStore/resultGabor.mat');
    temp=temp.population;
    temp =[temp(1,:) 1];
    
    x=importdata('Gabor_Wavelets_60.csv');
    f=x(:,temp(:)==1);
    csvwrite('GaborReducedPopu.csv',f);
    %}
end