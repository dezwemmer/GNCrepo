% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
% GNC Software Collection
% Author:   Steven Anderson
% Created:  JUL 2022
% Credit:   Tactical & Strategic Missile Guidance: An
%           Introduction, 7th Ed., Paul Zarchan
% Brief:    Listing 2.1
%           2D Proportional Navigation (missile-target)
% XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

clear all; clc;

%% initialization
fprintf '...Initializing varibles'
n = 0;
Vm = 3000.;  % missile velocity
Vt = 1000.;  % target velocity
Xnt = 0.;
headEdeg = -20.; % heading error(deg)
Xnp = 4.;
Rm1 = 0.;       % missile pos 1
Rm2 = 10000.;   % missile pos 2
Rt1 = 40000.;   % target pos 1
Rt2 = 10000.;   % target pos 2
beta = 0.;      % target flight path angle

Vt1 = -Vt * cos(beta);
Vt2 = Vt * sin(beta);
headE = headEdeg/57.3;
t = 0.;
s = 0.;

Rtm1 = Rt1 - Rm1;
Rtm2 = Rt2 - Rm2;
Rtm = sqrt(Rtm1^2 + Rtm2^2);

Xlam = atan2(Rtm2,Rtm1);    % LOS angle
Xlead = asin(Vt * sin(beta + Xlam)/Vm);  % lead angle
%thet = Xlam + Xlead;

% initial missile velocity components
Vm1 = Vm * cos(Xlead + headE + Xlam);
Vm2 = Vm * sin(Xlead + headE + Xlam);
Vtm1 = Vt1 - Vm1;
Vtm2 = Vt2 - Vm2;

% closing velocity
Vc = -(Rtm1*Vtm1 + Rtm2*Vtm2)/Rtm;

%% Main loop
fprintf '...Starting main loop'
while Vc >= 0
  fprintf 'Vclosing = %d',Vc
  if Rtm > 1000
    h = 0.0002;
  else
    h = 0.01;
  endif

  betaOld = beta;
  Rt1Old = Rt1;
  Rt2Old = Rt2;
  Rm1Old = Rm1;
  Rm2Old = Rm2;
  Vm1Old = Vm1;
  Vm2Old = Vm2;

  step = 1;
  flag = 0;
  while step >= 1
    if flag == 1
      step = 2;
      beta = beta + h*betad; % check this
      Rt1 = Rt1 + h*Vt1;
      Rt2 = Rt2 + h*Vt2;
      Rm1 = Rm1 + h*Vm1;
      Rm2 = Rm2 + h*Vm2;
      Vm1 = Vm1 + h*Am1;
      Vm2 = Vm2 + h*Am2;
      t = t + h;
      step = 0;
    endif
    Rtm1 = Rt1 - Rm1;
    Rtm2 = Rt2 - Rm2;
    Rtm = sqrt(Rtm1^2 + Rtm2^2);
    Vtm1 = Vt1 - Vm1;
    Vtm2 = Vt2 - Vm2;
    Vc = -(Rtm1*Vtm1 + Rtm2*Vtm2)/Rtm;
    Xlam = atan2(Rtm2,Rtm1);
    Xlamd = (Rtm1*Vtm2 - Rtm2*Vtm1)/(Rtm^2);
    Xnc = Xnp*Vc*Xlamd;
    Am1 = -Xnc*sin(Xlam);
    Am2 = Xnc*cos(Xlam);;
    Vt1 = -Vt*cos(beta);
    Vt2 = Vt*sin(beta);
    betad = Xnt/Vt;
    flag = 1;
  endwhile

  flag = 0;
  beta = 0.5*(betaOld + beta + h*betad);
  Rt1 = 0.5*(Rt1Old + Rt1 + h*Vt1);
  Rt2 = 0.5*(Rt2Old + Rt2 + h*Vt2);
  Rm1 = 0.5*(Rm1Old + Rm1 + h*Vm1);
  Rm2 = 0.5*(Rm2Old + Rm2 + h*Vm2);
  Vm1 = 0.5*(Vm1Old + Vm1 + h*Am1);
  Vm2 = 0.5*(Vm2Old + Vm2 + h*Am2);
  s = s + h;
  if s >= 0.09999
    s = 0.;
    n = n + 1;
    arrayT(n) = t;
    arrayRt1(n) = Rt1;
    arrayRt2(n) = Rt2;
    arrayRm1(n) = Rm1;
    arrayRm2(n) = Rm2;
    arrayXncg(n) = Xnc/32.2;
    arrayRtm(n) = Rtm;
  endif
  step = 1;
endwhile
Rtm

%% Plotting
figure
plot(arrayRt1,arrayRt2,arrayRm1,arrayRm2)
grid on;
title '2D Tactical Missile-Target Engagement Sim'
xlabel 'Downrange (ft)'
ylabel 'Altitude (ft)'


