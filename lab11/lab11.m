%% Laboratorium #11. Teoria optymalizacji.
% _Adam Gryczka_
%
% _15.05.2017_

% data for power flow problem
n = 12; % total number of nodes
m = 18; % number of edges (transmission lines)
k = 4; % number of generators
rand('state',0);
Pmax = 1+4*rand(m,1)*1.208; % transmission line capacities
% Pmax(18,1)=0;
Gmax = [3; 2; 4; 7];  % maximum generator power
c    = [4; 8; 5; 3];  % supply generator costs
d    = 1+1.5*rand(n-k,1); % network power demands
% graph incidence matrix 
A = [ -1 -1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0 ;
       0  0 -1 -1  0  0  0  0  0  0  0  0  0  0  0  0  0  0 ;
       0  0  0  0  0  0  0  0  0 -1 -1  0  0  0  0  0  0  1 ;
       0  0  0  0  0  0 -1  0  0  0  0  0  0  0 -1  0 -1  0 ;
       1  0  0  0  1 -1  0  0  0  0  0  0  0  0  0  0  0  0 ;
       0  1  1  0 -1  0  1 -1  0  0  0  0  0  0  0  0  0  0 ;
       0  0  0  1  0  0  0  0 -1  1  0  0  0  0  0  0  0  0 ;
       0  0  0  0  0  0  0  1  1  0  0  0 -1  0  1  0  0  0 ;
       0  0  0  0  0  0  0  0  0  0  1 -1  0  0  0  0  0  0 ;
       0  0  0  0  0  0  0  0  0  0  0  1  1 -1  0  0  0  0 ;
       0  0  0  0  0  0  0  0  0  0  0  0  0  1  0  1  0  0 ;
       0  0  0  0  0  1  0  0  0  0  0  0  0  0  0 -1  1  0 ];

% the code below is not data for the problem
% it is used only to generate the network graph

% x-y coordinates
XY = [ ... % node x-y coordinates
 1.5 5.2;   % node 1
 4.9 5;     % node 2
 6.9 3.5;   % node 3
 1.9 3.5;   % node 4
 0.2 4.4;   % node 5
 3.2 4.8;   % node 6
 5.9 4.5;   % node 7
 3.9 3.6;   % node 8
 5.9 2.5;   % node 9
 3.9 3;     % node 10
 1.4 2.5;   % node 11
 0 3];      % node 12

% node adjacency matrix
Ad = -A*A';
Ad = Ad - diag(diag(Ad));

epsx = 0.05; epsy = 0.15; % text placing offset 

figure; 
% connect edges
gplot(Ad,XY,'-k'); hold on;

% label generator nodes
for j = 1:k
    plot(XY(j,1),XY(j,2),'rs',...
        'MarkerFaceColor','r',...
        'MarkerSize',12);
    text(XY(j,1)-eps,XY(j,2)+epsy,int2str(j),'FontSize',10);      
end

% label regular nodes 
for j = k+1:n
    plot(XY(j,1),XY(j,2),'.k',...
    'MarkerSize',15);
    text(XY(j,1)-eps,XY(j,2)+epsy,int2str(j),'FontSize',10);
end
axis off; hold off;
% print('-depsc','pwr_net.eps');

% Podpunkt 1

cvx_begin quiet
    variables g(4,1) p(m,1) % ca�kowita moc WSZYSTKICH generator�w 
    minimize (c'*g) % koszt generowania mocy
    subject to
        g>=0 % ka�dy generator generuje pr�d (dodatnio) a nie go pobiera (ujemnie)
        abs(Gmax)>= g % Ka�dy generator produkuje moc mniejsz� od swojej w�asnej mocy maksymalnej
        sum(g)==sum(d) % Suma mocy generowanych jest r�wna sumie mocy zu�ytych
        A*p == [-g;d] % Zbalansowane mocy na ka�dym w�le
cvx_end;
disp('Podpunkt - koszt optymalny 1:')
c'*g

disp('Macierz koszt�w generacji:')
c

disp('Macierz mocy generator�w:')
g

disp('Macierz mocy przep�ywaj�cych przez poszczeg�lne w�z�y:')
p

% Podpunkt 2

cvx_begin quiet
    variables p(m,m) g(4,1)
    minimize (c'*g) % Koszt generowania mocy
    subject to        
        g>=0  % ka�dy generator generuje pr�d (dodatnio) a nie go pobiera 
        Gmax>= g  % Ka�dy generator produkuje moc mniejsz� od swojej w�asnej mocy maksymalnej
        sum(g)==sum(d) % Suma mocy generowanych jest r�wna sumie mocy zu�ytych        
        for i = 1:m
            p(i,i)==0 % odci�cie danej magistrali
            A*p(:,i) == [-g;d] % Zbalansowane mocy na ka�dym w�le
            abs(p(:,i))<=Pmax  % Odci�cie linii zachowuje wymagany przedzia� mocy
        end
cvx_end;

disp('Podpunkt - koszt optymalny 1:')
c'*g

disp('Macierz koszt�w generacji:')
c

disp('Macierz mocy generator�w:')
g

disp('Macierz mocy przep�ywaj�cych przez poszczeg�lne w�z�y:')
p

%% Konkluzje
% Odci�cie dowolnej linii zwi�ksza og�lny koszt przesy�u energii pomi�dzy
% w�z�ami, co jest zgodne ze zdrowym rozs�dkiem. W zadaniu optymalizacji
% nie zostaj�zaburzone krytyczne warunki dzia�ania sieci, takie jak
% maksymalna moc generatora, czy maksymalna moc przesy�ana na danej linii.
% Takie rozwi�zanie pozwala zastosowa� optymalne tryby dzia�ania
% komponent�w sieci bez zb�dnego ich przeci��ania.


