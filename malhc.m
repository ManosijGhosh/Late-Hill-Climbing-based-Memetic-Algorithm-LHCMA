%Initial or First Level Feature Selection (MA 1st level)
%the network, population stored in results.mat, copy into Run folder if better accuracy achieved
function []=malhc(x,t,x2,t2,str)
tic
rng('shuffle');
global memory; % stores the results
%%{
% str = 'A:/Study/Project/RSProject/EmotionRecognition/Code_Data_Results/DataEmotion/RAFD/Set_size_324/';% DataEmotion/RAFD/Set_size_900/train.mat
% x=importdata(strcat(str,'train.mat'));
% x2=importdata(strcat(str,'test.mat'));
% t=importdata(strcat(str,'trainLabel.mat'));
% t2=importdata(strcat(str,'testLabel.mat'));

maxRelMinRed(x,t,str);
relevancy=importdata(strcat(str,'relevancy.mat'));
redundancy=importdata(strcat(str,'redundancy.mat'));
%}
%{
temp=importdata('DataEmotion/CKPlus/Input.xlsx');
x=temp.values;
t=temp.classLabels;
%size(t)

chr=temp.division;

x2=x(chr(:)==1,:);
t2=t(chr(:)==1,:);
x=x(chr(:)==0,:);
t=t(chr(:)==0,:);
%}
%{
temp=importdata('DataEmotion/hog_train.xlsx');
disp(temp);
x=temp.values;
t=temp.classLabels;
temp=importdata('DataEmotion/hog_test.xlsx');
x2=temp.values;
t2=temp.classLabels;
%}
disp('imports done');
[~,c]=size(x);
%n=int16(input('Enter the number of chromosomes to work on :'));
n=15 ;   % To change population Size
iteration = 15;
%mcross=int16(input('Enter the maximum number of crossovers to do :'));
mcross=int16(n/2);
size(x)
population=datacreate(n,c);   % Feature Length
probM=0.03;
probC=0.5;

disp('total accuracy');
classify(x,t,x2,t2,ones(1,c));

fprintf('data created\n');
%[r,c]=size(population);
rank=zeros(1,n);
rankcs=zeros(1,n);
netArray=cell(n,1);

[population,rank,netArray]=chromosomeRank(x,t,x2,t2,population,rank,netArray,0,1);
fprintf('Chromosomes ranked\n');

%{
        [r,c]=size(t2);
        target=t2(1:r,1:c);
        input=x2(1:r,population(1,:)==1);
        
        inputs = input';
        targets = target';
        outputs = netArray{1}(inputs); %this is how saved net is to be used later

        [c, ] = confusion(targets,outputs);
        fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
%}
str=strcat('Results/result','.mat');
fnum=25;acc=0.99;count=int16(1);%fum- length of reduced feature set desired; acc- accuracy of reduced set desired
%frank gives position where the features are whose rank is index
%ftrank(1)=position of feature of rank 1.
while ((sum(population(1,:)==1)>fnum || rank(1)<acc) && (count<=iteration))    % To Change if reqd..count - number of iterations
    
    
    %crossover starts
    fprintf('\nCrossover done for %d th time\n',count);
    limit = mcross;%assmming at max m crossovers
    %(mod(rand(1,int16),(n))+1)
    for i=1:limit
        %cumulative sum for crossover
        rankcs(1:n)=rank(1:n);%copying the values of rank to rankcs
        for j= 2:n% size of weights = no. of features in popaulation=c
            rankcs(j)=rankcs(j)+rankcs(j-1);
        end
        maxcs=rankcs(n);
        for j= 1:n
            rankcs(j)=rankcs(j)/maxcs;
        end
        a=find(rankcs>rand(1),1,'first');
        b=find(rankcs>rand(1),1,'first');
        %roulette wheel ends
        
        [population,rank,netArray]=crossover(x,t,x2,t2,population,a,b,probC,probM,rank,netArray);
        [population,rank,netArray]=chromosomeRank(x,t,x2,t2,population,rank,netArray,1,0);
        
        clear a b j rankcs;
    end
    %crossover ends
    % local search - LAHCRR
    %%{
    fprintf('Local search done for %d th time\n',count);
    [population,rank,netArray]=localsearch(x,t,x2,t2,population,rank,netArray,relevancy,redundancy,probM);
    %}
    count=count+1;
    % sorts and ranks the chromosomes
    [population,rank,netArray]=chromosomeRank(x,t,x2,t2,population,rank,netArray,1,1);
    
    
    %if ( count==5 || count==10 || count == 15 )
    disp('Results saved');
    save('result.mat','population','rank','netArray');
    %end
end
fprintf('The least number of features is : %d\n',sum(population(1,:)==1));
fprintf('The best accuracy is : %d\n',rank(1));
% stores results in global variable for main_loop to access
memory.rank = rank;
memory.population = population;
save('result.mat','population','rank','netArray');
disp('Final results stored');
%{
    %error and net check
    firstL=matfile('results.mat');
    nets=firstL.netArray;
    for i=1:n
        net=nets{i};
        view(net);
        out=net(x2(population(i,:)==1));
        [c, ]=confusion(t2',out);
        fprintf('The size of %d = %d and accuracy is %f\n',i,sum(population(i,:)==1),((1-c)*100));
    end
%}
toc
end