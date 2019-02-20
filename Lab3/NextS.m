function [SPrime] = NextS(pe,s,a)
%Generates the next state given an error probability Pe, current state S,
%and action a
%   Uses TransProb2
b=rand(); %Generate a number between 0 and 1
for i=0:5; %x'
    for j=0:5; %y'
        for k=0:11; %h'
            b=b-TransProb2(pe,s,a,[i,j,k]); %Subtract the transition probability from the number
            if b<=0
                SPrime=[i,j,k]; %If the number goes negative, the checked next state is the actual next state
                b=b+100; %prevent the number from going negative again, ensures only the one action was taken.
            end
        end
    end
end


end

