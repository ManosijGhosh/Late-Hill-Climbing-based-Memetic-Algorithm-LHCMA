function [] = main_loop()
global x t x2 t2 memory;


k = 5;
populationSize = 15;
iteration = 50;
count = 30;
%{
for i =19:count
    fprintf('\n======================================\n');
    fprintf('              %d                    \n',i);
    fprintf('======================================\n');
    %Data/data1/testLabel.mat'
    x = importdata(strcat('Data/data',num2str(i),'/','train.mat'));
%     x = x.input;
    t = importdata(strcat('Data/data',num2str(i),'/','trainLabel.mat'));
%     t = t.input1;
    x2 = importdata(strcat('Data/data',num2str(i),'/','test.mat'));
%     x2 = x2.test;
    t2 = importdata(strcat('Data/data',num2str(i),'/','testLabel.mat'));
%     t2 = t2.test1;
     [per,~]=svmClassifier(x,t,x2,t2,ones(1,size(x,2)));
     fprintf('Total performance - %f\n',per);
    str = strcat('Data/data',num2str(i),'/');
    %malhc(x,t,x2,t2,str);
    simulatedAnnealing(x,t,x2,t2);
    %displayMemory(memory);
    save(strcat('Results/data',num2str(i),'_memory','.mat'),'memory');
    
end
%}
extractBestResults(count);
%extractAverageResults(datasets);
end

function [] = displayMemory(memory)
global x
disp('FINAL RESULT');
fprintf('NUM-%d ACC-%f\n',(sum(memory.features)/size(x,2))*100,memory.accuracy*100);
end

function [] = extractBestResults(count)
fprintf('Best results -- \n');
for i =22:24
    memory = load(strcat('Results_ma_mrmr_run2/data',num2str(i),'_memory.mat'));
    memory = memory.memory;
%    fprintf('%d\t%d\t%5.4f\n',i,sum(memory.population(1,:)),memory.rank(1));
    fprintf('%d\t%5.4f\n',sum(memory.population(1,:)),memory.rank(1));
end
end

function [] = extractAverageResults(count)
fprintf('Average results -- \n');
count = size(datasets,2);
for i =1:count
    memory = load(strcat('Results/',datasets{i},'_memory.mat'));
    memory = memory.memory;
    fprintf('%f\t%d\n',mean(memory.rank),100*(mean(sum(memory.population),2)/size(memory.population,2)));
end
end