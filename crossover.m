function [population,rank,netArray]=crossover(x,t,x2,t2,population,id1,id2,probC,probM,rank,netArray)
    rng('shuffle');
    [r,c]=size(population);
    %if rand(1)<=probC%probC is flipping probability, higher it is more 
        %{
        %single point mutation
        point=int16(rand(1)*(c-1))+1;%genrates random integer btw [1,c]
        arr1=population(id1,:);
        arr2=population(id2,:);
        population2(1,1:point-1)=arr1(1,1:point-1);%copies part of arr1 into population2(1)
        population2(2,1:point-1)=arr2(1,1:point-1);
        
        population2(1,point:c)=arr2(1,point:c);%copies part of arr1 into population2(1)
        population2(2,point:c)=arr1(1,point:c);
        %}
        
        %uniform mutation
        population2(1,1:c)=population(id1,:);
        population2(2,1:c)=population(id2,:);
        
        for i=1:c
            if(rand(1)<=probC)
                temp=population2(1,i);
                population2(1,i)=population2(2,i);
                population2(2,i)=temp;
            end
        end
        clear arr1 arr2;
        %mutation --
        
        for i=1:c
            
            if(rand(1)<=probM)
                population2(1,i)=1-population2(1,i);
            end
            
            if(rand(1)<=probM)
                population2(2,i)=1-population2(2,i);
            end
        end
        %mutation ends
        
        [rch1,net1]=classify(x,t,x2,t2,population2(1,:));
        [rch2,net2]=classify(x,t,x2,t2,population2(2,:));
        for i = r:-1:1
            if(chromosomecomparator(population(i,1:c),rank(i),population2(1,1:c),rch1)<0)
                fprintf('Replaced chromosome at %d in crossover with first\n',i);
                population(i,1:c)=population2(1,1:c);%substituition of chromose can be better
                rank(i)=rch1;
                netArray{i}=net1; %saving the net
                break;
            end
        end
        for i = r:-1:1
            if(chromosomecomparator(population(i,1:c),rank(i),population2(2,1:c),rch2)<0)
                fprintf('Replaced chromosome at %d in crossover with second\n',i);
                population(i,1:c)=population2(2,1:c);
                rank(i)=rch2;
                netArray{i}=net2;
                break;
            end
        end
    %end
end