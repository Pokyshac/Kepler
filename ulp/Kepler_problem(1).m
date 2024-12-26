clc;
clear all;
close all;

#data for Earth and Sun
%%%%%%%%%%%%%%%%%%%
M = 1.9885e+30;
m_e = 5.9722e+24;
m = m_e*M  /(m_e+M);
ga = 6.6743e-11;
r_min = 147098291000.0;
r_max = 1.0167020 * r_min;
T = 31558149.8;
V = 29765.0;
%%%%%%%%%%%%%%%%%%%

#time
dt = 1e-3;
t_N = 3;
N = ceil(t_N / dt);
t = linspace(0, t_N, N);



#precision
q = 4;

#coef in Newton equation
alpha = (T * V) / r_min;
betta = -(ga * M * T) / (r_min^2 * V);
gam = V^2 * r_min / ga / M;


alpha_1 = MultE(dt, MultE(MultE(T, V, q), InverseNum(r_min, q), q), q);
a11 = MultE(powkE(r_min, 2, q), V, q);
betta_1 = -MultE(dt, MultE(MultE(MultE(ga, M, q), T, q), InverseNum(a11, q), q), q);
gam_1 = MultE(MultE(powkE(V, 2, q), r_min, q), InverseNum(MultE(ga, M, q), q), q);
%Cartesian
x = zeros(1, N);
y = zeros(1, N);
Px = zeros(1, N);
Py = zeros(1, N);

%Cartesian with num as sequence

x_1 = zeros(q, N).';
y_1 = zeros(q, N).';
Px_1 = zeros(q, N).';
Py_1 = zeros(q, N).';


%right part of equestions
%1-2 comp dP/dt, 3-4 dr/dt
sys = @(r, P)([betta* r ./ norm(r)^(3); alpha* P]);

function s = sysE(x, y, Px, Py, alp, bet, q)
  #s = [%1-2 comp dP/dt, 3-4 dr/dt]
  %r^2
  r2 = SubE(powkE(x, 2,  q), powkE(y, 2,  q), q);
  %1 / r
  inv = seq_revers_sqrt(r2, q);
  %1 / r^3
  r3 = powkE(inv, 3, q);
  %beta /r^3
  pl = MultE(bet, r3, q);

  s = [MultE(pl, x, q).' , MultE(pl, y, q).', ...
         MultE(Px, alp, q).' , MultE(Py, alp, q).'];
endfunction
%aria
A1 = @(x, y, Px, Py)(x .* Py - y .* Px);
%energy
H1 = @(x, y, Px, Py)(gam*0.5 *(Px.^2 + Py.^2) ...
                        - 1 ./ ( sqrt(x.^2 + y.^2)));

function E = energy(Px, Py, x, y, q, gam)
  p = MultE(gam, SubE(powkE(Px, 2,  q) / 2, powkE(Py, 2,  q) / 2, q), q);
  r = SubE(powkE(x, 2,  q), powkE(y, 2,  q), q);
  inv = seq_revers_sqrt(r, q);
  E = SubE(p, -r, q)(1);
endfunction

function A = aria(Px, Py, x, y, q)
 A = SubE(MultE(x, Py, q), -MultE(y, Px, q), q)(1);
endfunction


%control data
%%%%%%%%%%%%
h = zeros(1, N);
h_1 = zeros(1, N);
a = zeros(1, N);
a_1 = zeros(1, N);
%%%%%%%%%%%%

#solution
Phi = linspace(0, 2*pi, N);
##
##r = [r_min, 0, 0]; v = [0, V, 0];
##c = norm(cross(r, v));
##E = V^2 / 2 - ga*M / r_min;
##p = c^2 / (ga*M) / r_min;
##e = sqrt(1 + 2 * E *c^2/(ga*M)^2);
##

p =( r_max^2 / r_min^2) ;
e =  0.0167;
rad = p ./ (1 + e*cos(Phi));
X = rad.*cos(Phi);
Y = rad.*sin(Phi);

#X += (max(X) - min(X))*e / 2;
%zero data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#for solving I used Euler algorithm 2nd precision:
##X(i + 1) = X(i - 1) + 2 * h * F(X(i))
##with data in 2nd time-step:
##X(2) = X(1) + h * F(X(i))

x_0 = X(1);
y_0 = Y(1);
px_0 = 0;
py_0 = 1;

s1 = sys([x_0; y_0], [px_0; py_0]);
x(1) = x_0;
y(1) = y_0;
Px(1) = px_0;
Py(1) = py_0;

x(2) = x_0 + dt*s1(3);
y(2) = y_0 + dt*s1(4);
Px(2) = px_0 + dt*s1(1);
Py(2) = py_0 + dt*s1(2);


x_1(1, 1) = x_0;
y_1(1, 1) = y_0;
x_1(1, 2) = my_ulp(x_0);
y_1(1, 2) = 0.;
Px_1(1, 1) = 0.;
Py_1(1, 1) = 1.;

s1 = sysE(x_1(1,:), y_1(1,:), Px_1(1,:), Py_1(1,:), alpha_1, betta_1, q);

x_1(2, :) = SubE(x_1(1 ,:), s1(:, 3).', q);
y_1(2, :) = SubE(y_1(1, :),  s1(:, 4).', q);
Px_1(2, :) = SubE(Px_1(1, :), s1(:, 1).', q);
Py_1(2, :) = SubE(Py_1(1, :), s1(:, 2).', q);


h(1) = H1(x(1), y(1), Px(1), Py(1));
h(2) = H1(x(2), y(2), Px(2), Py(2));
a(1) = A1(x(1), y(1), Px(1), Py(1));
a(2) = A1(x(2), y(2), Px(2), Py(2));

h_1(1) = energy(Px_1(1, :), Py_1(1, :), x_1(1, :), y_1(1, :), q, gam_1);
h_1(2) = energy(Px_1(2, :), Py_1(2, :), x_1(2, :), y_1(2, :), q, gam_1);
a_1(1) = aria(x_1(1, :), y_1(1, :), Px_1(1, :), Py_1(1, :), q);
a_1(2) = aria(x_1(2, :), y_1(2, :), Px_1(2, :), Py_1(2, :), q);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 3:N
#1
    s1 = sys([x(i-1); y(i-1)], [Px(i-1); Py(i-1)]);
    x(i) = x(i - 2) + 2*dt* s1(3);
    y(i) = y(i - 2) + 2*dt* s1(4);
    Px(i) = Px(i - 2) + 2*dt* s1(1);
    Py(i) = Py(i - 2) + 2*dt* s1(2);

 %1_1
    s1 = sysE(x_1(i-1,:), y_1(i-1,:), Px_1(i-1,:), Py_1(i-1,:), alpha_1, betta_1, q);
    x_1(i, :) = SubE(x_1(i - 2 ,:),  2* s1(:, 3).', q);
    y_1(i, :) = SubE(y_1(i - 2, :), 2* s1(:, 4).', q);
    Px_1(i, :) = SubE(Px_1(i - 2, :), 2* s1(:, 1).', q);
    Py_1(i, :) = SubE(Py_1(i - 2, :), 2* s1(:, 2).', q);

  %control
  h(i) = H1(x(i), y(i), Px(i), Py(i));
  h_1(i) = energy(Px_1(i, :), Py_1(i, :), x_1(i, :), y_1(i, :), q, gam_1);
  a(i) = A1(x(i), y(i), Px(i), Py(i));
  a_1(i) = aria(x_1(i, :), y_1(i, :), Px_1(i, :), Py_1(i, :), q);
 
end
figure(1)

plot(X, Y);
hold on
grid on
xlim([min([x, x_1(:, 1).'] )-1e-1, max([x, x_1(:, 1).'])+1e-1]);
ylim([min([y, y_1(:, 1).'])-1e-1, max([y, y_1(:, 1).'])+1e-1]);

plot(x_0, y_0, 'ro');
plot(x, y, 'color', 'red');
plot(x_1(:, 1), y_1(:, 1), 'color', 'green');

plot(x(N), y(N),'r+', 'color', 'red');
plot(x_1(N, 1), y_1(N, 1),'r*', 'color', 'green');

legend("solution", "Start", "x, y", "x_1, y_1",  "end1", "end2"); %"r, phi", "R, Phi",
set(gca,  "fontsize", 20)

figure(2);

subplot(2, 1, 1);

semilogy(t(2:N), abs(h - h(1))(2:N));
title("energy error");
legend('numbers')
set(gca,  "fontsize", 20)
subplot(2, 1, 2);
semilogy(t(2:N), abs(h_1 - h_1(1))(2:N));
legend('expansion');
set(gca,  "fontsize", 20)

figure(3);

subplot(2, 1, 1);

semilogy(t(2:N), abs(a - a(1))(2:N));
title("aria error");
legend('numbers')
set(gca,  "fontsize", 20)
subplot(2, 1, 2);
semilogy(t(2:N), abs(a_1 - a_1(1))(2:N));
legend('expansion');
set(gca,  "fontsize", 20)


figure(4);

semilogy(t(2:N), abs(sqrt(x_1(:,1).^2 + y_1(:,1).^2) - sqrt(x.^2 + y.^2))(2:N));
title('coordinats error');
set(gca,  "fontsize", 20)
