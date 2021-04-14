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

function znext = stepRungeKutta(t,z,dt)
% stepRungeKutta    Compute one step using the Runge-Kutta method
% 
%     ZNEXT = stepRungeKutta(t,z,dt) computes the state vector ZNEXT at the next
%     time step T+DT

% Calculate the state derivative from the current state
dz = stateDeriv(t,z);

% Calculate the next state vector from the previous
A = dt*stateDeriv(t,z);
B = dt*stateDeriv((t+(dt/2)),(z+(A/2)));
C = dt*stateDeriv((t+(dt/2)),(z+(B/2)));
D = dt*stateDeriv((t+dt),(z+C));

znext = z + ((1/6)*(A+(2*B)+(2*C)+D));
