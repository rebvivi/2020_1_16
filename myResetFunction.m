function [State] = myResetFunction()
% Reset function to place custom cart-pole environment into a random
% initial state.

% Theta (randomize)
T0 =randi([-5 ,5],1)/100;
% Thetadot
Td0 = randi([-5 ,5],1)/100;
% X
X0 = randi([-5 ,5],1)/100;
% Xdot
Xd0 = randi([-5 ,5],1)/100;

% Return initial environment state variables as logged signals.

State(1)=T0;
State(2)=Td0;
State(3)=X0;
State(4)=Xd0;
%InitialObservation = LoggedSignal.State;

end