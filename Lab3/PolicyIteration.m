function [PiOptimal] = PolicyIteration(PiNot,Lambda,Pe)
%Policy iteration algorithm Outputs the optimal policy PiOptimal given an
%initial policy PiNot, Lambda, and error probability Pe
%   Repeatedly does policy evaluation and generates an improved policy
%   based upon the policy evaluation.  Loop continues until the policy does
%   not change in an iteration
Pi=PiNot;
Loop=true;
while Loop==true;
    CurrentEval=PolicyEval(Pi,Lambda,Pe);
    PiNew=NextPi2(CurrentEval,Pe);
    if sum(sum(sum(PiNew==Pi)))==432;
        Loop=false;
    end
    %sum(sum(sum(PiNew==Pi))) %lets user check how fast conversion is occuring
    Pi=PiNew;
end
PiOptimal=Pi;
end

