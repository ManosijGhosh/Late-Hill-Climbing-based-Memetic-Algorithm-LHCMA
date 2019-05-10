function []=dataBuilding()
    x=importdata('Gabor_Wavelets_60.csv');
    [r,c]=size(x);
    noOfClass=12;
    noOfSamples=300;
    trainRatio=.66;
    testRatio=.34;
    c=c-1;
    %targets building
    trainTargets=int16(zeros(int16(r*trainRatio),noOfClass));
    testTargets=int16(zeros(int16(r*testRatio),noOfClass));

    temp=int16(trainRatio*noOfSamples);
    count=1;
    for i=1:noOfClass
        for j=1:temp
            trainTargets(count,i)=int16(1);
            count=count+1;
        end
    end

    temp=int16(testRatio*noOfSamples);
    count=1;
    for i=1:noOfClass
        for j=1:temp
            testTargets(count,i)=int16(1);
            count=count+1;
        end
    end

    save('trainTargets.mat','trainTargets');
    save('testTargets.mat','testTargets');

    train=zeros(int16(trainRatio*noOfSamples),c);
    test=zeros(int16(testRatio*noOfSamples),c);
    countTrain=1;countTest=1;count=1;
    for i=1:noOfClass
        for j=1: int16(trainRatio*noOfSamples)
            train(countTrain,1:c)=x(count,1:c);
            countTrain=countTrain+1;
            count=count+1;
        end
        for j=1: int16(testRatio*noOfSamples)
            test(countTest,1:c)=x(count,1:c);
            count=count+1;
            countTest=countTest+1;
        end
    end

    disp(strcat('train - ',num2str(size(train))));
    disp(strcat('test - ',num2str(size(test))));

    save('train.mat','train');
    save('test.mat','test');
end