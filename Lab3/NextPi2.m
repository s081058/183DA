function [Pi] = NextPi2(CurrentEval,pe)
%Creates a new policy Pi based on the Policy Evaluation CurrentEval of an existing
%policy and error probability pe
%   Calculates the sum of the transition proability from s to sprime times the value of the
%  CurrentEval at sprime for each every action of every state.  Selects as
%  policy the action at each state with the highest sum.
PiValues=zeros(6,6,12);
PiValues=PiValues-10^100; %Initialize the values to compare calculated values against to negative infinity
for i=0:5 %X
    for j=0:5 %Y
        for k=0:11 %H
            for a=["FL","F","FR","BL","B","BR"]; %do not consider staying still
                b=0;
                for l=0:5 %X'
                    for m=0:5 %Y'
                        for n=0:11 %H'
                            %if (sum([i,j,k]==[l,m,n])~=3) || (sum([i,j]==[3,4])==2) %prevents no movem action outside of the goal 
                                b=b+TransProb2(pe,[i,j,k],a,[l,m,n])*CurrentEval(l+1,m+1,n+1); %dummy variable to reduce calculation repetition
                            %end
                        end
                    end
                end
                if PiValues(i+1,j+1,k+1)<b
                    PiValues(i+1,j+1,k+1)=b;
                    Pi(i+1,j+1,k+1)=a;
                end
            end
        end
    end
end
Pi(4,5,:)="N";
end

