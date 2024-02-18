% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
% GNC Software Collection
% Author:   Steven Anderson
% Created:  JUL 2022
% Ref:      Tactical & Strategic Missile Guidance: An
%           Introduction, 7th Ed., Paul Zarchan
% Brief:    Small example demonstrating proNav law
% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

clear all; clc;

%gamD = N*lamD

vM = 3000;
vT = 1000;
gam0 = -102;  %degrees
lam = [90,77,60,43,28,18,13];
N = 1;
lamCurr = lam(1);
gamCurr = gam0;
lamNext = 77;
gam = [];


for i = 1:6
  gamNext = N*(lam(i+1) - lam(i)) + gamCurr;
  gam(i) = gamNext;
  lamCurr = lamNext;
  gamCurr = gamNext;
  %velM = [vM*sind(gam0) vM*cosd(gam0)];
endfor
gam

%figure
%plot([0,velM(1)], [0, velM(2)]);
%grid on
%quiver(0,0,Velm(1),Velm(2))
