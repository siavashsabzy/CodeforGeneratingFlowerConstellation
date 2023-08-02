function ENU= ss_xyz_enu(A,Phi,Lambda) 
  XYZ2ENU=[-sin(Lambda) cos(Lambda) 0;
           -sin(Phi)*cos(Lambda) -sin(Phi)*sin(Lambda) cos(Phi);
           cos(Phi)*cos(Lambda) cos(Phi)*sin(Lambda)  sin(Phi)];
  ENU=XYZ2ENU*A';       

  