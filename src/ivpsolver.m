%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <https://www.gnu.org/licenses/>.

function [t,z] = ivpsolver(t0,z0,dt,tend)
% ivpSolver    Solve an initial value problem (IVP) and plot the result
% 
%     [T,Z] = ivpSolver(T0,Z0,DT,TE) computes the IVP solution using a step 
%     size DT, beginning at time T0 and initial state Z0 and ending at time 
%     TEND. The solution is output as a time vector T and a matrix of state 
%     vectors Z.

% Set initial conditions
t(1) = t0;
z(:,1) = z0;

% Continue stepping until the end time is exceeded
n=1;
while t(n) <= tend
    % Increment the time vector by one time step
    t(n+1) = t(n) + dt;
    
    % Apply Runge-Kutta method for one time step
    z(:,n+1) = stepRungeKutta(t(n), z(:,n), dt);
    
    n = n+1;
end
% Compute acceleration from velocity (not needed for solving the
% problem, but nice to have for completeness)
ddz = diff(z(2,:)) / dt;

rp=6051.8*10^3 ; % Plot of the planet Venus
th=0:0.01:2*pi;
xp = rp*cos(th);
yp =rp*sin(th);

rp1=6051.8*10^3 +1200000; %1200km orbit trail 
th=0:0.01:2*pi;
xp1 = rp1*cos(th);
yp1 =rp1*sin(th);

figure(1)
plot(xp,yp,'r'); 
hold on
plot(xp1,yp1, '--')
plot(z(1,:),z(3,:),'b');
hold off
axis('equal')
ylabel('Y Displacement (m)')
xlabel('X Displacement (m)')
legend('Venus','Orbit','Route of Spaceship')

