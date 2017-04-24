% Czyszczenie œrodowiska 
clear

% Dane wejœciowe
A=[.2, .1; .1, -0.4]; 
b=[.1, -0.4]';
% Podstawiam macierz jednostkow¹ potrzebn¹ do wyliczenia "x" w pochodnej
% Lagran¿janu
I = eye(2);

% Obliczam parametry i rysujê funkcjê dwóch zmiennych:
% f(x) = x'*A*x + b'*x
[XX, YY] = meshgrid(-1.5:0.1:1.5, -1.5:0.1:1.5); % meshgrid tworzy siatkê dwuwymiarowych punktów do rysowania 
ZZ = zeros(size(XX));
for i = 1:size(XX,1),
    for j = 1:size(XX,2),
        x = [XX(i,j); YY(i,j)]; % Pobieram element (i,j) 
        ZZ(i,j) = x'*A*x + b'*x; % Liczê wartoœæ funkcji  
    end;
end;

fi = linspace(0, 2*pi, 100); 
x_ball = [cos(fi); sin(fi)];    % okr¹g jednostkowy
th = pi/6; R30p = [cos(th) sin(th); -sin(th) cos(th)];  % pos. rotation
th = -pi/6; R30n = [cos(th) sin(th); -sin(th) cos(th)]; % neg. rotation
lam = [1; 1];       % d³ugoœæ pó³osi elips (1,1) - daj¹ okr¹g
xc0 = [0; 0]; % œrodek okrêgu

x_ball_r0 = diag(lam)*x_ball + xc0*ones(1,size(x_ball,2)); % macierz punktów do przeniesienia na wykres

cvx_begin quiet sdp 
    variables t lambda;
    minimize t;
    
    subject to
        % Na mocy lematu Schur'a: (podstawiam za M = (A + lambda*I)
        [t-lambda b'; 
         b A+lambda*I]>=0
cvx_end 

% Obliczam wartoœci optymalne:
lam_s = lambda; % Argument problemu dualnego, dla którego funkcja przyjmuje minimum
xs =  -(A+lam_s*I)^-1*b % Argument problemu pierwotnego, dla którego znaleziono minimum
ps = xs'*A*xs + b'*xs % Wartoœæ optymalna problemu pierwotnego dla x = x_s
ds = -b'*(A+lam_s*I)^-1*b-lam_s % Wartoœæ optymalna problemu dualnego (lam = lam_s)

% Rysowanie wyników

% 1. Problem pierwotny - nierozwi¹zany
% figure(1)
% mesh(ZZ);

% 2. Znaleziona wartoœæ optymalna - wykres
figure(2)
hold on 
figure(2), hold on; contour(XX, YY, ZZ, 30), grid on; % Kontur problemu pierwotnego
figure(2), plot(x_ball_r0(1,:), x_ball_r0(2,:)) % Funkcja ograniczeñ
plot(xs(1),xs(2),'bx'); % Wartoœæ optymalna
axis equal