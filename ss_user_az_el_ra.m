function [E,A,D]=ss_user_az_el_ra(Pos_Rcv,Pos_SV)
R=Pos_SV-Pos_Rcv;
GPS = ss_ecef_gps(Pos_Rcv);Lat=GPS(1);Lon=GPS(2);
ENU=ss_xyz_enu(R,Lat,Lon);
Elevation=asin(ENU(3)/norm(ENU));
Azimuth=atan2(ENU(1)/norm(ENU),ENU(2)/norm(ENU));
E=Elevation * 180 / pi;
A=Azimuth * 180 / pi;
D = norm(R);