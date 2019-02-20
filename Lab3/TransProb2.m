function [P_saSPrime] = TransProb2(pe,s,a,sprime)
%Provides the transition probability of state S' given an error
%probability, previous state, previous action, and S' 
%   Returns the probability of a state given 12 possible actions
%   representing.  Functions by generating all possible outcomes (x#,y#,h#, and there
%   given probability p# for any combination of inputs.  

%a=convertStringsToChars(a);
a=lower(a); %allows ignoring of upper vs lower case 
x=s(1); y=s(2); h=s(3); %dummy variables for x, y, and h states before move
xnew=[x,x,x]; ynew=[y,y,y]; hnew=[h,h,h]; p=[0,0,0]; %initialize variables for possible outcomes
P_saSPrime=0; %Unless one of the following conditions is true, the transition probability is zero
% a1=a(1); %break up the actions into forward, neutral, back, and left, neutral, right
% if length(a)==2;
%     a2=a(2);
% else
%     a2='n';
% end


%%account for the option not to move
if a=="n"
    hnew=[mod(h,12),0,0]; p=[1,0,0]; %don't move with certainty.  Only outcome
end

%%account for left/right/no turn after moving
if ((a=="fl") || (a=="bl")) %try to turn left after moving
    hnew=[mod(h-1,12),mod(h,12),mod(h-2,12)]; %No prerotation error, right error, left error
    p=[1-2*pe,pe,pe]; %Corresponding frequencies
elseif ((a=="fr")||(a=="br")) %try to turn right after moving
    hnew=[mod(h+1,12),mod(h+2,12),mod(h,12)]; %No prerotation error, right error, left error
    p=[1-2*pe,pe,pe]; %Corresponding frequencies
elseif ((a=="f") || (a=="b")) %move but don't turn
    hnew=[mod(h,12),mod(h+1,12),mod(h-1,12)]; %No prerotation error, right error, left error
    p=[1-2*pe,pe,pe]; %Corresponding frequencies
end

%%Determine position based on forward/backward and heading
if ((a=="f")||(a=="fl")||(a=="fr")) %try to move forward;
    switch h
        case 0
            xnew=[x,x,x];
            ynew=[y+1,y+1,y+1];
        case 1
            xnew=[x,x+1,x];
            ynew=[y+1,y,y+1];
        case 2
            xnew=[x+1,x+1,x];
            ynew=[y,y,y+1];
        case 3        
            xnew=[x+1,x+1,x+1];
            ynew=[y,y,y];
        case 4
            xnew=[x+1,x,x+1];
            ynew=[y,y-1,y];
        case 5
            xnew=[x,x,x+1];
            ynew=[y-1,y-1,y];
        case 6
            xnew=[x,x,x];
            ynew=[y-1,y-1,y-1];
        case 7
            xnew=[x,x-1,x];
            ynew=[y-1,y,y-1];
        case 8
            xnew=[x-1,x-1,x];
            ynew=[y,y,y-1];
        case 9
            xnew=[x-1,x-1,x-1];
            ynew=[y,y,y];
        case 10
            xnew=[x-1,x,x-1];
            ynew=[y,y+1,y];
        case 11
            xnew=[x,x,x-1];
            ynew=[y+1,y+1,y];
    end
elseif ((a=="b")||(a=="bl")||(a=="br")) %move backward
    switch h
        case 0
            xnew=[x,x,x];
            ynew=[y-1,y-1,y-1];
        case 1
            xnew=[x,x-1,x];
            ynew=[y-1,y,y-1];
        case 2
            xnew=[x-1,x-1,x];
            ynew=[y,y,y-1];
        case 3        
            xnew=[x-1,x-1,x-1];
            ynew=[y,y,y];
        case 4
            xnew=[x-1,x,x-1];
            ynew=[y,y+1,y];
        case 5
            xnew=[x,x,x-1];
            ynew=[y+1,y+1,y];
        case 6
            xnew=[x,x,x];
            ynew=[y+1,y+1,y+1];
        case 7
            xnew=[x,x+1,x];
            ynew=[y+1,y,y+1];
        case 8
            xnew=[x+1,x+1,x];
            ynew=[y,y,y+1];
        case 9
            xnew=[x+1,x+1,x+1];
            ynew=[y,y,y];
        case 10
            xnew=[x+1,x,x+1];
            ynew=[y,y-1,y];
        case 11
            xnew=[x,x,x+1];
            ynew=[y-1,y-1,y];
    end
end

%%Prevent going out of bounds;
xnew=xnew+(xnew<0)-(xnew>5);
ynew=ynew+(ynew<0)-(ynew>5);


%%
%Sum the probability of outcomes giving sprime
if sprime(1)==xnew(1) && sprime(2)==ynew(1) && sprime(3)==hnew(1); 
    P_saSPrime=P_saSPrime+p(1);
end
if sprime(1)==xnew(2) && sprime(2)==ynew(2) && sprime(3)==hnew(2); 
    P_saSPrime=P_saSPrime+p(2);
end
if sprime(1)==xnew(3) && sprime(2)==ynew(3) && sprime(3)==hnew(3); 
    P_saSPrime=P_saSPrime+p(3);
end
end