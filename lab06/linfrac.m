%% Laboratorium #6. Teoria optymalizacji.
% _Adam Gryczka_
%
% _27.03.2017_

%% Program do minimalizacji funkcji liniowo u�amkowej
% Poni�ej zosta�o przedstawione rozwi�zanie problemu minimalizacji funkcji
% liniowo-u�amkowej. W ca�kowitym rozwi�zaniu zawarto rozwi�zanie zadania
% minimalizacji na cztery r�ne sposoby: graficznie poprzez wyrysowanie w
% przestrzeni 3D wykresu funkcji za pomoc� funkcji *mesh*, graficznie poprzez
% wykorzystanie funkcji *contour*, analitycznie poprzez przekszta�cenie
% problemu liniowo-u�amkowego do problemu liniowego oraz analitycznie
% porzez przekszta�cenie do problemu quasi-wypuk�ego.

%% Funkcja _mesh_
% Rozwi�zanie pierwsze: rysujemy funkcj� w przestrzeni 3D:
clear;
close all;
cvx_clear;

c = [1; -1];
d = -1;

e = [1; 1];
f = -1;

x1_min = 2;
x1_max = 3;

x2_min = 1.5;
x2_max = 4.5;

% x1 = 1.1:0.1:5;
% x2 = x1;
% x = [x1;x2];
A = [0 0];
b = [0.1]';
[XX, YY] = meshgrid(1.1:0.1:5);

for i = 1:size(XX,1),
    for j = 1:size(XX,2),
        xx = XX(i,j); yy = YY(i,j);
        ZZ(i,j) = (c'*[xx; yy] + d)/(e'*[xx; yy] + f); 
        ZZZ(i,j) = A*[xx; yy] + b;
    end;
end;

cvx_begin quiet
    variables y z;
    minimize(sum(c' * y + d * z))
    subject to
        A*y <= b * z;        
        e'*y + f * z == 1;
        z >= 0;
%         c'*x + d > 0;
%         y <= 2;
        
%         y == (1/(e'*x + f)) * x;
%         z == (1/(e'*x + f));
cvx_end
w = (1/z) * y;
figure(1) 
grid;
% hold on 
mesh(XX, YY, ZZ)
% mesh(XX, YY, ZZZ)
% hold off

%% Funkcja _contour_
% Rozwi�zanie metod� drug�: narysowanie jedynie konturu funkcji w
% przestrzeni 2D wraz z uwzgl�dnieniem ogranicze�:
figure(2) 
grid;
hold on 
contour(XX, YY, ZZ)
line([x1_min; x1_max], [x2_max; x2_max]);
line([x1_min; x1_max], [x2_min; x2_min]);
line([x1_min; x1_min], [x2_min; x2_max]);
line([x1_max; x1_max], [x2_min; x2_max]);

% A = [ 5 5; 0 0];
% b = [ 4 10]';
% 
% xu = [0.2;1];
% 
% wt = A*xu - b;
% plot(wt)
% axis([-20 20 -20 20]);

% cvx_begin quiet
%     variables x(2);
%     minimize((c'*x + d)/(e'*x + f));
%     subject to
%         x(1) <= 2;
%         x(1) <= 3;
% cvx_end

%% Rozwi�zanie problemu jako zadania programowania liniowego
% --

%% Rozwi�zanie problemu jako zadania quasi-wypuk�ego
% --