function sma = solveForSMA(a)
consts;
e = 1 - (Re + hp) / a;
p = a * (1 - e * e);
n = sqrt(MU / a^3);
zeta = 3 * Re * Re * J2 / (4 * p * p);
tau = Nd / Np;
Az = zeta * (4 + 2 * sqrt(1 - e * e) - (5 + 3 * sqrt(1 - e * e) * sin(i)^2));
sma = ((we * (1 - Az)) / (tau - 2 * zeta * cos(i)) - n)^2;
end