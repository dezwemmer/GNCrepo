% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
% GNC Software Collection
% Author:   Steven Anderson
% Created:  JUL 2022
% Credit:   Tactical & Strategic Missile Guidance: An
%           Introduction, 7th Ed., Paul Zarchan
% Brief:    Listing 1.1
%           Simulation of 2nd order differential equation using
%           Euler numerical integration
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

% Euler Integration
while t <= 10
  s = s + h;
  Xdd = -w*w*X;     % linear 2nd order diffeq
  Xd = Xd + h*Xdd;
  X = X + h*Xd;
  t = t + h;
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
title 'Euler Integration'
xlabel 'Time (sec)'
ylabel 'X & Xtheory'
axis([0 10 -2 2])


