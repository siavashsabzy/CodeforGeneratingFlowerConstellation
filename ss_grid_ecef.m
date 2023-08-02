function Rpoints = ss_grid_ecef(n_g)
addpath([pwd '\GridSphere'])
[lats, longs] = GridSphere(n_g);
rmpath([pwd '\GridSphere'])
n = size(lats,1);
f = 0;
for i = 1:n
        Rpoints(i,:)  = ss_user_geodetic_ecef([lats(i) longs(i) 0]);
end
end