function trueAn =  mean_anomaly_to_true(M, e)
    E = fminsearch(@(E)(E - e * sin(E) - M)^2, 0);
    beta = e / (1 + sqrt(1 - e * e));
    trueAn =  E + 2 * atan(beta * sin(E) / (1 - beta * cos(E)));
    
end