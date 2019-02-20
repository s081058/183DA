function [value] = Reward(s)
%Outputs a reward given the prompt grid world and an input state s (x,y,h)
%   Edge reward=-100.  Lane marker reward=-10.  Goal reward pointing down=+1.  All other
%   rewards=0.
if s(1)==0 || s(1)==5 || s(2)==0 || s(2)==5;
    value=-100;
elseif s(1)==1 || s(2)==1;
    value=0;
elseif s(1)==2 || s(1)==4;
    value=-10;
elseif s(1)==4 && s(2)==4 && s(3)==6;
        value=1;
    end
else
    value=0;
end
end

