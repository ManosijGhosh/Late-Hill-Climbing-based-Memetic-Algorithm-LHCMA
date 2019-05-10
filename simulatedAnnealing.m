function [] = simulatedAnnealing(x,t,x2,t2)
global memory;
tic
% x = load('Data/input.mat');           %input file
% x = x.inputs.input;
% t = load('Data/input_label.mat');      %input label
% t = t.input_label.input1;
% x2 = load('Data/test.mat');            %training file
% x2 = x2.test.test;
% t2 = load('Data/test_label.mat');     %training label
% t2 = t2.test_label.test1;

num=size(x,2);
fset=zeros(1,num);
fsetacc=0;
classifier = cell(0);
maxf=int16(num*0.75);
minf=int16(num*0.40);

count=int16(minf+(maxf-minf)*rand());
[~,index]=sort(rand(1,num));

for i=1:count
    fset(1,index(i))=1;
end

temp_min=10;
alpha=.95;
temp=100;%100
extent=5;
probM=.03;
while temp>temp_min
    tempf=fset;
    tempAcc=fsetacc;
    for i=1:extent
        newfset=mutate(fset,probM);
        [nfsetacc,tempClassifier]=classify(x,t,x2,t2,newfset);
        diff=fsetacc-nfsetacc;
        if diff <=0
            tempf=newfset;
            tempAcc=nfsetacc;
            classifier = tempClassifier;
        elseif (exp(-diff/temp)>=rand())
            tempf=newfset;
            tempAcc=nfsetacc;
            classifier = tempClassifier;
        end
    end
    fset=tempf;
    fsetacc=tempAcc;
    temp=alpha*temp;
    %disp(temp);
    fprintf('Result : accuracy - %f  features - %d\n',fsetacc,sum(fset(:)));
end
fprintf('Final result : accuracy - %f  features - %d\n',fsetacc,sum(fset(:)));
save('results.mat','fsetacc','fset','classifier');
% testing
% test = load('Data/test.mat');
% test = test.test.test;
% test_label = load('Data/test_label.mat');
% test_label = test_label.test_label.test1;
% targets = test_label;
% disp(size(test));disp(size(fset));
% inputs=test(:,fset(:)==1);
% 
% inputs = inputs';
% targets = targets';
% outputs = classifier(inputs);
% %outputs
% [c, ] = confusion(targets,outputs);
% fprintf('The number of features  : %d\n', sum(fset(:)==1));
% fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
% fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);
% test_acc=1-c;
% save('results.mat','fsetacc','fset','classifier','test_acc');
memory.population = fset;
memory.rank = fsetacc;
end


function [fset] = mutate(fset,probM)
num=size(fset,2);
for i=1:num
    if(rand<=probM)
        fset(1,i)=1-fset(1,i);
    end
end
end

