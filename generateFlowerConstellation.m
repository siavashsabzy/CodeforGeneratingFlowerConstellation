function [satelliteOrbits] = generateFlowerConstellation(Np, Nd, Ns, omega, inclination, perigeeAltitude)
    % Inputs:
    % Np: Number of petals
    % Nd: Number of sidereal days to repeat the ground track
    % Ns: Number of satellites
    % omega: Argument of perigee in degrees
    % inclination: Orbit inclination in degrees
    % perigeeAltitude: Perigee altitude in kilometers

    % Convert angles from degrees to radians
    omega_rad = deg2rad(omega);
    inclination_rad = deg2rad(inclination);

    % Earth constants
    Re = 6378.137; % Earth's equatorial radius in kilometers
    mu = 398600.4418; % Earth's gravitational parameter in km^3/s^2

    % Calculate the semimajor axis of the satellites' orbits
    semimajorAxis = (Re + perigeeAltitude); % in kilometers

    % Calculate the orbital period in seconds
    T = Nd * 86164.09054; % Number of sidereal days (Nd) converted to seconds

    % Calculate the mean motion (n) in radians per second
    n = 2 * pi / T;

    % Calculate the mean anomaly (M) at time t=0
    M_0 = 0;

    % Calculate the angular separation between satellites (beta) in radians
    beta = 2 * pi / Ns;

    % Initialize the satelliteOrbits cell array to store the orbital parameters of each satellite
    satelliteOrbits = cell(Ns, 1);

    % Generate the orbital parameters for each satellite
    for i = 1:Ns
        % Calculate the time of passage through perigee for each satellite
        t_p = (i - 1) * (T / Ns);

        % Calculate the eccentric anomaly (E) using Kepler's equation
        E = keplerEquation(M_0, n, t_p);

        % Calculate the true anomaly (theta) in radians
        theta = 2 * atan(sqrt((1 + semimajorAxis) / (1 - semimajorAxis)) * tan(E / 2));

        % Calculate the argument of latitude (u) in radians
        u = theta + omega_rad;

        % Calculate the ascending node for each satellite
        ascendingNode = (i - 1) * beta;

        % Store the orbital parameters for the current satellite
        satelliteOrbits{i} = struct('semimajorAxis', semimajorAxis, 'eccentricity', 1 - Re / (Re + perigeeAltitude),...
            'inclination', inclination_rad, 'ascendingNode', ascendingNode, 'argumentOfPerigee', omega_rad, 'meanAnomaly', M_0, ...
            'apogeeAltitude', semimajorAxis * 2 - perigeeAltitude);
    end
end

function E = keplerEquation(M, n, t)
    % Solve Kepler's equation using Newton-Raphson method
    maxIterations = 100;
    tolerance = 1e-10;
    
    E = M;
    for i = 1:maxIterations
        E_new = E - (E - n * t - M) / (1 - n * sin(E));
        if abs(E_new - E) < tolerance
            E = E_new;
            break;
        end
        E = E_new;
    end
end



% Np = 3; % Number of petals
% Nd = 2; % Number of sidereal days to repeat the ground track
% Ns = 6; % Number of satellites
% omega = 30; % Argument of perigee in degrees
% inclination = 45; % Orbit inclination in degrees
% perigeeAltitude = 500; % Perigee altitude in kilometers
% 
% satelliteOrbits = generateFlowerConstellation(Np, Nd, Ns, omega, inclination, perigeeAltitude);
