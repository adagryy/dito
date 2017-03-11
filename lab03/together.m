%% Laboratorium #3 Teoria optymalizacji.
% Adam Gryczka 
%
% 06.03.2017

%% Okre�lanie wysoko�ci rat po�yczek - opis problemu
% Obliczenie wysoko�ci raty po�yczki polega na stworzeniu mechanizmu
% okre�laj�cego, ile nale�y wp�aci� pieni�dzy na poszczeg�lne raty. Pod
% uwag� bierze si� ilo�� wszystkich rat, docelow� kwot�, jak� chcemy
% uzyska� po zadanej liczbie rat
% wysoko�� oprocentowania oraz
% dodatkowe warunki, kt�re zostan� om�wione poni�ej.

%% Sp�ata po�yczki przy braku ogranicze� dodatkowych. 
% Program wskazuje, i� najbardziej optymaln� opcj� jest sp�ata ca�o�ci w
% pierwszej racie. Nast�pnie system oblicza, i� w celu utrzymania
% ko�cowej kwoty na ��danym poziomie konieczne jest wp�acenie jedynie
% odsetek powstaj�cych w tym czasie:
cvx_solver('sdpt3');
a=1.02;
b=-1;
x0 = 10000;
xdes = 2000;
N=10;
cvx_begin quiet
    variables u(N) X(N+1);
    minimize(sum(X));
    subject to
    X(2:N+1)==a*X(1:N)+b*u; % u - rata?
    X(1)==x0;
    X(N+1) == xdes;
    X(2:N+1) <= X(1:N)
    u >= 0;
cvx_end

figure;
bar(X(1:N+1),'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
% Set the axis limits
axis([-1 13 0 13000]);
set(gca, 'XTick', 1:12);
% Add title and axis labels
title('Wykres wysoko�ci d�ugu');
xlabel('Miesi�c sp�aty');
ylabel('Warto�� d�ugu');
% Add a legend
legend('Wysoko�� pozosta�ego d�ugu');

figure;
bar(u(1:N),'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
% Set the axis limits
axis([-1 13 0 13000]);
set(gca, 'XTick', 1:12);
% Add title and axis labels
title('Wykres wysoko�ci sp�acanych rat');
xlabel('Miesi�c sp�aty');
ylabel('Warto�� rat');
% Add a legend
legend('Wysoko�ci rat');

%% Sp�ata po�yczki przy za�o�eniu, i� ka�da rata jest mniejsza r�wna 1000z� 
% W tym zestawieniu zak�adamy, i� ka�da z rat jest mniejsza lub r�wna 1000z�
a=1.02;
b=-1;
x0 = 10000;
xdes = 2000;
N=10;
cvx_begin quiet
    variables u(N) X(N+1);
    minimize(sum(X));
    subject to
    X(2:N+1)==a*X(1:N)+b*u;
    X(1)==x0;
    X(N+1) == xdes;
    X(2:N+1) <= X(1:N)
    u <= 1000 * ones(N,1) % rata mniejsza lub r�wna tysi�c
    u >= 0;
cvx_end
figure;
bar(X(1:N+1),'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
% Set the axis limits
axis([-1 13 0 13000]);
set(gca, 'XTick', 1:12);
% Add title and axis labels
title('Wykres wysoko�ci d�ugu');
xlabel('Miesi�c sp�aty');
ylabel('Warto�� d�ugu');
% Add a legend
legend('Wysoko�� pozosta�ego d�ugu');

figure;
bar(u(1:N),'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
% Set the axis limits
axis([-1 13 0 13000]);
set(gca, 'XTick', 1:12);
% Add title and axis labels
title('Wykres wysoko�ci sp�acanych rat');
xlabel('Miesi�c sp�aty');
ylabel('Warto�� rat');
% Add a legend
legend('Wysoko�ci rat');

%% Z g�ry ustalona wysoko�� raty
% W tym przypadku narzucamy ograniczenie, i� dwie raty s� o pewnej
% wysoko�ci:

a=1.02;
b=-1;
x0 = 10000;
xdes = 2000;
N=10;
cvx_begin quiet
    variables u(N) X(N+1);
    minimize(sum(X));
    subject to
    X(2:N+1)==a*X(1:N)+b*u;
    X(1)==x0;
    X(N+1) == xdes;
    u(5) == 500;
    u(6) == 500;
    X(2:N+1) <= X(1:N)
    u <= 1100 * ones(N,1)
    u >= 0;
cvx_end

% Opis, jak si� robi taki wykres
% http://au.mathworks.com/matlabcentral/fileexchange/35271-matlab-plot-gallery-vertical-bar-plot/content/html/Vertical_Bar_Plot.html
figure;
bar(X(1:N+1),'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
% Set the axis limits
axis([-1 13 0 13000]);
set(gca, 'XTick', 1:12);
% Add title and axis labels
title('Wykres wysoko�ci d�ugu');
xlabel('Miesi�c sp�aty');
ylabel('Warto�� d�ugu');
% Add a legend
legend('Wysoko�� pozosta�ego d�ugu');

figure;
bar(u(1:N),'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
% Set the axis limits
axis([-1 13 0 13000]);
set(gca, 'XTick', 1:12);
% Add title and axis labels
title('Wykres wysoko�ci sp�acanych rat');
xlabel('Miesi�c sp�aty');
ylabel('Warto�� rat');
% Add a legend
legend('Wysoko�ci rat');

%% Raty sta�ej wysoko�ci
% Wszystkie raty s� tej samej wysoko�ci, z uwzgl�dnieniem sytuacji z
% poprzedniego podrozdzia�u, gdzie dwie raty posiadaj� z g�ry narzucon�
% wysoko��:
a=1.02;
b=-1;
x0 = 10000;
xdes = 2000;
N=10;
cvx_begin quiet
    variables u(N) X(N+1); % u - rata kolejna, X(N + 1) - stan nast�pny
    minimize(sum(X));
    subject to
    X(2:N+1) == a*X(1:N)+b*u;
    X(1) == x0;
    X(N+1) == xdes;
    for it = 1 : 3
        u(it) == u(it + 1)
    end
    u(5) == 500;
    u(6) == 500;
    u(4) == u(7);
    for it = 7 : 9
        u(it) == u(it + 1)
    end
    X(2:N+1) <= X(1:N)
    u <= 1100 * ones(N,1)
    u >= 0;
cvx_end
figure;
bar(X(1:N+1),'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
% Set the axis limits
axis([-1 13 0 13000]);
set(gca, 'XTick', 1:12);
% Add title and axis labels
title('Wykres wysoko�ci d�ugu');
xlabel('Miesi�c sp�aty');
ylabel('Warto�� d�ugu');
% Add a legend
legend('Wysoko�� pozosta�ego d�ugu');

figure;
bar(u(1:N),'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
% Set the axis limits
axis([-1 13 0 13000]);
set(gca, 'XTick', 1:12);
% Add title and axis labels
title('Wykres wysoko�ci sp�acanych rat');
xlabel('Miesi�c sp�aty');
ylabel('Warto�� rat');
% Add a legend
legend('Wysoko�ci rat');
