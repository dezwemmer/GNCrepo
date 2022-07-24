% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
% GNC Software Collection
% Author:   Steven Anderson
% Created:  JUL 2022
% Credit:   Tactical & Strategic Missile Guidance: An
%           Introduction, 7th Ed., Paul Zarchan
% Brief:    Listing 1.2
%           Simulation of 2nd order differential equation using
%           Runge-Kutta numerical integration
% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

clear all; close all;

% initialization
count = 0;
w = 2;      % natural frequency
t = 0;
s = 0;
X = 0;
Xd = w;
h = 0.01;   % integration time step

% Runge-Kutta (RK) Integration
while t <= 10
  s = s + h;
  Xold = X;
  Xoldd = Xd;
  Xdd = -w*w*X;     % linear 2nd order diffeq
  X = X + h*Xd;
  Xd = Xd + h*Xdd;
  t = t + h;
  Xdd = -w*w*X;
  X = 0.5*(Xoldd + X + h*Xd);
  Xd = 0.5*(Xoldd + Xd + h*Xdd);
  if s >= 0.09999
    s = 0;
    Xtheory = sin(w*t);
    count = count + 1;
    arrayT(count) = t;
    arrayX(count) = X;
    arrayXtheory(count) = Xtheory;
  endif
endwhile

%% Plotting
figure
plot(arrayT, arrayX, 'r')
plot(arrayT,arrayXtheory, 'b')
grid on
title '2nd Order RK Integration'
xlabel 'Time (sec)'
ylabel 'X & Xtheory'
axis([0 10 -2 2])
