%% Laboratorium #9. Teoria optymalizacji.
% _Adam Gryczka_
%
% _24.04.2017_

%%
% Poni¿szy program s³u¿y do znalezienia punktu Ÿród³a dŸwiêku na podstawie
% danych pochodz¹cych z mikrofonów rozmieszczonych w terenie.
clear all

y1 = [1.8, 2.5];
y2 = [2.0, 1.7]; 
y3 = [1.5, 1.5];
y4 = [1.5, 2.0];
y5 = [2.5, 1.5];

y=[y1;y2;y3;y4;y5];
d = [2.0, 1.24, 0.59, 1.31, 1.44];

[XX, YY] = meshgrid(0.3:0.1:3, .5:0.1:3);
ZZ = zeros(size(XX));
ZZZ = zeros(size(XX));
for i = 1:size(XX,1),
    for j = 1:size(XX,2),
        x = [XX(i,j); YY(i,j)];
        for it = 1 : 5,
            ZZ(i,j) = ZZ(i,j) + ((norm(x - y(it,:)'))^2 - d(it)^2)^2;
        end;   
    end;
end;
 %% Przekszta³cenie do postaci standardowej
 % Po przekszta³ceniu wyjœciowej postaci problemu do postaci standardowej otrzymujemy nastêpuj¹ce parametry równania:
 % *x'*A'*A*x-2*b'*A*x+b'*b*
 % Subject to
 %      *x'*c*x + 2*f'*x = 0*
 A=[ -2*y(1,:) 1
     -2*y(2,:) 1
     -2*y(3,:) 1
     -2*y(4,:) 1
     -2*y(5,:) 1
     ];

 B=[ y(1,:)*y(1,:)' - d(1)
     y(2,:)*y(2,:)' - d(2)
     y(3,:)*y(3,:)' - d(3)
     y(4,:)*y(4,:)' - d(4)
     y(5,:)*y(5,:)' - d(5)];

c=[ 1 0 0
    0 1 0
    0 0 0];

f=[0
   0
   -0.5];

%% Zadanie dualne
% Lemat Shura
cvx_begin sdp quiet
    variables t ni;
    maximize( t );
    subject to
         [(norm(B))^2 - t (A'*B-ni*f)'
          A'*B-ni*f A'*A+ni*c          ] >= 0 
cvx_end
    
M=(A'*A+ni*c);
k = A'*B-ni*f;
xs =  -M^-1*k; % Argument problemu pierwotnego dla którego znaleziono minimum
ps = xs'*xs - t
ds = k'*M^-1*k+(norm(B))^2

contour(XX, YY, ZZ, 60), grid on;
hold on
for it = 1 : size(y, 1),
 plot(y(it, 1), y(it, 2), 'r*');
end
text(xs(1)+0.05, xs(2),'Pozycja obiektu')
plot(xs(1), xs(2), 'ks');% Pozycja obiektu na wykresie

%% 
% Powy¿szy rysunek przedstawia pozycjê obiektu wykrytego przez system
% (punkt optymalny).
