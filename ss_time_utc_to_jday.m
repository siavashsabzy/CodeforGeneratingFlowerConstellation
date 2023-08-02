function jd = ss_time_utc_to_jday(time_vector)
jd = 367.0 * time_vector(1)  ...
    - floor( (7 * (time_vector(1) + floor( (time_vector(2) + 9) / 12.0) ) ) * 0.25 )   ...
    + floor( 275 * time_vector(2) / 9.0 ) ...
    + time_vector(3) + 1721013.5;
jdfrac = (time_vector(6) + time_vector(5) * 60.0 + time_vector(4) *3600.0) / 86400.0;
% check jdfrac
if jdfrac > 1.0
    jd = jd + floor(jdfrac);
    jdfrac = jdfrac - floor(jdfrac);
end
jd = jd + jdfrac;