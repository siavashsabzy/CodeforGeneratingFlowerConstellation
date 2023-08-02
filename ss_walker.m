function sats = ss_walker(num_plane, num_sat_per_plane, F, refsat)
sats   = zeros(num_plane*num_sat_per_plane,12);
a      = refsat(1,7);
ecc    = refsat(1,8);
inc    = refsat(1,9);
raan_0 = refsat(1,10);
aop    = refsat(1,11);
nu_0   = refsat(1,12);
nb = 0;
for i = 1:num_plane
    for j = 1:num_sat_per_plane
        raan = raan_0 + i * 360 / num_plane;
        if raan == 360
            raan = 0;
        end
        nu = nu_0 + j * 360 / num_sat_per_plane + i * 360 * F / (num_sat_per_plane * num_plane);
        if nu >= 180
            nu = nu - 360;
        end
        nb = nb+1;
        sats(nb,:) = [refsat(1,1:6),a, ecc, inc, raan, aop, nu];
    end
end
end