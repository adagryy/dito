clear;
close all;
cvx_clear;
g = 10;
h = .1;
K = 100;
m = 1;
M=4;
alpha=0.1;
pmax = 5;
% way-points
k1=30; w1=[-2; 2];
k2=50; w2=[ 3; 3];
k3=70; w3=[-4; -1];
k4=100; w4=[2; -4];
% angles of the thrusters
theta1 = 50*pi/180;
theta2 = 120 *pi/180;
% f = zeros(K,1);
% vx = zeros(K,1);
% px = zeros(K,1);
p1 = 0;
v1 = 0;

cvx_begin
    variables u1(K) u2(K) fx(K - 1) vx(K) px(K) fy(K - 1) vy(K) pyy(K);
    minimize(sum(u1 + u2));
    subject to        
        fx(1:K-1) == cos(theta1) * u1(1:K-1) + cos(theta2) * u2(1:K-1);
        vx(2:K) == (1 - alpha) * vx(1:K-1) + (h / m) * fx(1:K-1);
        px(2:K) == px(1:K-1) + h * vx(1:K-1);
        
        fy(1:K-1) == sin(theta1) * u1(1:K-1) + sin(theta2) * u2(1:K-1) - m * g;
        vy(2:K) == (1 - alpha) * vy(1:K-1) + (h / m) * fy(1:K-1);
        pyy(2:K) == pyy(1:K-1) + h * vy(1:K-1);
        
        px(1) == p1;
        vx(1) == v1;
        px(k1) == w1(1);
        px(k2) == w2(1);
        px(k3) == w3(1);
        px(k4) == w4(1);
        
        pyy(1) == p1;
        vy(1) == v1;
        pyy(k1) == w1(2);
        pyy(k2) == w2(2);
        pyy(k3) == w3(2);
        pyy(k4) == w4(2);
        
        u1 >= 0;
        u2 >= 0;
        
        max(px) <= pmax;
        max(pyy) <= pmax;
        u1 <= 20;
        u2 <= 20;
% angle1 = [cos(theta1);sin(theta1)];
% angle2 = [cos(theta2);sin(theta2)];
% cvx_begin
%       variables u1(K) u2(K) f(K-1, 2) v(K, 2) p(K, 2);
%       minimize(sum(u1 + u2));
%       subject to
%           f(1 : K - 1) == angle1' .* u1(1 : K - 1) + angle2' .* u2(1 : K - 1);
%           p(1,1) == p1;
%         max(px) <= pmax;
cvx_end















