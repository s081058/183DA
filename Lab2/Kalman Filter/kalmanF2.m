function Xestpath = kalmanF2(X,u,time,Y,n)
    dtime = time;
%     Ts = 0.1; %define the sample time
    A = eye(3); %define the state matrix
    C = eye(3); %define the output matrix
    B = dtime*[1/2*cos([0,0,1]*X/180*pi),1/2*cos([0,0,1]*X/180*pi);
               1/2*sin([0,0,1]*X/180*pi),1/2*sin([0,0,1]*X/180*pi);
                                   -1/70,1/70]; %define the input matrix
%     x0=[0;0;90]; %define the initial conditions
%     sys = ss(A,B,eye(3),[],Ts); %define a system to generate true data
%     t = 0:Ts:40; %define the time interval

    varx = 0.2981297941; %standard deviation ax
    vary = 0.2590436048; %standard deviation ay
    measurmentsV = [0.002800983188, 0, 0;
                    0, 0.001261729798, 0;
                    0, 0, 0.03630618999];
    R = measurmentsV*C*C';
    Q = [varx,0;
          0,vary];
    P=B*Q*B';
    Xestpath(:,1) = X;
    for i=2:1:n
         Xestpath(:,i) = stateEs2(Xestpath(:,i-1),u,dtime);
         P=A*P*A'+B*Q*B'; %predicting P
%          Xestpath(:,i) = A*Xestpath(:,i-1)+B*u; %Predicitng the state
         K = P*C'/(C*P*C'+R); %calculating the Kalman gains
         Xestpath(:,i) = Xestpath(:,i)+K*(Y(:,i)-C*Xestpath(:,i)); %Correcting: estimating the state
         P = (eye(3)-K*C)*P; %Correcting: estimating P
    end
 plot(Xestpath(1,1:20),Xestpath(2,1:20),'LineWidth',15);
 title('Position of Car With Kalman Filter');
 xlabel('X position(mm)');
 ylabel('Y position(mm)');
 hold on;
 hold on;
end