%% Laboratorium #3. Teoria optymalizacji.
% _Adam Gryczka_
%
% _20.03.2017_

%% Program do obliczania optymalnej trasy przejazdu, przy za�o�eniu konieczno�ci przekroczenia rzeki.
% Program optymalizuje tras� przejazdu z przekroczeniem rzeki mostem
% zbudowanym pod k�tem prostym. Poni�ej przedstawiono kod programu
% zaimplementowany w �rodowisku CVX:
clear;
close all;
cvx_clear;

% Punkty b�d�ce pocz�tkiem i celem trasy
A_point = [-1; 2];
B_point = [0; -3];
% wsp�czynniki b prostych tworz�cych brzegi rzeki
b1 = 2.5;
b2 = -1.5;
% wsp�czynnik kierunkowy prostych tworz�cych brzegi rzeki
a = 2;

cvx_begin quiet
   variables x1(2) x2(2) b;
   minimize(norm(A_point - x1) + norm(x2 - B_point));
   subject to
    x1(2) == a*x1(1) + b1;
    x2(2) == a*x2(1) + b2;
    x1(2) == -(1/a)*x1(1) + b;
    x2(2) == -(1/a)*x2(1) + b;
cvx_end

x = (-20:20);
y1 = a*x + b1;
y2 = a*x + b2;
figure(1)
grid;
hold on
axis([-4 4 -4 4]);
axis equal;
plot(x, y1);
plot(x, y2);
plot([x1(1), x2(1)], [x1(2), x2(2)]);
plot([x1(1),A_point(1)], [x1(2), A_point(2)]);
plot([x2(1),B_point(1)], [x2(2), B_point(2)]);
plot(A_point(1), A_point(2), 'r*');
plot(B_point(1), B_point(2), 'r*');
plot(x1(1), x1(2), 'b*');
plot(x2(1), x2(2), 'b*');
%%
% Powy�szy rysunek przedstawia map� przejazdu pomi�dzy punktami.

%% Realizacja optymalizacji przy za�o�eniu rzeki o kszta�cie nieliniowym
% Optymalizacja zak�ada, i� rzeka jest w kszta�cie okr�gu. Nale�y znale��
% najkr�tsz� tras� pomi�dzy dwoma punktami le��cymi po dw�ch r�nych
% stronach rzeki.
A_point = [-10; 10];
B_point = [10; -15];

x = [-20; -20];
y = [10; 10];
r = [20; 25];
d = r(2) - r(1);
th = 0:pi/50:2*pi;
% a = -0.25;

cvx_begin quiet
   variables x1(2) x2(2) a;
   minimize(norm(A_point - x1) + norm(B_point - x2));
%    minimize(norm(A_point - x1) + norm(B_point - x2) + norm(x2 - x1));
   subject to
        norm(x1 - x) <= r(1);   
        norm(x2 - x) <= r(2);
        norm(x2-x1) <= r(2) - r(1);
%         x1(2) == a * (x1(1) - x(1)) + y(1);
%         x2(2) == a * (x2(1) - x(1)) + y(1);
cvx_end

figure(2)
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
%% *_NIE ZNALAZ�EM SPOSOBU NA ROZWI�ZANIE_*
%
% * Nie uda�o mi si� znale�� sposobu na zapisanie ogranicze� :(*. Pr�by na
% wiele sposob�w zako�czy�y si� fiaskiem. Probowa�em wielu podej��, kt�re
% wykorzystuj� mi�dzy innymi:
% * znalezienie rodziny prostych przechodz�cych przez �rodek okr�gu rzeki,
% oraz zapewnienie ograniczenia, �e na tej prostej w odleg�o�ci R1 i R2 le��
% punkty zawieszenia mostu.
% * postawienia ograniczenia, �e dane punkty le�� na pierwszym i drugim
% okr�gu wraz z za�o�eniem, �e odleg�o�� tych dw�ch punkt�w wynosi R2 - R1
% * pr�by znalezienia okr�gu, kt�rego �rodek le�y na w/w prostej
% (zawieraj�cej punkty zawieszenia mostu), kt�rego �rodek le�y w odleg�o�ci
% R1+R2 od �rodka okr�gu wyj�ciowego (rysunek).
figure(3)
plot([x1(1), x2(1)], [x1(2), x2(2)]);