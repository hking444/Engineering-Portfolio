
%% Basic Periodical Administration Model
Period = 15;
time = 100;
t=linspace(0,time);
k_s = 0.1;
C_0 = 2;
C_1 = 0.5;
k_e = 0.2;
rep=5;
e = (C_0*(k_s)/(-k_e+k_s))*(exp(-k_e*t)-exp(-k_s*t))- (C_1*(k_s)/(-k_e+k_s))*(exp(-k_e*t)-exp(-k_s*t)) ;
e3 = (C_0*(k_s)/(-k_e+k_s))*(exp(-k_e*t)-exp(-k_s*t))- (C_1*(k_s)/(-k_e+k_s))*(exp(-k_e*t)-exp(-k_s*t)) ;
%adding each exponential and its counteragent at T intervals rep times
for i=1:rep
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
title('Regular Dosing Over 100 Hours')
hold on;
%%
%no control
Period = 100;
time = 100;
rep = 5;
t=linspace(0,time);
k_s = 0.1;
C_0 = 2;
k_e = 0.2;
e = C_0*exp(-k_s*t)  ;
e3 =C_0*exp(-k_s*t) ;
for i=1:rep
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
hold off;