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

function [v_final_km,min_fuel_kg,deviation,min_fuel_percent] = burn(v_i,H,h)
% burn Calculate burn fuel mass needed
% 
%     Uses the vis-viva equation and rocket equation to calculate the 
%     mass needed for a apogee burn (circulization burn).

% constants
    % Orbital
    G = 6.67408E-20;  % Gravitaional constant in km^3 kg^-1 s^-2
    M = 4.8675E24; % Mass of planet in kg
    R = 6051.8; % Radius of planet in km
    
    % Fuel / Rocket equation
    SpImp = 320; % Specific Impulse in seconds
    m_i = evalin('base', 'm'); % Spacecraft initial mass in kg
    g = 9.81E-3; % Standard gravity in km s^-1

% Calculate delta v (theoretical):
delta_v_theoretical=sqrt(G*M)*(sqrt(1/(H+R))-sqrt(2/(H+R)-1/(((H+h)/2)+R)));

% Calculate actual delta_v using actual speed v_i from simulation
delta_v_actual=sqrt((G*M)/(H+R)) - v_i;

    % calculates deviation in speed from theoretical to actual
    deviation=delta_v_theoretical-delta_v_actual;
    
    % Remembers final orbit velocity
    v_final_km = sqrt((G*M)/(H+R));

% Calculate min mass of propelant required
min_fuel_kg=m_i - m_i/(exp(delta_v_actual/(g*SpImp)));

min_fuel_percent=min_fuel_kg/m_i * 100;

assignin('base','minfuel',min_fuel_kg)
assignin('base','minfuelp',min_fuel_percent)
end