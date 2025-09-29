clc, clear, close all;

% Exercise 1

% 1. The transfer function of our system is:
G = tf(10, [1 3 10])

% 2. Poles and zeros of the system are:
poles = pole(G)
zeros = zero(G)

% 3. DC gain is:
dcgainG = dcgain(G)

% 4. Step response of the system is:
figure;
step(G);

% 5. Frequency response (Bode diagram):
figure;
bode(G);

%% Exercise 2
clc, clear, close all;

% Transfer function of our system:
G = tf(5, [1 2 0])

% 1. Open loop step response:
figure;
step(G);

% 2. Closed loop system with proportional controller Kp = 10.
kp = 10;
H = tf(5*kp, [1 2 0])
Gc = feedback(H, 1, -1)

% 3. Step responses with and without the proportional controller.
figure;
step(G, "r")
legend('Open Loop')

figure;
step(Gc, "b")
legend('Closed Loop');

% 4. With the proportional controller Kp = 10 the closed-loop response becomes much faster 
% compared to the open-loop system. Because the plant is type-1 (it has an integrator), 
% the steady-state error to a step input goes to zero. The drawback is low damping, 
% so the response shows overshoot and oscillations before settling.

%% Exercise 3
clc, clear, close all;

% We have this system:
G = tf(2, [1 5])

% 1. Open loop step response.
figure;
step(G)

% 2. Closed loop system with PI controller:
kp = 2;
ki = 5;
C = tf([kp ki], [1 0])
H = G*C % open loop.

% 3. Closed loop transfer function.
Gc = feedback(H, 1, -1)

% 4. Step responses with and without the PI controller:
figure;
step(G);
legend("Open loop step response");

figure;
step(Gc);
legend("Closed loop step response");

%% Exercise 4
clc, clear, close all;

% System's transfer function:
G = tf(4, [1 3 0])

% 1. Open loop step response and Bode diagram:
figure;
step(G);
figure;
bode(G);

% 2. PID controller:
kp = 10;
ki = 3;
kd = 8;
s = tf('s');
C = kp + ki/s + kd*s
H = G*C

% 3. Closed loop transfer function:
Gc = feedback(H, 1, -1)

% 4. Step response of Gc:
figure;
step(Gc);
figure;
bode(Gc);
hold on;
bode(H);
legend("Closed loop", "Open loop");

