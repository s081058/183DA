function Z = stateEs2(X,Ut,dtime)
Z = X+dtime*[1/2*cos([0,0,1]*X/180*pi),1/2*cos([0,0,1]*X/180*pi);
             1/2*sin([0,0,1]*X/180*pi),1/2*sin([0,0,1]*X/180*pi);
                             -1/70,1/70]*Ut;
end
