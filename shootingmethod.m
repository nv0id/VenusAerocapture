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

function [alpha, Apoapsis]= shootingmethod(alpha1,alpha2);

H=evalin('base', 'H'); % calling in the defined apoapsis to complete the BVP
%Guess 1
R=6051.8*10^3; %radius of planet    
[t,z] = ivpsolver(0,[10000000,-11000,alpha1+R,0],1,8500);
x = z(1,:);
y = z(3,:);
altitude = -(R)+(sqrt((x).^2+(y).^2));
MaxHeight1 = max(altitude(y<0));
MinHeight1 = min(altitude(x<0));
Error1= MaxHeight1-H ;

TF1=isempty(MaxHeight1); % isempty checks whether a variable is an empty array 
                          %and if so will show an error message, otherwise the
                          % function will continue
 if TF1==1;
 d = dialog('Position',[300 300 250 150],'Name','Error');
    txt = uicontrol('Parent',d,...
           'Style','text',...
           'Position',[20 80 210 40],...
           'String','Your value for Alpha1 is out of range, please choose a different height.');
       
btn = uicontrol('Parent',d,...
           'Position',[89 20 70 25],...
           'String','Okay',...
           'Callback','delete(gcf)');

 else
     
     
     %Guess 2 
R=6051*10^3;
[t,z] = ivpsolver(0,[10000000,-11000,alpha2+R,0],1,8500);
x = z(1,:);
y = z(3,:);
altitude = -(R)+(sqrt((x).^2+(y).^2));
MaxHeight2 = max(altitude(y<0));
MinHeight2 = min(altitude(x<0));
Error2 = MaxHeight2-H;

TF2=isempty(MaxHeight2); 

if TF2==1;
 d = dialog('Position',[300 300 250 150],'Name','Error');
    txt = uicontrol('Parent',d,...
           'Style','text',...
           'Position',[20 80 210 40],...
           'String','Your value for Alpha2 is out of range, please choose a different height.');
       
btn = uicontrol('Parent',d,...
           'Position',[89 20 70 25],...
           'String','Okay',...
           'Callback','delete(gcf)');

 else
%3rd Guess
Error_a = Error1;
Error_b = Error2;
alpha_a = alpha1;
alpha_b = alpha2;
  while abs(Error_b) > 1
      alpha_c = alpha_b-Error_b*((alpha_b-alpha_a)/(Error_b-Error_a));
      alpha_a = alpha_b;
      alpha_b = alpha_c;
      [t,z] = ivpsolver(0,[10000000,-11000,alpha_b+R,0],1,8500);
      x = z(1,:);
      y = z(3,:);
      altitude = -R+(sqrt((x).^2+(y).^2));
      MinHeight = min(altitude(x<0));
      MaxHeight = max(altitude(y<0));
      Error_c =  MaxHeight-H;
      Error_a =  Error_b;
      Error_b =  Error_c;
      dx=z(2,:);
      dy=z(4,:);
      velocity= sqrt(dx.^2+dy.^2);
      MinVel=min(velocity(y<0));
      
    
  end
  Apoapsis= MaxHeight;
  TF3=isempty(Apoapsis);

if TF3==1;
 d = dialog('Position',[300 300 250 150],'Name','Error');
    txt = uicontrol('Parent',d,...
           'Style','text',...
           'Position',[20 80 210 40],...
           'String','At least one of your inital guesses is out of range, please choose a different height ');
       
 btn = uicontrol('Parent',d,...
           'Position',[89 20 70 25],...
           'String','Okay',...
           'Callback','delete(gcf)');


else
  burn(MinVel./1000,MaxHeight./1000,MinHeight./1000)  ; % runs burn function
  % The variables are assigned to the base workspace, so they can be picked
  % up by the intialvariables.m workspace
  assignin('base','periapsis',MinHeight) 
  assignin('base','alpha',alpha_b)
  assignin('base','speed',MinVel)
  assignin('base','apoapsis',MaxHeight)
  %The push button updates values so the relevant time this is needed to be
  %done is specified with the instructions below.
  d = dialog('Position',[300 300 250 150],'Name','Instruction');
    txt = uicontrol('Parent',d,...
           'Style','text',...
           'Position',[20 80 210 40],...
           'String','Please press Update on the main controller to see results');
       
 btn = uicontrol('Parent',d,...
           'Position',[89 20 70 25],...
           'String','Okay',...
           'Callback','delete(gcf)');
  
end
  

 end
end

    











