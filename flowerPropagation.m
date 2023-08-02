clear
clc
%%
consts;
incl = i;
aop = w;
raan_offset = 0;
mean_anomaly_offset = 0;
delete_existing = false;


sma = fminsearch(@solveForSMA, Re + hp);
e = 1 - (Re + hp) / sma;
apogee = sma * 2 - (Re + hp) - Re;


mean_anomalies = zeros(Ns,1);
true_anomalies = zeros(Ns,1);
right_ascensions = zeros(Ns,1);


mean_anomalies(1) = mean_anomaly_offset;
true_anomalies(1) = mean_anomaly_to_true(0, e);
right_ascensions(1) = raan_offset;

p = sma * (1 - e * e);
zeta = 3 * Re * Re * J2 / (4 * p * p);
tau = Nd / Np;
Az = zeta * (4 + 2 * sqrt(1 - e * e) - (5 + 3 * sqrt(1 - e * e) * sin(i)^2));

for i = 1:Ns-1
    raan = right_ascensions(i) - 2 * pi * Nd / Fd;
    mean_anomaly = mean_anomalies(i) + 2 * pi * Np / Fd;

    right_ascensions(i + 1) = mod(raan, (2 * pi));
    mean_anomalies(i + 1) = mod(mean_anomaly, (2 * pi));
    true_anomalies(i + 1) = mod(mean_anomaly_to_true(mean_anomalies(i+1), e), (2 * pi));
end




t_epoch = [2018 10 3 08 30 00];
t_end = [2018 10 3 12 30 00];
n_steps = 86400;
ephvec_out= zeros(n_steps + 1, 12);
epheciVec = zeros(Ns,12);
figure()
for i = 1:Ns
    epheciVec(i,:) = ss_coe_to_eci([t_epoch,sma,e, ...
        incl,right_ascensions(i),aop,...
        mean_anomalies(i)]);
    ephvec_out = ss_j2_propagator(t_epoch,t_end,epheciVec(i,7:12),n_steps);
    plot3(ephvec_out(1,7),ephvec_out(1,8),ephvec_out(1,9),'*r')
    plot3(ephvec_out(:,7),ephvec_out(:,8),ephvec_out(:,9),'.k')
    hold on
end
[X, Y, Z] = sphere(50);
surf(X*6378.137, Y*6378.137, Z*6378.137)
axis equal





