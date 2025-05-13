%% Oral Counteract Model
Period = 15;
time = 100;
t=linspace(0,time);
k_b = 0.1;
k_t = 0.1;
k_e = 0.2;
k_s = 0.3;
C_0 = 2;
s_1 = -0.5*((k_b+k_e+k_t) + sqrt((k_b+k_e+k_t)^2 - 4*k_e*k_t));
s_2 = -0.5*((k_b+k_e+k_t) - sqrt((k_b+k_e+k_t)^2 - 4*k_e*k_t));
e = C_0/(s_1-s_2)*(exp(s_1*t)*(k_t+s_1) - exp(s_2*t)*(k_t+s_2)) - C_0*k_s/(k_s-k_e)*(exp(-k_e*(t+7))-exp(-k_s*(t+7)));
e3 = C_0/(s_1-s_2)*(exp(s_1*t)*(k_t+s_1) - exp(s_2*t)*(k_t+s_2)) - C_0*k_s/(k_s-k_e)*(exp(-k_e*(t+7))-exp(-k_s*(t+7)));
for i=1:5
t1 = zeros(1,Period);
e2 = e3;
for w=1:i
e2 = cat(2,t1,e2);
end
e1 = e2;
e = cat(2,e,t1) + e1;
t = cat(2,t,linspace(max(t),max(t)+Period,Period));
end
figure()

plot(t,e)
xlabel('Time (hours)')
ylabel('Drug Concentration (units)')
title('Regular Dosing of Drug Orally and Intravenously Over 100 Hours')

%% IV Counteract Model
Period = 15;
time = 100;
t=linspace(0,time);
k_b = 0.1;
k_t = 0.1;
k_e = 0.2;
k_s = 0.1;
C_0 = 0.5;
C_0_2 = 2;
s_1 = -0.5*((k_b+k_e+k_t) + sqrt((k_b+k_e+k_t)^2 - 4*k_e*k_t));
s_2 = -0.5*((k_b+k_e+k_t) - sqrt((k_b+k_e+k_t)^2 - 4*k_e*k_t));
e = C_0_2*k_s/(k_s-k_e)*(exp(-k_e*(t+7))-exp(-k_s*(t+7))) - C_0/(s_1-s_2)*(exp(s_1*t)*(k_t+s_1) - exp(s_2*t)*(k_t+s_2));
e3 = C_0_2*k_s/(k_s-k_e)*(exp(-k_e*(t+7))-exp(-k_s*(t+7))) - C_0/(s_1-s_2)*(exp(s_1*t)*(k_t+s_1) - exp(s_2*t)*(k_t+s_2));
for i=1:5
t1 = zeros(1,Period);
e2 = e3;
for w=1:i
e2 = cat(2,t1,e2);
end
e1 = e2;
e = cat(2,e,t1) + e1;
t = cat(2,t,linspace(max(t),max(t)+Period,Period));
end
figure()

plot(t,e)
xlabel('Time (hours)')
ylabel('Drug Concentration (units)')
title('Regular Dosing of Drug Orally and Intravenously Over 100 Hours')





