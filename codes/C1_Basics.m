% ΣΑΕ και Matlab.

clc, clear, close all;

num = [25 4*25];
d1 = [1 0];
d2 = [1 10];
d3 = [1 10 50];
d12 = conv(d1,d2); % polynomial multiplication.
den = conv(d12,d3);

G = tf(num, den)

% Alternatively:
s = tf("s") % i declare the symbolic variable 's'.
G2 = 25*(s+4)/(s*(s+10)*(s^2+10*s+50))

% Alternatively:
sys1 = tf(num,d12);
sys2 = tf(1,d3);
G3 = series(sys1, sys2)
% or:
G3 = sys1*sys2

% Poles and Zeros of a system.
poles = pole(G3)
zeros = zero(G3)

p = roots(den)
z = roots(num)

[z,p,k] = zpkdata(G,"v") % k = the gain. Not necessarily the DC gain.
                         % v = vector format.
                         % zpk = zero,pole,gain.
                         % k = 25 which multiplies the entire transfer
                         % function.
% Closed loop system.
% sys = feedback(sys1, sys2, sign) sign = the magnitude of the feedback.
cloop1 = feedback(G, 1, -1);
[zc1,pc1,kc1] = zpkdata(cloop1, "v")

Hc = tf(1, [1 1]);
cloop2 = feedback(G, Hc, -1);
[zc2,pc2,kc2] = zpkdata(cloop2, "v")

% Step response:
figure;
step(G)
step(cloop1)
hold on;
step(cloop2)

t = 0:0.01:50;

u1 = 2*stepfun(t,0);
u2 = stepfun(t,5);

u3 = t; % linear input.
hold off;
plot(t,u1,t,u2);

lsim(cloop1,u2,t);
lsim(cloop2,u3,t);

%% ΚΑΕ Lab1
clc, clear, close all;

nVo = 8000;
dVo = [1 440.1 5164];
HVo = tf(nVo, dVo); % Transfer function of Voltage.

nTo = [-1250 -1250*440];
dTo = dVo;
HTo = tf(nTo, dTo); % Transfer function of Load.

p = roots(dVo)

dcHVo = dcgain(HVo)
dcHTo = dcgain(HTo)

figure
step(HVo) % Unit step response. Doesnt work when input isnt the unit step function.
figure
step(HTo)

HV = tf(18.69, [1 12.064]) % Approximating transfer function.
HT = tf([-2.92 -292*440], [1 12.064])

t = 0:0.0001:0.7;
uV = 150*stepfun(t,0); % the input.
yV1 = lsim(HVo, uV, t);
yV2 = lsim(HV, uV, t);
figure;
plot(t, yV1, t, yV2);

figure;
bode(HV);
figure;
bode(HT);

%% KAE Lab3
clc, clear, close all;

% Open Loop Transfer Functions.
HV = tf(18.6, [1 12.064]);
HT = tf(-2.92*[1 440], [1 12.064]);

% Closed Loop Transfer Functions.
HVc = tf(8.035, [1 40.1]);
HTc = tf(-2.92*[1 440], [1 40.1]);

% Response to unit step.
figure;
step(150*HV) % open loop response.
hold on;
step(150*HVc) % closed loop response.

t = 0:0.01:30;
hold off;

uV = 150*stepfun(t,0);
uT1 = 0.5*stepfun(t,0);
uT2 = 0.5*stepfun(t,8);
uT3 = -0.5*stepfun(t,22);
uT = uT1 + uT2 + uT3;

figure;
yV = lsim(HVc, uV, t);
yT = lsim(HTc, uT, t);

y = yV+yT;
figure;
plot(t,y,t,20*uT);

figure;
bode(HV);
hold on;
bode(HVc);

%% KAE Lab4
clc, clear, close all;

HVc = tf(32.7075*[1 10.639], [1 44.7715 347.979]);
HTc = tf(-2.92*[1 440 0], [1 44.7715 347.979]);

figure;
step(150*HVc);

t = 0:0.01:30;
uV = 150*stepfun(t,0);
uT1 = 0.5*stepfun(t,0);
uT2 = 0.5*stepfun(t,8);
uT3 = -0.5*stepfun(t,22);
uT = uT1 + uT2 + uT3;

yV = lsim(HVc, uV, t);
yT = lsim(HTc, uT, t);

y = yV+yT;
figure;
plot(t,y,t,20*uT);

figure;
bode(HVc);
figure;
bode(HTc);
