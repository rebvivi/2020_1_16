function [NextObs,Reward,IsDone] = myStepFunction(Action,State)
% Custom step function to construct cart pole environment for the function
% name case.
%
% This function applies the given action to the environment and evaluates
% the system dynamics for one simulation step.

% Define the environment constants.

% Acceleration due to gravity in m/s^2
Gravity = 9.8;
% Mass of the cart
CartMass = 1.3282;
% Mass of the pole
PoleMass = 0.22;
% Half the length of the pole
HalfPoleLength = 0.152;

% Sample time
Ts = 0.01;
% Pole angle at which to fail the episode
AngleThreshold = 22.5 * pi/180;
% Cart distance at which to fail the episode
DisplacementThreshold = 1.5;

if Action==1
    Force=-10;
elseif Action==2
    Force = -5;
elseif Action==3
    Force = 0; 
elseif Action==4
    Force = 5;
elseif Action==5
    Force = 10;
end

% Unpack the state vector from the State
X=State(1);
XDot = State(2);
Theta = State(3);
ThetaDot = State(4);

% Cache to avoid recomputation
CosTheta = cos(Theta);
SinTheta = sin(Theta);
SystemMass = CartMass + PoleMass;
temp = (Force + PoleMass*HalfPoleLength*ThetaDot*ThetaDot*SinTheta)/SystemMass;

% Apply motion equations
ThetaDotDot = (Gravity*SinTheta - CosTheta*temp) / ...
    (HalfPoleLength*(4.0/3.0 - PoleMass*CosTheta*CosTheta/SystemMass));
XDotDot  = temp - PoleMass*HalfPoleLength*ThetaDotDot*CosTheta/SystemMass;

% Euler integration
X=X+Ts*XDot;
XDot=XDot+Ts*XDotDot;
Theta=Theta+Ts*ThetaDot;
ThetaDot=ThetaDot+Ts*ThetaDotDot;

% Transform state to observation
NextObs(1) = X;
NextObs(2) = XDot;
NextObs(3) = Theta;
NextObs(4) = ThetaDot;
% Check terminal condition
X = NextObs(1);
Theta = NextObs(3);
IsDone = abs(X) > DisplacementThreshold || abs(Theta) > AngleThreshold;

%% Get reward

if ~IsDone
    Reward =1;
else
    Reward = 1;
end
%%
end