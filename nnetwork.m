%function [performance]=nnetwork(population,id)
function [performance,net]=nnetwork(x,t,x2,t2,chromosome)
%performance=mod(rand(1),.85);

%%{
c=size(x,2);
if c>800
    hiddenLayerSize = 420;
elseif c>500
    hiddenLayerSize = 400;
elseif c>300
    hiddenLayerSize = 325;
elseif c>100
    hiddenLayerSize = 220;
else
    hiddenLayerSize = 100;
end
%}
%hiddenLayerSize = 20;  %determins the umber of layers and neurons in hidden layers
net = patternnet(hiddenLayerSize);
net.trainParam.showWindow = 0;
%%{
if (sum(chromosome(:)==1)==0)
    performance=0;
else
    [r,c]=size(t);
    target=t(1:r,1:c);
    %input=x(1:r,chromosome(:)==1);
    [~,sz]=size(chromosome);    %36 is the number of blocks
    
    %for normal selection
    %disp('x size');
    %size(x)
    %disp('chromosome check');
    % size(chromosome)
    input=x(1:r,chromosome(:)==1);
    %shuffle
    [~,random1]=sort(rand(1,size(x,1)));
    input=input(random1,:);
    target=target(random1,:);
    %shuffle ends
    
    inputs = input';
    targets = target';
    
    % Setup Division of Data for Training, Validation, Testing
    
    net.divideParam.trainRatio = 85/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 0/100;
    
    
    %[trainInd,valInd,testInd] = net.divideind(r,trainInd,valInd,0);
    
    % Train the Network
    [net, ] = train(net,inputs,targets);
    
    % Test the Network
    [r,c]=size(t2);
    target=t2(1:r,1:c);
    %input=x2(1:r,chromosome(:)==1);
    
    [~,sz]=size(chromosome);
    
    %for normal selection
    input=x2(1:r,chromosome(:)==1);
    
    inputs = input';
    targets = target';
    outputs = net(inputs);
    %outputs
    [c, ] = confusion(targets,outputs);
    fprintf('The number of features  : %d\n', sum(chromosome(:)==1));
    fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
    fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);
    performance=1-c;%how much accuracy we get
    % View the Network
    %view(net);
end
%}
end