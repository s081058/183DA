function [PiStar,VStar] = ValueIteration(Lambda,pe)
%Calculates the optimal policy PiStar and correspond values VStar for a
%given Lambda and error probability pe.  Uses initial values of 0.
%   Detailed explanation goes here
VOld=zeros(6,6,12); %Initialize all values to 0
check=true; %loop until condition
Policy=strings(6,6,12);
while check
    Policy=strings(6,6,12);
    for i=0:5 %x
        for j=0:5 %y
            for k=0:11 %h
                c=-10^100; %dummy value of negative infinity to compare against
                for a=["FL","F","FR","BL","B","BR"] %consider all moves
                    b=0;
                    for l=0:5 %x'
                        for m=0:5 %y'
                            for n=0:11 %h'
                                b=b+TransProb2(pe,[i,j,k],a,[l,m,n])*(Reward([i,j,k])+Lambda*VOld(l+1,m+1,n+1));
                            end
                        end
                    end
                    if b>c
                        c=b;
                        VNew(i+1,j+1,k+1)=c;
                        Policy(i+1,j+1,k+1)=a;
                    end
                    if sum([i,j]==[4,4])==2 %Set the action for the goal to be no move, and update value
                        VNew(i+1,j+1,k+1)=TransProb2(pe,[i,j,k],"N",[i,j,k])*(Reward([i,j,k])+Lambda*VOld(i+1,j+1,k+1));
                        Policy(i+1,j+1,k+1)="N";
                    end
                end
            end
        end
    end
    if sum(sum(sum(abs(VOld-VNew)<0.0001)))==432 %if V has converged
        check=false; %stop looping
        PiStar=Policy;
        VStar=VNew;
    end
    %CheckConverge=sum(sum(sum(abs(VOld-VNew)<0.0001))) %lets user see convergence
    VOld=VNew;
end

end

