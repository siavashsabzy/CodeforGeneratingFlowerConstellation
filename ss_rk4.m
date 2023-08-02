function [ t, y ] = ss_rk4( dydt, tspan, y0, n )
  y0 = transpose ( y0(:) );
  m = size ( y0, 2 );
  t = zeros ( n + 1, 1 );
  y = zeros ( n + 1, m );
  tfirst = tspan(1);
  tlast = tspan(2);
  dt = ( tlast - tfirst ) / n;
  t(1,1) = tspan(1);
  y(1,:) = y0(1,:);
  for i = 1 : n
    f1 = dydt ( t(i,1),            y(i,:) );
    f2 = dydt ( t(i,1) + dt / 2.0, y(i,:) + dt * transpose ( f1 ) / 2.0 );
    f3 = dydt ( t(i,1) + dt / 2.0, y(i,:) + dt * transpose ( f2 ) / 2.0 );
    f4 = dydt ( t(i,1) + dt,       y(i,:) + dt * transpose ( f3 ) );

    t(i+1,1) = t(i,1) + dt;
    y(i+1,:) = y(i,:) + dt * ( ...
              transpose ( f1 ) ...
      + 2.0 * transpose ( f2 ) ...
      + 2.0 * transpose ( f3 ) ...
      +       transpose ( f4 ) ) / 6.0;

  end
  return
end