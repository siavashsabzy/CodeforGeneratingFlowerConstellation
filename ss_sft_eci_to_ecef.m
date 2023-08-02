function ephvec_out = ss_sft_eci_to_ecef(ephvec_in,time_vector)
if size(ephvec_in , 2) ~= 6
    
else
    if size(time_vector , 2 ) ~= 6
        
    else
        
        if size(ephvec_in , 1) ~= size(time_vector , 1 )
            
        else
            ephvec_out = zeros(size(ephvec_in , 1),size(ephvec_in , 2));
            for i = 1:size(ephvec_in , 1)
                x_ecef = ss_dcm_eci_ecef(time_vector(i,1:6))*ephvec_in(i,1:3)';
                v_ecef = ss_dcm_eci_ecef(time_vector(i,1:6))*ephvec_in(i,4:6)';
                ephvec_out(i,1:6) = [x_ecef' v_ecef'];                
            end
        end
    end
end
end