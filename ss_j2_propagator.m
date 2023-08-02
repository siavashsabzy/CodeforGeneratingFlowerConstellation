function ephvec_out = ss_j2_propagator(t_epoch,t_end,ephvec_in,n_steps)
ephvec_out = zeros(n_steps + 1 , 12 );
% generating time tags
jd_time_vector = linspace( ss_time_utc_to_jday( t_epoch ), ss_time_utc_to_jday( t_end ), n_steps + 1 );
jd_t_span = jd_time_vector(end) - jd_time_vector(1);
[ t, y ] = ss_rk4( @ss_gravity_j2 , [0 jd_t_span*86400], ephvec_in , n_steps );
for i = 1 : n_steps + 1
    ephvec_out(i,1:6) = ss_time_jday_to_utc(jd_time_vector(i));
    ephvec_out(i,7:12) = y(i,1:6);
end
%
end