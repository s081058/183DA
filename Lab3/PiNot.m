function [AStars] = PiNot()
%Call function InitPoli for every state, output the action prescribed by
%the policy at all states in a matrix of strings
%   self explanatory
for i=0:5; %x
    for j=0:5; %y
        for k=0:11; %h
            AStars(i+1,j+1,k+1)=InitPoli3([i,j,k]); %follow the initial policy
        end
    end
end
end

