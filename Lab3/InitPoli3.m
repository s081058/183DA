function [a] = InitPoli3(s)
%Given a current state, s, provide the action, a, that most directly goes
%towards the goal at state [3,4,h] for 0<=h<12
%   Splits the plane in half as seen by the robot.  If the goal is on the robot don't move; if in front
%   of or directly to the side of the robot, move forward; otherwise move
%   backwards.  If the robot moves forward or backward, update predicted
%   position with Pe=0, and calculate the error between the current and
%   desired heaading.  Turn left/right so that forward or backward heading
%   is most closely points towards the goal.  If there is a tie between
%   making the forward or backward heading closer to the goal, favor the
%   forward heading.
h=0; %completely arbitrary, randomly picked 0, but could be anything.  Simply used to keep the form of goal and s the same.
goal=[4,4,h];
xerror=goal(1)-s(1);
yerror=goal(2)-s(2);
angled=atan2d(yerror,xerror); %desired heading in degrees
hangle=90-s(3)*30; %convert current heading into angle in degrees
herror=mod(angled-hangle,360); %find error between current heading and desired heading and make between 0 and 360 degrees

%Take the appropriate action for the given policy based on the heading error
%If the heading error is 15 degrees from heading 0 or 6, don't change
%heading (chosen arbitrarily to reduce turning)
if (abs(xerror)+abs(yerror))==0;
    a="N"; %Output next action is to stay still.
elseif herror<=90 || herror>=270 %Move forward
    s=NextS(0,s,"F");
    xerror=goal(1)-s(1);
    yerror=goal(2)-s(2);
    angled=atan2d(yerror,xerror); %desired heading in degrees
    hangle=90-s(3)*30; %convert current heading into angle in degrees
    herror=mod(angled-hangle,360); %find error between current heading and desired heading
    if (((herror<=15) || (herror>=345))||((herror>=165)&&(herror<=195)))
        a="F"; %Output next action should be to move forward
    elseif (((herror>15) && (herror<=90))||((herror>195)&&(herror<270)))
        a="FL"; %Output next action should be to move forward left
    elseif (((herror>=270) && (herror<345))||((herror>90)&&(herror<165)))
        a="FR"; %Output next action should be to move forward right
    end
else %Move Backward
    s=NextS(0,s,"B");
    xerror=goal(1)-s(1);
    yerror=goal(2)-s(2);
    angled=atan2d(yerror,xerror); %desired heading in degrees
    hangle=90-s(3)*30; %convert current heading into angle in degrees
    herror=mod(angled-hangle,360); %find error between current heading and desired heading
    if (((herror<=15) || (herror>=345))||((herror>=165)&&(herror<=195)))
        a="B"; %Output next action should be to move backward
    elseif (((herror>15) && (herror<=90))||((herror>195)&&(herror<270)))
        a="BL"; %Output next action should be to move backward left
    elseif (((herror>=270) && (herror<345))||((herror>90)&&(herror<165)))
        a="BR"; %Output next action should be to move backward right
    end
end

end

