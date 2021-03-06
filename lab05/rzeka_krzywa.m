clear;
close all;
cvx_clear;

A_point = [-10; 10];
B_point = [-15; -15];

x = [-20; -20]; % wsp�rz�dna pierwsza i druga �rodk�w okr�g�w
y = [10; 10];
r = [20; 25];
d = r(2) - r(1);
th = 0:pi/50:2*pi;

cvx_begin quiet
   variables x1(2,1) x2(2,1) a;
   minimize(norm(A_point - x1) + norm(x2 - B_point));
   subject to
       (x1(1)-x(1))*r(2)==(x2(1)-x(1))*r(1);
       (x1(2)-y(1))*r(2)==(x2(2)-y(1))*r(1);
       
        norm(x1-[x(1);y(1)])<=r(1);% Punkt x1 znajduje sie w wewnetrznym kole
        norm(x2-[x(1);y(1)])<=r(2);% Punkt x2 znajduje sie w zewnetrznym kole
cvx_end

figure(1)
grid;
hold on
axis equal;

xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
plot(xunit(1, :), yunit(1, :));
plot(xunit(2, :), yunit(2, :));

plot(A_point(1), A_point(2), 'k*');
plot(B_point(1), B_point(2), 'r*');

plot(x1(1), x1(2), 'b*');
plot(x2(1), x2(2), 'g*');

plot([x1(1),A_point(1)], [x1(2), A_point(2)]);
plot([x2(1),B_point(1)], [x2(2), B_point(2)]);

plot([x1(1), x2(1)], [x1(2), x2(2)]);

axis([-20 20 -20 20]);
% hold off