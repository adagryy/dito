% Czyszczenie �rodowiska 
clear

% Dane wej�ciowe
A=[.2, .1; .1, -0.4]; 
b=[.1, -0.4]';
% Podstawiam macierz jednostkow� potrzebn� do wyliczenia "x" w pochodnej
% Lagran�janu
I = eye(2);

% Obliczam parametry i rysuj� funkcj� dw�ch zmiennych:
% f(x) = x'*A*x + b'*x
[XX, YY] = meshgrid(-1.5:0.1:1.5, -1.5:0.1:1.5); % meshgrid tworzy siatk� dwuwymiarowych punkt�w do rysowania 
ZZ = zeros(size(XX));
for i = 1:size(XX,1),
    for j = 1:size(XX,2),
        x = [XX(i,j); YY(i,j)]; % Pobieram element (i,j) 
        ZZ(i,j) = x'*A*x + b'*x; % Licz� warto�� funkcji  
    end;
end;

fi = linspace(0, 2*pi, 100); 
x_ball = [cos(fi); sin(fi)];    % okr�g jednostkowy
th = pi/6; R30p = [cos(th) sin(th); -sin(th) cos(th)];  % pos. rotation
th = -pi/6; R30n = [cos(th) sin(th); -sin(th) cos(th)]; % neg. rotation
lam = [1; 1];       % d�ugo�� p�osi elips (1,1) - daj� okr�g
xc0 = [0; 0]; % �rodek okr�gu

x_ball_r0 = diag(lam)*x_ball + xc0*ones(1,size(x_ball,2)); % macierz punkt�w do przeniesienia na wykres

cvx_begin quiet sdp 
    variables t lambda;
    minimize t;
    
    subject to
        % Na mocy lematu Schur'a: (podstawiam za M = (A + lambda*I)
        [t-lambda b'; 
         b A+lambda*I]>=0
cvx_end 

% Obliczam warto�ci optymalne:
lam_s = lambda; % Argument problemu dualnego, dla kt�rego funkcja przyjmuje minimum
xs =  -(A+lam_s*I)^-1*b % Argument problemu pierwotnego, dla kt�rego znaleziono minimum
ps = xs'*A*xs + b'*xs % Warto�� optymalna problemu pierwotnego dla x = x_s
ds = -b'*(A+lam_s*I)^-1*b-lam_s % Warto�� optymalna problemu dualnego (lam = lam_s)

% Rysowanie wynik�w

% 1. Problem pierwotny - nierozwi�zany
% figure(1)
% mesh(ZZ);

% 2. Znaleziona warto�� optymalna - wykres
figure(2)
hold on 
figure(2), hold on; contour(XX, YY, ZZ, 30), grid on; % Kontur problemu pierwotnego
figure(2), plot(x_ball_r0(1,:), x_ball_r0(2,:)) % Funkcja ogranicze�
plot(xs(1),xs(2),'bx'); % Warto�� optymalna
axis equal