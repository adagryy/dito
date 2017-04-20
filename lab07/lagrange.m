%% Laboratorium #7. Teoria optymalizacji.
% _Adam Gryczka_
%
% _03.04.2017_

% Czyszczê œrodowisko pracy
clear;

% Deklaracja zmiennych symbolicznych x a b c lam
syms x a b c lam;

% Funkcja celu
fo = x^2 + a;
 
% Ograniczenia równoœciowe
f1 =(b - x)*(c - x);

% Budujê Lagran¿jan
L = fo + lam*f1;
 
% Uporz¹dkowanie postaci Lagran¿janu
L = collect(L,x);
 
% Obliczam pochodn¹ Lagran¿janu
dldx = diff(L,x);
 
% Rozwi¹zujê równanie (pochodna przyrównana do zera) tak, by wyliczyæ "x".
xmin = solve(dldx == 0,x);
 
% Wstawiam wyliczony "x" do Lagran¿janu - funkcja dualna Lagrange'a
g = subs(L,x,xmin);
 
% Uproszczenie postaci algebraicznej
g = simplify(g);
 
% Pierwsza pochodna funkcji dualnej
g1 = diff(g, lam);
 
% Druga pochodna funkcji dualnej
g2 = simplify(diff(g1,lam));

% Podstawieniewartoœci liczbowych do wspó³czynników "a", "b" i "c" z wyra¿enia "g1"
g1s = subs(g1, {a,b,c},{1,2,4});
 
% Obliczenie mno¿nika Lagrange'a dla którego "g1s" przyjmuje minimum
lam_s = solve(g1s == 0, lam >= 0, lam);
 
% Wartoœæ optymalna Lagran¿janu (ze wzglêdu na parametr "lambda")
x_s = subs(xmin, {lam,b,c}, {lam_s, 2, 4});
 
% Rozwi¹zanie optymalne problemu pierwotnego    
p_s = subs(fo, {x, a},{x_s,1});

% Rozwi¹zanie optymalne problemu dualnego
d_s = subs(g,{lam,a,b,c},{lam_s, 1, 2, 4});

% ======================================================================
% Poni¿ej znajduje siê modu³ do rysowania wykresów i graficznej
% reprezentacji wyników
% Rysujemy wykres

% Podstawiam powy¿ej wyliczonej funkcji celu "fo" wartoœci liczbowe do 
% zmiennych symbolicznych
fos = subs(fo,a,1);
figure(1),ezplot(fos,[0,5]),grid on;

% Podstawiam powy¿ej wyliczonej dualnej Lagrange'a "g" wartoœci liczbowe do 
% zmiennych symbolicznych 
gs = subs(g,{a,b,c},{1,2,4});
figure(2),ezplot(gs,[0,5]),grid on;

% Analogiczne podstawienie do funkcji ograniczeñ równoœciowych
f1s = subs(f1,{b,c},{2,4});
figure(3),ezplot(f1s, fos, [1,3]),grid on;

% Rozwi¹zanie problemu z wykorzystaniem warunków KKT (Karush Kuhn Tucker)
dldxs = subs(dldx,{b,c},{2,4}); 
[xkkt,lamkkt]=solve(dldxs==0,lam*f1s==0,lam>=0,f1s<=0,[x,lam]);