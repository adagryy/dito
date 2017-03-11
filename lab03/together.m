%% Laboratorium #3 Teoria optymalizacji.
% Adam Gryczka 
%
% 06.03.2017

%% Okreœlanie wysokoœci rat po¿yczek - opis problemu
% Obliczenie wysokoœci raty po¿yczki polega na stworzeniu mechanizmu
% okreœlaj¹cego, ile nale¿y wp³aciæ pieniêdzy na poszczególne raty. Pod
% uwagê bierze siê iloœæ wszystkich rat, docelow¹ kwotê, jak¹ chcemy
% uzyskaæ po zadanej liczbie rat
% wysokoœæ oprocentowania oraz
% dodatkowe warunki, które zostan¹ omówione poni¿ej.

%% Sp³ata po¿yczki przy braku ograniczeñ dodatkowych. 
% Program wskazuje, i¿ najbardziej optymaln¹ opcj¹ jest sp³ata ca³oœci w
% pierwszej racie. Nastêpnie system oblicza, i¿ w celu utrzymania
% koñcowej kwoty na ¿¹danym poziomie konieczne jest wp³acenie jedynie
% odsetek powstaj¹cych w tym czasie:
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
title('Wykres wysokoœci d³ugu');
xlabel('Miesi¹c sp³aty');
ylabel('Wartoœæ d³ugu');
% Add a legend
legend('Wysokoœæ pozosta³ego d³ugu');

figure;
bar(u(1:N),'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
% Set the axis limits
axis([-1 13 0 13000]);
set(gca, 'XTick', 1:12);
% Add title and axis labels
title('Wykres wysokoœci sp³acanych rat');
xlabel('Miesi¹c sp³aty');
ylabel('Wartoœæ rat');
% Add a legend
legend('Wysokoœci rat');

%% Sp³ata po¿yczki przy za³o¿eniu, i¿ ka¿da rata jest mniejsza równa 1000z³ 
% W tym zestawieniu zak³adamy, i¿ ka¿da z rat jest mniejsza lub równa 1000z³
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
    u <= 1000 * ones(N,1) % rata mniejsza lub równa tysi¹c
    u >= 0;
cvx_end
figure;
bar(X(1:N+1),'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
% Set the axis limits
axis([-1 13 0 13000]);
set(gca, 'XTick', 1:12);
% Add title and axis labels
title('Wykres wysokoœci d³ugu');
xlabel('Miesi¹c sp³aty');
ylabel('Wartoœæ d³ugu');
% Add a legend
legend('Wysokoœæ pozosta³ego d³ugu');

figure;
bar(u(1:N),'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
% Set the axis limits
axis([-1 13 0 13000]);
set(gca, 'XTick', 1:12);
% Add title and axis labels
title('Wykres wysokoœci sp³acanych rat');
xlabel('Miesi¹c sp³aty');
ylabel('Wartoœæ rat');
% Add a legend
legend('Wysokoœci rat');

%% Z góry ustalona wysokoœæ raty
% W tym przypadku narzucamy ograniczenie, i¿ dwie raty s¹ o pewnej
% wysokoœci:

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

% Opis, jak siê robi taki wykres
% http://au.mathworks.com/matlabcentral/fileexchange/35271-matlab-plot-gallery-vertical-bar-plot/content/html/Vertical_Bar_Plot.html
figure;
bar(X(1:N+1),'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
% Set the axis limits
axis([-1 13 0 13000]);
set(gca, 'XTick', 1:12);
% Add title and axis labels
title('Wykres wysokoœci d³ugu');
xlabel('Miesi¹c sp³aty');
ylabel('Wartoœæ d³ugu');
% Add a legend
legend('Wysokoœæ pozosta³ego d³ugu');

figure;
bar(u(1:N),'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
% Set the axis limits
axis([-1 13 0 13000]);
set(gca, 'XTick', 1:12);
% Add title and axis labels
title('Wykres wysokoœci sp³acanych rat');
xlabel('Miesi¹c sp³aty');
ylabel('Wartoœæ rat');
% Add a legend
legend('Wysokoœci rat');

%% Raty sta³ej wysokoœci
% Wszystkie raty s¹ tej samej wysokoœci, z uwzglêdnieniem sytuacji z
% poprzedniego podrozdzia³u, gdzie dwie raty posiadaj¹ z góry narzucon¹
% wysokoœæ:
a=1.02;
b=-1;
x0 = 10000;
xdes = 2000;
N=10;
cvx_begin quiet
    variables u(N) X(N+1); % u - rata kolejna, X(N + 1) - stan nastêpny
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
title('Wykres wysokoœci d³ugu');
xlabel('Miesi¹c sp³aty');
ylabel('Wartoœæ d³ugu');
% Add a legend
legend('Wysokoœæ pozosta³ego d³ugu');

figure;
bar(u(1:N),'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
% Set the axis limits
axis([-1 13 0 13000]);
set(gca, 'XTick', 1:12);
% Add title and axis labels
title('Wykres wysokoœci sp³acanych rat');
xlabel('Miesi¹c sp³aty');
ylabel('Wartoœæ rat');
% Add a legend
legend('Wysokoœci rat');
