clc;
clear all;
close all;

M = 1.9885e+30;
m = 5.9722e+24;
ga = 6.6743e-11;
r_min = 147098291000.0;
T = 31558149.8;
V = 29765.0;

alpha = (T * V) / r_min;
betta = -(ga * M * T) / (r_min^2 * V);

x_0 = 1;
y_0 = 0;
N = 1000;
t_N = 2;

%Cartesian
x = zeros(1, N);
y = zeros(1, N);
Px = zeros(1, N);
Py = zeros(1, N);

%polar
r = zeros(1, N);
phi = zeros(1, N);
P_r = zeros(1, N);
P_phi = zeros(1, N);

%3 version idk ???
R = zeros(1, N);
Phi = zeros(1, N);
P_R = zeros(1, N);

%aria
A1 = @(x, y, Px, Py)(x .* Py - y .* Px);
%energy
H1 = @(x, y, Px, Py)(0.5 *(Px.^2 + Py.^2) ...
                        - 1 ./ ( sqrt(x.^2 + y.^2)));

H2 = @(r, phi, P_r, P_phi)(0.5 * (P_r.^2 + P_phi.^2) - 1 ./ r);
A2 = @(r, phi, P_r, P_phi)(r .* P_phi);

H3 = @(r, P_r, A)(0.5*(P_r.^2 + A^2 ./ r.^2) - 1 ./ r);

t = linspace(0, t_N, N);
dt = t_N / (N - 1);

%control data
%%%%%%%%%%%%
h = zeros(1, N);
a = zeros(1, N);
h2 = zeros(1, N);
a2 = zeros(1, N);
h3 = zeros(1, N);
%%%%%%%%%%%%


%zero data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x(1) = x_0;
y(1) = y_0;
Px(1) = 0.;
Py(1) = 1;

r(1) = 1;
phi(1) = 0;
P_r(1) = 0.011;
P_phi(1) = 0.9999;

R(1) = 1;
P_R(1) = 0;
A = 1;

h(1) = H1(x(1), y(1), Px(1), Py(1));
a(1) = A1(x(1), y(1), Px(1), Py(1));

h2(1) = H2(r(1), phi(1), P_r(1), P_phi(1));
a2(1) = A2(r(1), phi(1), P_r(1), P_phi(1));

h3(1) = H3(R(1), P_R(1), A);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 2:N
  %1
  x(i) = x(i - 1) + dt * alpha * Px(i-1) + 0.5 * dt^2 *alpha * betta *...
                      x(i - 1) / ((x(i - 1))^2 + (y(i - 1))^2)^(3/2);

  y(i) = y(i - 1) + dt * alpha * Py(i-1) + 0.5 * dt^2 *alpha * betta *...
                      y(i - 1) / ((x(i - 1))^2 + (y(i - 1))^2)^(3/2);

  Px(i) = Px(i - 1) + dt * betta *...
                        x(i - 1) / ((x(i - 1))^2 + (y(i - 1))^2)^(3/2) +...
                        dt ^2 / (2 * ((x(i - 1))^2 + (y(i - 1))^2)^(5/2)) *...
                        betta * alpha *(Px(i - 1) *(y(i - 1)^2 - 2* x(i - 1)^2) - ...
                        Py(i - 1) * x(i - 1) * y(i - 1));

  Py(i) = Py(i - 1) + dt * betta *...
                        y (i - 1) / ((x(i - 1))^2 + (y(i - 1))^2)^(3/2)+...
                        dt ^2 / (2 * ((x(i - 1))^2 + (y(i - 1))^2)^(5/2)) *...
                        betta * alpha * (Py(i - 1) *(x(i - 1)^2 - 2* y(i - 1)^2) - ...
                        Px(i - 1) * x(i - 1) * y(i - 1));

  %2
  r(i) = r(i - 1) + dt * alpha * P_r(i -1) + 0.5*dt^2 *alpha *...
                      (betta / r(i -1)^2 + alpha* P_phi(i - 1)^2 / r(i -1));

  phi(i) = phi(i - 1) + dt *alpha *P_phi(i - 1) / r(i -1) - alpha^2 *dt^2*...
                        P_r(i -1) * P_phi(i-1)/ r(i-1)^2;

  P_r(i) = P_r(i -1) + dt *(betta / r(i -1)^2 + alpha * P_phi(i - 1)^2 / r(i -1)) -...
                          0.5 * dt^2 * P_r(i-1) * alpha / r(i-1)^2 *(2*betta/ r(i-1) +3*alpha*P_phi(i-1)^2);

  P_phi(i) = P_phi(i - 1) - dt * alpha * P_r(i -1) * P_phi(i-1)/ r(i-1) - alpha*0.5*dt^2 / r(i-1)^2 *...
                              (P_phi(i-1)*(betta / r(i-1) +alpha*P_phi(i-1)^2) - 2*alpha*P_phi(i-1)*P_r(i-1)^2);

  %3

  R(i) = R(i-1) + dt * alpha * P_R(i -1) + 0.5*dt^2*(betta/R(i-1)^2 +alpha*A^2/R(i-1)^3); %- 1/6*dt^3*P_R(i-1)*alpha/R(i-1)^3*(2*betta + 3*A^2*alpha/R(i-1));

  Phi(i) = Phi(i-1) +dt* alpha*A/R(i-1)^2 -dt^2*alpha^2*A*P_R(i-1)/R(i-1)^3;% - 1/3^dt^3*alpha^2*A/R(i-1)^4*(betta/R(i-1)+alpha*A^2/R(i-1)^2 - 3*P_R(i-1)^2*R(i-1)^2*alpha);

  P_R(i) = P_R(i-1) + dt*(betta/R(i-1)^2 + alpha*A^2/R(i-1)^3) - 0.5*dt^2*P_R(i-1)*alpha/R(i-1)^3*(2*betta + 3*A^2*alpha/R(i-1));

  %control
  h(i) = H1(x(i), y(i), Px(i), Py(i));
  a(i) = A1(x(i), y(i), Px(i), Py(i));

  h2(i) = H2(r(i), phi(i), P_r(i), P_phi(i));
  a2(i) = A2(r(i), phi(i), P_r(i), P_phi(i));

  h3(i) = H3(R(i), P_R(i), A);
end
figure(1)
plot(x_0, y_0, 'ro');
hold on;
plot(x, y);
polar(phi, r);
polar(Phi, R);
%end
plot(x(N), y(N),'r+');
polar(phi(N), r(N), 'r*');
polar(Phi(N), R(N), 'rp');
legend("Start", "x, y", "r, phi", "R, Phi", "end1", "end2", "end3");

figure(2);
semilogy(t(2:N), abs(h - h(1))(2:N));
hold on;
semilogy(t(2:N), abs(h2 - h2(1))(2:N));
semilogy(t(2:N), abs(h3 - h3(1))(2:N));
legend("H_1", "H_2", "H_3");

figure(3);

semilogy(t(2:N), abs(a - a(1))(2:N));
hold on;
semilogy(t(2:N), abs(a2 - a2(1))(2:N));
legend("A_1", "A_2");
