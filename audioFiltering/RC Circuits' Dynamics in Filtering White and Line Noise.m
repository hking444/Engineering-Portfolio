%% Case Study 2


%% Part1 1
% Analytical Solution
R = 1000;
C = 0.000001;
tau = R*C;
v_in = 5;
t = linspace(0,0.1,100);
hold on;
plot(t,f(v_in, R, tau, t));

% Numerical Solution (ode45)
tspan = [0 0.1];
I_0 = 0;
[t, v] = ode45(@odefun, tspan, I_0);
plot(t,v/R);
title("Current of RC Circuit over Time Given R = 1k\Omega and C = 1\muF");
xlabel("Time (seconds)");
ylabel("Current (A)");
legend("Analytical Solution", "Computational Solution");
hold off;


% Part1 2
% Analytical Solution
t = linspace(0,0.1,100);
figure();
hold on;
plot(t,f2(v_in, tau, t));

% Numerical Solution
v_0 = 0;
[t, v] = ode45(@odefun, tspan, v_0);
plot(t,v);
title("Voltage of RC Circuit over Time Given R = 1k\Omega and C = 1\muF");
xlabel("Time (seconds)");
ylabel("Voltage (V)");
legend("Analytical Solution", "Computational Solution");
hold off;


% Part1 3
R = [100, 1000, 10000, 100000];
C = [0.000001, 0.00001, 0.0001, 0.001];
figure();
tl = tiledlayout(4,4);
for i = 1:4
    for j = 1:4
    tau = R(i)*C(j);
    nexttile;
    t = linspace(0,0.1,100);
    plot(t,f(v_in, R(i), tau, t));
    title("[R = " + R(i) + " C = " + C(j) + "]");
    end
end
title(tl, "Current of RC Circuit over Time Varying R and C");
xlabel(tl, "Time (seconds)");
ylabel(tl, "Current (A)");


%% Part2 1
% Analytical Solution
t = linspace(0,10,100);
freq = 1;
R = 1000;
C = 0.000001;
figure();
hold on;
plot(t,f3(freq, R, C, t));

% Numerical Solution (ode45)
tspan = [0 10];
v_0 = 0;
[t, v] = ode45(@odefun2, tspan, v_0);
plot(t,v);
title("Voltage of RC Circuit with Input Vector v_{in} = 5sin(2\pift)");
xlabel("Time (seconds)");
ylabel("Voltage (V)");
legend("Analytical Solution", "Computational Solution");
hold off;


% Part2 2
freq = linspace(50, 1000, 100);
amp = zeros(100,1);
phase_shift = zeros(100,1);
for i = 1:length(freq)
    tspan = [0,1/freq(i)];
    [t, v] = bode45(freq(i), tspan, v_0);
    amp(i) = max(v);
    max_index = v==max(v);
    if (t(max_index)-1/(4*freq(i))) > 1/(2*freq(i))
        phase_shift(i) = 5/(4*freq(i)) - t(max_index);
    end
    phase_shift(i) = t(max_index);
end
figure();
plot(freq,amp);
title("Amplitude of v_{out} versus Frequency");
xlabel("Frequency (Hz)");
ylabel("Amplitude (V)");
figure();
plot(freq, phase_shift);
title("Phase Shift of v_{out} versus Frequency");
xlabel("Frequency (Hz)");
ylabel("Time (seconds)");


%% Part 4 2
%playSound(Vsound,Fs)
[pxx, g] = pwelch(Vsound,[],[],[],Fs);
fra = maxk(pxx,20);
%plot(g, pow2db(pxx))

R = 16;
C = 0.000000898;
k = -1/(R^2*C^2);
Camp = (2*C*R - R*C)/R^2*C^2;
A = [0 1;
     k -Camp];
B = [0;
     -Fs^2];
C = [1 0];
D = 0;
sys = ss(A,B,C,D);
t = linspace(0,20,length(Vsound));
u = Vsound;
lsim(sys,u,t);
Vsoundedit = lsim(sys,u,t);
playSound(Vsoundedit,Fs);

% Functions 
function as = f(v_in, R, tau, t)
    as = ((v_in)*(1-exp(-(1/tau).*t)))/R;
end

function dvdt = odefun(t, v)
    R = 1000;
    C = 0.000001;
    tau = R*C;
    v_in = 5;
    dvdt = v_in/tau - v/tau;
end

function as = f2(v_in, tau, t)
    as = v_in*(1-exp(-(1/tau).*t));
end

function as = f3(freq, R, C, t)
    A = 5/(1+4*C^2*R^2*pi^2*freq^2);
    B = (-10*C*R*pi*freq)/(1+4*C^2*R^2*pi^2*freq^2);
    c1 = -B;
    c2 = -B/(R*C) - 2*A*pi*freq;
    as = exp((-1/(R*C)).*t).*(c1 + c2.*t) + A*sin(2*pi*freq.*t) + B*cos(2*pi*freq.*t);
end

function dvdt = odefun2(t, v)
    R = 1000;
    C = 0.000001;
    freq = 1;
    dvdt = (5/(R*C))*sin(2*pi*freq*t) - v/(R*C); 
end

function [t,v] = bode45(freq, tspan, x_0)
    [t,v] = ode45(@odefun, tspan, x_0);
    function y = odefun(t,v)
        R = 1000;
        C = 0.000001;
        y = (5/(R*C))*sin(2*pi*freq*t) - v/(R*C);
    end
end

function playSound(y, Fs)
    obj = audioplayer(y/max(abs(y)), Fs);
    playblocking(obj);
end
