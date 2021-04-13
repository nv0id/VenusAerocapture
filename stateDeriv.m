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

function dz = stateDeriv(t,z)
% Calculate the state derivative for a spaceship
% 
%     DZ = stateDeriv(T,Z) computes the derivative DZ = [V; A] of the 
%     state vector Z = [X; V], where X is displacement, V is velocity,
%     and A is acceleration.

M = 4.8675*10^24; % Venus Mass 
G = 6.67*10^-11; %Gravitational Constant 
m = evalin('base','m'); %Spacecraft Mass called from intialvariables.m
R = 6051.8*10^3; %Radius of Venus 
A = evalin('base','A'); % Area of Spacecraft called from intialvariables.m
drag = evalin('base','drag');% Coefficient of Drag called from intialvariables.m
%x = z(1);
%y = z(3);
rp= sqrt((z(1).^2)+(z(3).^2))-(R); %height of the spacecraft
rho = profileVenus(rp); 


% State Derivatives
dz1 = z(2);
dz2 = (-G*M*z(1))/(((z(1)^2)+(z(3)^2))^(3/2))-((drag*sqrt((z(2)^2)+(z(4)^2))*z(2)*A*rho)/(2*m));
dz3 = z(4);
dz4 = (-G*M*z(3))/(((z(1)^2)+(z(3)^2))^(3/2))-((drag*sqrt((z(2)^2)+(z(4)^2))*z(4)*A*rho)/(2*m));


dz = [dz1; dz2; dz3; dz4];


