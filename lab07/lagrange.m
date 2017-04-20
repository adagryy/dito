%% Laboratorium #7. Teoria optymalizacji.
% _Adam Gryczka_
%
% _03.04.2017_

% Czyszcz� �rodowisko pracy
clear;

% Deklaracja zmiennych symbolicznych x a b c lam
syms x a b c lam;

% Funkcja celu
fo = x^2 + a;
 
% Ograniczenia r�wno�ciowe
f1 =(b - x)*(c - x);

% Buduj� Lagran�jan
L = fo + lam*f1;
 
% Uporz�dkowanie postaci Lagran�janu
L = collect(L,x);
 
% Obliczam pochodn� Lagran�janu
dldx = diff(L,x);
 
% Rozwi�zuj� r�wnanie (pochodna przyr�wnana do zera) tak, by wyliczy� "x".
xmin = solve(dldx == 0,x);
 
% Wstawiam wyliczony "x" do Lagran�janu - funkcja dualna Lagrange'a
g = subs(L,x,xmin);
 
% Uproszczenie postaci algebraicznej
g = simplify(g);
 
% Pierwsza pochodna funkcji dualnej
g1 = diff(g, lam);
 
% Druga pochodna funkcji dualnej
g2 = simplify(diff(g1,lam));

% Podstawieniewarto�ci liczbowych do wsp�czynnik�w "a", "b" i "c" z wyra�enia "g1"
g1s = subs(g1, {a,b,c},{1,2,4});
 
% Obliczenie mno�nika Lagrange'a dla kt�rego "g1s" przyjmuje minimum
lam_s = solve(g1s == 0, lam >= 0, lam);
 
% Warto�� optymalna Lagran�janu (ze wzgl�du na parametr "lambda")
x_s = subs(xmin, {lam,b,c}, {lam_s, 2, 4});
 
% Rozwi�zanie optymalne problemu pierwotnego    
p_s = subs(fo, {x, a},{x_s,1});

% Rozwi�zanie optymalne problemu dualnego
d_s = subs(g,{lam,a,b,c},{lam_s, 1, 2, 4});

% ======================================================================
% Poni�ej znajduje si� modu� do rysowania wykres�w i graficznej
% reprezentacji wynik�w
% Rysujemy wykres

% Podstawiam powy�ej wyliczonej funkcji celu "fo" warto�ci liczbowe do 
% zmiennych symbolicznych
fos = subs(fo,a,1);
figure(1),ezplot(fos,[0,5]),grid on;

% Podstawiam powy�ej wyliczonej dualnej Lagrange'a "g" warto�ci liczbowe do 
% zmiennych symbolicznych 
gs = subs(g,{a,b,c},{1,2,4});
figure(2),ezplot(gs,[0,5]),grid on;

% Analogiczne podstawienie do funkcji ogranicze� r�wno�ciowych
f1s = subs(f1,{b,c},{2,4});
figure(3),ezplot(f1s, fos, [1,3]),grid on;

% Rozwi�zanie problemu z wykorzystaniem warunk�w KKT (Karush Kuhn Tucker)
dldxs = subs(dldx,{b,c},{2,4}); 
[xkkt,lamkkt]=solve(dldxs==0,lam*f1s==0,lam>=0,f1s<=0,[x,lam]);