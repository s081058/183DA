% % Peter Ferguson, 10/11/2018, EE209AS, Problem Set 2
% % Completed alone
% clear
% close all
% clc
% % 
% % 1(a).
% disp('1(a)')
% disp('States are a 3d matrix where [x,y] cell corresponds to positions in grid world, [z] refers to direction on the clock the robot is facing')
% disp('Eg [1,0,4] corresponds to state with x=1, y=0, and h=4 (facing 4 oclock)')
% disp('The number of states, N_s=36*12=432')
% 
% %1(b)
% disp('1(b)')
% disp('Possible actions are ["FL","F","FR","N","BL","B","BR"] where F=Forward, B=Back, L=Left, R=Right, N=no movement.')
% disp('The number of possible actions, N_A=7')
% 
% 
% %1(c)
% disp('1(c)')
% disp('See TransProb2')
% 
% %1(d)
% disp('1(d)')
% disp('See NextS')
% 
% %2(a)
% disp('2(a)')
% disp('See Reward')
% 
% 
% %3(a)
% disp('3(a)')
% disp('See InitPoli3 and PiNot')
% 
% %3(b)
% disp('3(b)')
% disp('See GenTraj')
% 
% %3(c)
% disp('3(c)')
% PiNotTrajectory=GenTraj(PiNot,[1,4,6],0);
% disp('The trajectory of the robot prescribed by Pi_0 with Pe=0 is:')
% disp(PiNotTrajectory)
% title('problem2.3c');
% 
% 
% %3(d)
% disp('3(d)')
% disp('See PolicyEval')
% 
% % 3(e)
% disp('3(e)')
% PiNotValues=PolicyEval(PiNot(),0.9,0);
% disp(['The value of the robot prescribed by Pi_0 at position [1,4,6] is ',num2str(PiNotValues(2,5,7)),'.']) 
% 
% %3(f)
% disp('3(f)')
% disp('See NextPi2')
% 
% %3(g)
% disp('3(g)')
% disp('See PolicyIteration')
% 
%3(h) 
% disp('3(h)')
% tic
% PiStar=PolicyIteration(PiNot(),0.9,0.1);
% OptimalTrajectory=GenTraj(PiStar,[1,4,6],0.1);
% disp('The trajectory of the robot prescribed by Pi* with Pe=0 is:')
% disp(OptimalTrajectory)
% Values=PolicyEval(PiStar,0.9,0.1);
% title('problem2.3h');
% disp(['The value of the robot prescribed by Pi* with Pe=0 at position [1,4,6] is ',num2str(Values(2,5,7)),'.'])
% %3(i)
% disp('3(i)')
toc
% 
% %4(a)
% disp('4(a)')
% disp('See ValueIteration')

%4(b)
% disp('4(b)')
% tic
% [VIPiStar,VIVStar]=ValueIteration(0.9,0);
% VITrajectory=GenTraj(VIPiStar,[1,4,6],0);
% disp('It obtains the same Policy and Values for Value Iteration and Policy Iteration')
% % differencePi=432-sum(sum(sum(PiStar==VIPiStar)))
% % differenceValue=sum(sum(sum(Values-VIVStar)))
% title('problem2.4b');
% % 4(c)
% disp('4(c)')
% toc

% 5(a)
disp('5(a)')
tic
PiStar2=PolicyIteration(PiNot(),0.9,0.1);
OptimalTrajectory2=GenTraj(PiStar2,[1,4,6],0.1);
disp('The trajectory of the robot prescribed by Pi* with Pe=0.25 is:')
disp(OptimalTrajectory2)
Values2=PolicyEval(PiStar2,0.9,0.1);
disp(['The value of the robot prescribed by Pi* with Pe=0.25 at position [1,4,6] is ',num2str(Values2(2,5,7)),'.'])
toc
% disp('5(a)')
% PiNotTrajectory=GenTraj(PiNot,[1,4,6],0.1);
% disp('The trajectory of the robot prescribed by Pi_0 with Pe=0 is:')
% disp(PiNotTrajectory)
% title('problem2.5a');

%5(b)
% disp('5(b)')
% tic
% PiStar3=PolicyIteration2(PiNot(),0.9,0.1);
% OptimalTrajectory3=GenTraj(PiStar3,[1,4,6],0.1);
% disp('The trajectory of the robot prescribed by Pi* with Pe=0.1 is:')
% disp(OptimalTrajectory3)
% Values3=PolicyEval(PiStar3,0.9,0.1);
% disp(['The value of the robot prescribed by Pi* with Pe=0.25 with goal pointing downward for starting position [1,4,6] is ',num2str(Values3(2,5,7)),'.'])
% toc
% disp('5(b)')
% PiNotTrajectory=GenTraj(PiNot,[1,4,6],0.25);
% disp('The trajectory of the robot prescribed by Pi_0 with Pe=0 is:')
% disp(PiNotTrajectory)


%5(c)
disp('5(c)')
disp('When possibility for error is introduced, there is a chance that the robot must take a significantly longer path, or retrace its steps when an error occurs.')
disp('If the goal is made to only be facing downward, the robot must take a much longer path, and with the probability of error introduced, the path can become extremely long.')
disp('Furthermore, when the goal is facing downward, the robot tends to try to back into the goal as opposed to move forward into it')