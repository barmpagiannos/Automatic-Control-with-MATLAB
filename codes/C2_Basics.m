clc, clear, close all;

% Εργαστήριο 1.

% Άσκηση 1.

% Έχουμε τη συνάρτηση μεταφοράς:
G = tf(8, [1 2 0])

% Συνάρτηση μεταφοράς κλειστού βρόχου:
Gc = feedback(G, 1, -1) % μοναδιαία βηματική ανάδραση.

% Βηματική απόκριση:
figure;
step(Gc, 10); % για χρονικό διάστημα 10sec.

% 1. Σφάλμα θέσης: βλέπουμε απο το σχήμα ότι το σφάλμα θέσης είναι μηδέν.

% 2. Σφάλμα ταχύτητας: απόκριση του συστήματος για είσοδο ράμπα.
t = 0:0.01:10;
u = t'; % ράμπα.
y = lsim(Gc, u, t); % έξοδος για το Gc, για είσοδο u και για χρόνο t.

% Plot την απόκριση του Gc για είσοδο ράμπα.
figure;
plot(t,u);
hold on;
plot(t,y);
title("Ramp Response");
xlabel("Time (sec");
ylabel("Amplitude");
legend("input", "output");
grid on;

% Plot το σφάλμα ταχύτητας. Πράγματι παρατηρούμε ότι το σφάλμα έπειτα από
% μερικές ταλαντώσεις σταθεροποιείται.
figure;
plot(t, u-y);
hold on;
yline(0.25, "--");
title("Error response");
xlabel("Time (sec)");
ylabel("Amplitude");
legend("e(t)");
grid on;

%% Άσκηση 2.
clc, clear, close all;

% Η συνάρτηση μεταφοράς του ελεγχόμενου συστήματος είναι:
G = tf([8 18], [1 0 -2])

% Σφάλμα θέσης:
kp = dcgain(G)
essp = 1/(1+kp)

% Συνάρτηση μεταφοράς συστήματος κλειστού βρόχου:
Gc = feedback(G,1,-1); % μοναδιαία αρνητική ανάδραση.

% Plot την βηματική απόκριση.
figure;
step(Gc,10);
hold on;
yline(1-essp, "r-", "y_{ss}");
[y,t] = step(Gc, 10); % y: the response.

% Το σφάλμα θέσης είναι:
ess_sim = 1 - y(end)

%% Άσκηση 3.
clc, clear, close all;

% Ελεγχόμενο σύστημα:
G = tf(4, [1 6 0])

% Ανάδραση:
H = tf(1, [1 0.75])

% Συνάρτηση μεταφοράς κλειστού βρόχου:
Gc = feedback(G, H, -1) % μοναδιαία αρνητική ανάδραση.

kp = dcgain(G*H) % open loop dc gain.
essp = 1/(1+kp)

%% Εργαστήριο 2.
clc, clear, close all;

% Συστήματα 1ης τάξης.

% Άσκηση 1.

% Το σύστημάς μας έχει συνάρτηση μεταφοράς:
num = 2;
den = [1 2];
G = tf(num, den)

figure;
step(G);
figure;
bodemag(G); % magnitude only bode diagram.

%% Άσκηση 2.
clc, clear, close all;

num = 8;
den = [1 8];
G = tf(num, den)

figure;
step(G);
figure;
bodeplot(G);

%% Συστήματα 2ης τάξης.
clc, clear, close all;

% Άσκηση 1.
G = tf(16, [1 10 16])

% Frequency ranges:
w1 = {0, 2};
w2 = {2, 8};
w3 = {8, 80};

% Step response.
figure;
step(G);

% Plot Bode magnitude:
figure;
subplot(1,3,1);
bodemag(G,w1);
ylim([-55 1]);
subplot(1,3,2);
bodemag(G,w2);
ylim([-55 1]);
subplot(1,3,3);
bodemag(G,w3);
ylim([-55 1]);

%% Άσκηση 2.
clc; clear; close all;

G = tf(1,[1 0.8 1]); % ζ = 0.4 (overshoot).
sinfo = stepinfo(G);
Tf = sinfo.SettlingTime
Tp = sinfo.PeakTime
Mp = sinfo.Overshoot    
T  = 6.9; % theoretically.  

% Step response.
figure; step(G,20); grid on
xline(Tp,"--"); xline(Tp+T,"--"); title('Step of G')

% Bode magnitude.
figure;
w = logspace(-2,2,800);
bodemag(G,w); grid on; title('Bode |G|')

zeta = [0.4 0.8 1.0];
wn   = 1;

H = cell(1,numel(zeta));           
for i = 1:numel(zeta)
    num = wn^2;
    den = [1 2*zeta(i)*wn wn^2];
    H{i} = tf(num,den);
end

% Step Response.
figure;
hold on;
grid on;
for i = 1:numel(zeta)
    step(H{i},20);               
end
hold off;
legend('\zeta=0.4','\zeta=0.8','\zeta=1.0','Location','best');
title('Step responses for different \zeta');

% Bode Plots.
figure;
hold on;
grid on;
for i = 1:numel(zeta)
    bodemag(H{i},w);               
end
hold off;
legend('\zeta=0.4','\zeta=0.8','\zeta=1.0','Location','best');
title('Bode magnitude for different \zeta');

%% Άσκηση 3.
clc, clear, close all;

z = 0.6;
wn = [2, 1, 0.5]; % range of wn values.

% Transfer Function.
G = cell(1,numel(wn));
for i=1:numel(wn)
    num = wn(i)^2;
    den = [1 2*z*wn(i)^2 wn(i)^2];
    G{i} = tf(num, den)
end

% Step Response.
figure;
hold on;
grid on;
for i = 1:numel(wn)
    step(G{i},20);               
end
hold off;
legend('w_n=2','w_n=1','w_n=0.5','Location','best');
title('Step responses for different w_n');

% Bode Plots.
figure;
hold on;
grid on;
for i = 1:numel(wn)
    bodemag(G{i},wn);               
end
hold off;
legend('w_n=2','w_n=1','w_n=0.5','Location','best');
title('Bode magnitude for different w_n');

%% Άσκηση 4.
clc, clear, close all;

z = [0.8, 0.6, 0.4, 1]; % range of z values.
wn = [2, 2.66, 4, 1.6]; % range of wn values.

% Transfer Function.
G = cell(1,numel(z));
for i=1:numel(z)
    num = wn(i)^2;
    den = [1 2*z(i)*wn(i)^2 wn(i)^2];
    G{i} = tf(num, den)
end

labels = arrayfun(@(zi,wi) sprintf('\\zeta=%.2f, \\omega_n=%.2f',zi,wi), ...
                  z, wn, 'UniformOutput', false);

% Step Response.
figure;
hold on;
grid on;
for i = 1:numel(z)
    step(G{i},20);               
end
hold off;
legend(labels,'Location','best');
title('Step responses for different \zeta and w_n');

% Bode Plots.
figure;
hold on;
grid on;
for i = 1:numel(wn)
    bodemag(G{i},wn);               
end
hold off;
legend(labels,'Location','best');
title('Bode magnitude for different \zeta and w_n');

%% Εργαστήριο 3.
clc, clear, close all;

% Άσκηση 1.

% Open loop transfer function.
s = tf('s'); % create the symbolic variable 's'.
G = 5/(0.5*s+1)

% Bode plot magnitude/phase.
figure;
bode(G);
grid on;

% Nyquist plot.
figure;
nyquist(G);
axis equal;

% Bode plot magnitude/phase but already calculated.
figure;
margin(G);
grid on;

%% Άσκηση 2.
clc, clear, close all;

% Open loop transfer function.
s = tf('s');
A = 20/((s-3)*(s+5))

% Bode plot magnitude/phase.
figure;
bode(A);
grid on;

% Nyquist plot.
figure;
nyquist(A);
axis equal;

%% Άσκηση 3.
clc, clear, close all;

% Open loop transfer function.
s = tf("s");
G = (5/(0.5*s+1))*(1/(0.2*s+1))

% Bode plot phase/margin.
figure;
margin(G);
grid on;

% Nyquist plot.
figure;
nyquist(G);
axis equal;

%% Άσκηση 4.
clc, clear, close all;

k = [1 5 8 10]; % range of k values.
s = tf("s");

G = cell(1,numel(k));
for i=1:numel(k)
    G{i} = k(i)*(1/(0.5*s+1))*(1/(0.2*s+1))*(1/(0.1*s+1));
end

% Bode Plots.
figure;
hold on;
grid on;
for i = 1:numel(k)
    bode(G{i});               
end
hold off;

%% Root Locus Plot.
clc, clear, close all;

% Root Locus Plot displays how the poles of the Closed Loop system are 
% affected due to the change of K from 0 to infinity.
% It's applied always to the Open Loop transfer function without the
% existence of the K (gain) parameter.

s = tf('s');
G = 1/(s*(s+2)) % open loop transfer function without K.

figure;
rlocus(G);
grid on;
title("Root Locus of G(s)=1/[s(s+2)]");

k = 0:0.5:20;
figure;
rlocus(G,k); % plots the root locus for specific range of k.

figure;
[K, poles] = rlocfind(G);

%% Εργαστήριο 5.
clc, clear, close all;

% Ο μετατροπέας/ενεργοποιητής μετρά τη στάθμη του νερού και δίνει εντολή
% στην αντλία να στείλει νερό στη δεξαμενή.

s = tf('s');
b = 0.006;
a = 0.007;
G = b/(s+a)

% 1. Σταθερά χρόνου και χρόνος αποκατάστασης. Βηματική απόκριση.
% Σταθερά χρόνου T = 1/a = 142.85 sec.
% Χρόνος αποκατάστασης ts = 4T = 571.4 sec.

figure;
step(G);
grid on;

% 2. Αναλογικός έλεγχος.
% α) Γεωμετρικός τόπος ριζών για μεταβαλλόμενο kp.

figure;
rlocus(G);

H = feedback(G,1,-1)

