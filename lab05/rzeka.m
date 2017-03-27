%% Laboratorium #3. Teoria optymalizacji.
% _Adam Gryczka_
%
% _20.03.2017_

%% Program do obliczania optymalnej trasy przejazdu, przy za³o¿eniu koniecznoœci przekroczenia rzeki.
% Program optymalizuje trasê przejazdu z przekroczeniem rzeki mostem
% zbudowanym pod k¹tem prostym. Poni¿ej przedstawiono kod programu
% zaimplementowany w œrodowisku CVX:
clear;
close all;
cvx_clear;

% Punkty bêd¹ce pocz¹tkiem i celem trasy
A_point = [-1; 2];
B_point = [0; -3];
% wspó³czynniki b prostych tworz¹cych brzegi rzeki
b1 = 2.5;
b2 = -1.5;
% wspó³czynnik kierunkowy prostych tworz¹cych brzegi rzeki
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
% Powy¿szy rysunek przedstawia mapê przejazdu pomiêdzy punktami.

%% Realizacja optymalizacji przy za³o¿eniu rzeki o kszta³cie nieliniowym
% Optymalizacja zak³ada, i¿ rzeka jest w kszta³cie okrêgu. Nale¿y znaleŸæ
% najkrótsz¹ trasê pomiêdzy dwoma punktami le¿¹cymi po dwóch ró¿nych
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
%% *_NIE ZNALAZ£EM SPOSOBU NA ROZWI¥ZANIE_*
%
% * Nie uda³o mi siê znaleŸæ sposobu na zapisanie ograniczeñ :(*. Próby na
% wiele sposobów zakoñczy³y siê fiaskiem. Probowa³em wielu podejœæ, które
% wykorzystuj¹ miêdzy innymi:
% * znalezienie rodziny prostych przechodz¹cych przez œrodek okrêgu rzeki,
% oraz zapewnienie ograniczenia, ¿e na tej prostej w odleg³oœci R1 i R2 le¿¹
% punkty zawieszenia mostu.
% * postawienia ograniczenia, ¿e dane punkty le¿¹ na pierwszym i drugim
% okrêgu wraz z za³o¿eniem, ¿e odleg³oœæ tych dwóch punktów wynosi R2 - R1
% * próby znalezienia okrêgu, którego œrodek le¿y na w/w prostej
% (zawieraj¹cej punkty zawieszenia mostu), którego œrodek le¿y w odleg³oœci
% R1+R2 od œrodka okrêgu wyjœciowego (rysunek).
figure(3)
plot([x1(1), x2(1)], [x1(2), x2(2)]);