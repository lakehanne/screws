clc; clear all
syms a1 a2 a3 a real;
ahat = [0 -a3 a2; a3 0 -a1; -a2 a1 0];
lhs = ahat^2;
norm_a_sq = a1^2 + a2^2+a3^2;% * eye(3);
a = [a1 a2 a3]';
rhs = a*a.' - norm_a_sq*eye(3);

isequal(lhs, rhs)

lhs_2 = ahat^3;
rhs_2 = -norm_a_sq * ahat;
isequal(simplify(lhs_2), simplify(rhs_2))

%% Exponential map for twists
clc; clear all;
syms v w_hat w1 w2 w3 w
zeta_hat  = [w_hat v; 0 0];
zeta_hat_sq = zeta_hat ^2;
zeta_hat_s = [-1, w_hat*v; 0 0];

tw = [v; w];
%% ellipse 
clc; clear 
syms a b t real; 
den = sqrt(a^2*(sin(t))^2 + b^2*(cos(t))^2 );
T = [-a*sin(t)/den; b*cos(t)/den];
Tprime = [diff(T(1)), diff(T(2))];
k = [-Tprime(1)/a*sin(t), Tprime(2)/b*cos(t)]

%% Null space redundant manipulator test
clc; clear all
syms l1 l2 l3 t1 t2 t3
pdot = [ -l1*sin(t1) - l2*sin(t1+t2) - l3*sin(t1+t2+t3), -l2*sin(t1+t2)-l3*sin(t1+t2+t3), -l3*sin(t1+t2+t3);...
         l1*cos(t1) + l2*cos(t1+t2) + l3*cos(t1+t2+t3), l2*cos(t1+t2)+l3*cos(t1+t2+t3), l3*cos(t1+t2+t3)];
Vn = [l2*l3*sin(t3); -l2*l3*sin(t3) - l1*l3*sin(t2+t3); l1*l2*sin(t2) + l1*l3*sin(t2+t3)]

%% exponential map of twist map
clc; clear all
syms  t a w1 w2 w3 real
w = [w1 w2 w3]';
what = [0 -w3 w2; w3 0 -w1; -w2 w1 0];
emap = eye(4) + [what*(1-sin(t)) 0; zeros(1,3), 1] + tose3(what^2 * (1 - cos(t)));% 0; zeros(1,3), 1];
lhs = (eye(4) - emap)*tose3(what) + tose3(eye(3)*dot(w, w.')*t);
simplify(subs(lhs, t, a))
%% exponential map of twist map
clc; clear all
syms  t a w1 w2 w3 real
w = [w1 w2 w3]';
what = [0 -w3 w2; w3 0 -w1; -w2 w1 0];
emap = eye(3) + what*(1-sin(t)) + what^2 * (1 - cos(t));% 0; zeros(1,3), 1];
lhs = eye(3) - emap*what + eye(3)*dot(w, w.')*t;
simplify(subs(lhs, t, a))
%% 
syms l1 l2 double
w = [0 0 1]';
z1 = zeros(3, 1); z1(3,1) = 1
%[z2, z3] = deal(z1);
z2 = [l1 0 0];
z3 = [l1+l2, 0 0];
%% Deformations gradient
clc; clear all
syms r R l L theta Theta real
lambdaz = l/L;
lambda  = r/R;
F = [R^2/(r^2) 0 0; ...
     0 r/R 0; ...
     0 0 r/R];
%% 
% clc; clear all
% syms F real
lc = F*F';
rc = F'*F;
diff(trace(rc))
diff(trace(inv(lc)))
%%
function [se3] = tose3(so3)
se3 = [so3, 0; zeros(1,3), 1];
end 