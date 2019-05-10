function [population,rank,netArray]=localsearch(x,t,x2,t2,population,rank,netArray,relevancy,redundancy,probM)
[r,c]=size(population);

for i=1:r
    temp= lahc(population(i,1:c),relevancy,redundancy,probM);
    
    [tempr,net]=classify(x,t,x2,t2,temp);
    val=chromosomecomparator(temp,tempr,population(i,1:c),rank(i));
    fprintf('Local search on %d th position & val is %f\n',i,val);
    if (val>0)
        fprintf('Replaced chromosome at %d in local search\n',i);
        population(i,1:c)=temp(1:c);
        rank(i)=tempr;
        netArray{i}=net;
    end
end
end

function [chr] = lahc(chr,relevancy,redundancy,probM)
lh=4;
costs=zeros(1,lh);
costs = costs + evaluate(chr,relevancy,redundancy);
prev = costs(1);
for i=0:50
    pos = mod(i,lh)+1;
    temp=chr;
    for j = 1:size(chr,2)
        if rand<probM
            temp(1,j) = 1 - temp(1,j);
        end
    end
    val = evaluate(temp,relevancy,redundancy);
    if (costs(1,pos) < val) || (prev <= val)
        chr = temp;
        prev = val;
    end
    if (costs(1,pos) < val)
        costs(1,pos) = val;
    end
end
end

function [val]=evaluate(temp,relevancy,redundancy)
featureIndex=find(temp);
num=size(featureIndex,2);
d=0.0;
for i=1:num
    d = d + relevancy(featureIndex(i));
end
d=d/num;
r=0;
for i=1:num-1
    for j=i+1:num
        r = r + redundancy(featureIndex(i),featureIndex(j));
    end
end
r = r / ((num*(num-1))/2);
val = d - r;
end