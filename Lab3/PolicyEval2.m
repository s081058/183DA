function [Values] = PolicyEval(Pi,Lambda,pe)
%Evaluates the policy Pi given a Lambda and error probability pe.
%   Initialize values of all states to zero, then given the reward of each
%   state: Repeatedly Update the values of each state with the sum of the
%   transfer probability times (reward(state)+lambda*value(next state)).
%   Continue until the largest change in value of any state is less than
%   0.0001. Uses rewards for problem 5b.
Values=zeros(6,6,12);
OldValues=Values+1;
%For maximum accuracy, uncomment the next line and comment the following.
% while sum(sum(sum(OldValues==Values)))~=432 %Run until no values change
while sum(sum(sum(abs((OldValues-Values))<.0001)))>0 %run until none of the values change by more than 0.0001
    OldValues=Values;
    Values=zeros(6,6,12);
    for i=0:5 %X
        for j=0:5 %Y
            for k=0:11 %H
                for l=0:5 %X'
                    for m=0:5 %Y'
                        for n=0:11 %H'
                            Values(i+1,j+1,k+1)=Values(i+1,j+1,k+1)+TransProb2(pe,[i,j,k],Pi(i+1,j+1,k+1),[l,m,n])*(Reward2([i,j,k])+Lambda*OldValues(l+1,m+1,n+1));
                        end
                    end
                end
            end
        end
    end
end
end

