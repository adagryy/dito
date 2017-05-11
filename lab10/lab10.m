%% Laboratorium #9. Teoria optymalizacji.
% _Adam Gryczka_
%
% _08.05.2017_

%%
% Poni¿szy program s³u¿y do rozwi¹zywania problemów geometrycznych.

%% Dokument zawiera rozwi¹zanie 11 zadañ na dwa sposoby

%% Zadanie 1
% total_len = 2400;
% cvx_begin gp
%     variables x y 
%     maximize x*y
%     subject to 
%         2*x + y <= total_len;
% cvx_end
%     
% cvx_begin
%     variables logx logy
%     maximize(logx + logy)
%     subject to 
%         log(2*exp(logx) + exp(logy)) <= log(total_len);
% cvx_end
% x
% y
% exp(logx)
% exp(logy)

%% Zadanie 2
% total_len = 500;
% cvx_begin gp
%     variables x y 
%     maximize x*y
%     subject to 
%         x + 2 * y <= total_len;
% cvx_end
% 
% cvx_begin
%     variables logx logy
%     maximize(logx + logy)
%     subject to 
%         log(2*exp(logy) + exp(logx)) <= log(total_len);
% cvx_end
% x
% y
% exp(logx)
% exp(logy)

%% Zadanie 3
% total_vol = 50;
% cvx_begin gp quiet
%     variables h w 
%     minimize( 60*w*w + 48 * w * h )
%     subject to 
%         3*w*w*h == total_vol
% cvx_end
% w
% h
% 
% % 2 czêœæ
% total_vol = 50;
% cvx_begin quiet
%     variables logh logw 
%     minimize( 60*exp(logw)*exp(logw) + 48*exp(logw)*exp(logh) )
%     subject to 
%          log(3)+2*logw + logh == log(total_vol)  
% cvx_end
% 
% cvx_optval
% exp(logw)
% exp(logh)

%% Zadanie 4
% 
% % 1 wersja
% clear all;
% total_material = 10;
% 
% cvx_begin gp quiet
%     variables w h
%     maximize w^2*h
%     subject to
%         2*w^2+4*w*h <= total_material;
% cvx_end
% 
% disp(w);
% disp(h);
% 
% % 2 wersja
% 
% cvx_begin quiet
%     variables logw logh
%     maximize log(exp(logw)^2*exp(logh))
%     subject to
%         log(2*exp(logw)^2+4*exp(logw)*exp(logh)) <= log(total_material);
% cvx_end
% exp(logw)
% exp(logh)

%% Zadanie 5
% % 1 wersja
% clear all;
% total_amount = 1500;
% 
% cvx_begin gp quiet
%     variables r h
%     minimize 2*pi()*r^2 + 2*pi()*r*h
%     subject to
%         pi()*r^2*h == total_amount;
% cvx_end
% 
% disp(r);
% disp(h);
% 
% cvx_begin quiet
%     variables logr logh
%     minimize (2*pi()*exp(logr)^2+2*pi()*exp(logr)*exp(logh))
%     subject to
%         log(pi()*exp(logr)^2*exp(logh)) == log(total_amount)
% cvx_end
% 
% disp(exp(logr));
% disp(exp(logh));

%% Zadanie 6 - NIE DZIA£A!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% cvx_begin gp quiet
%     variables h
%     maximize( 140*h-48*h^2+4*h^3 )
%     subject to 
%         h >= 0
% cvx_end
% h

%% Zadanie 7
% surface = 200;
% cvx_begin gp quiet
%     variables w h
%     maximize( 207-3.5*w-400/w )
%     subject to 
%         w*h == surface
%         w >= 2;
%         w <= 200/3.5
% cvx_end
% w
% h
% 
% % 2 sposób
% surface = 200;
% cvx_begin quiet
%     variables logw logh
%     maximize( 207-3.5*exp(logw)-400/exp(logw) )
%     subject to 
%         logw+logh == log(surface)
%         logw >= log(2);
%         logw <= log(200/3.5)
% cvx_end
% exp(logw)
% exp(logh)

%% Zadanie 8 - NIE DZIA£A!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% cvx_begin gp quiet
%     variables r h
%     maximize(12-(4+pi)*r)
%     %12*r - (2 + 0.5 * pi)*r^2)
%     subject to 
% %         2*h+2*r+pi*r <= 12
%         r>=0
%         r<=12/(2+pi)
% cvx_end
% r
% h

%% Zadanie 9 - NIE DZIA£A!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% cvx_begin quiet
%     variables u v
%     maximize( 256*v-16*v*v )
%     subject to 
%         u + v == 16
% cvx_end
% u 
% v
% x
% 
%% Zadanie 10 - NIE DZIA£A!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% cvx_begin gp quiet
%     variables x y
%     maximize( x^2 + (y-2)^2 )
%     subject to 
%         y == x^2+1
% cvx_end
% w
% h

%% Zadanie 11 - NIE DZIA£A!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% cvx_begin gp quiet
%     variables x 
%     minimize( sqrt(x^2 + 9) )
%     subject to 
%         x/(6*sqrt(x^2+9))-1/8 == 0
% cvx_end
% x