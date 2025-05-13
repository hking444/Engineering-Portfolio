%% Final Project

% Creation of Rudimentary Pharmacokinetic Models

% Oral Drug Administration
k_x = 0.1;
k_e = 0.2;
tspan = [0 120];
z0 = [2 0];
[t, z] = ode45(@(t,z) zodefun(t,z,k_x,k_e), tspan, z0);
figure();
plot(t, z(:,1), t, z(:,2));
title("Oral Drug Administration");
xlabel("Time (hours)");
ylabel("Drug Concentration (units)");
legend("Stomach (c_s)", "Blood (c_b)");

% Intravenous Drug Administration
k_x = 0.1;
k_y = 0.1;
k_e = 0.2;
tspan = [0 120];
g0 = [0 2];
[t, g] = ode45(@(t,g) godefun(t,g,k_x,k_y,k_e), tspan, g0);
figure();
plot(t,g(:,1),t,g(:,2));
title("Intravenous Drug Administration");
xlabel("Time (hours)");
ylabel("Drug Concentration (units)");
legend("Tissue (c_t)", "Blood (c_b)");


function dzdt = zodefun(t, z, k_x, k_e)
    dzdt = zeros(2,1);
    dzdt(1) = -k_x.*z(1);
    dzdt(2) = k_x.*z(1)-k_e.*z(2);
end
function dgdt = godefun(t, g, k_x, k_y, k_e)
    dgdt = zeros(2,1);
    dgdt(1) = k_y.*g(2) - k_x.*g(1);
    dgdt(2) = -(k_y+k_e).*g(2) + k_x.*g(1);
end