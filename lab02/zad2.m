clear all;
close all;
% plotting of ellipses (constraints)
fi = linspace(0, 2*pi, 100);
x_ball = [cos(fi); sin(fi)];    % unit ball
th = -pi/3; R60n = [cos(th) sin(th); -sin(th) cos(th)];  % pos. rotation
th = -pi/4; R45n = [cos(th) sin(th); -sin(th) cos(th)]; % neg. rotation
lam1 = [2; 1]; lam2 = [1 3];       % semiaxis length
xc1 = [0; 2]; xc2 = [-1; 2];     % ellipse centre

x_ball_r1 = R60n*diag(lam1)*x_ball + xc1*ones(1,size(x_ball,2));
x_ball_r2 = R45n*diag(lam2)*x_ball + xc2*ones(1,size(x_ball,2));

invP1 = inv(R60n*diag(lam1)*diag(lam1)*R60n');  % ellipse 1
invP2 = inv(R45n*diag(lam2)*diag(lam2)*R45n');  % ellipse 2

% second order penalty function
A = [2 1; 1 3]; f = [1; -1]; c = 2;
[XX, YY] = meshgrid(-2:0.1:2, -1:0.1:3);
ZZ = zeros(size(XX));

ZZ1 = zeros(size(XX));
for i = 1:size(XX,1),
    for j = 1:size(XX,2),
        z = [XX(i,j); YY(i,j)];
        if (((quad_form(z - xc1, invP1) <= 1) && (quad_form(z - xc2, invP2) <= 1))),
                ZZ1(i,j) = quad_form(z, A) + f'*z + c;
        else
                ZZ1(i,j) = nan;
        end;
    end;
end;
figure(1), contour(XX, YY, ZZ1), grid on;

%figure(4), contour(XX, YY, ZZ), grid on;
hold on
    plot(x_ball_r1(1,:), x_ball_r1(2,:), 'm--',...
         x_ball_r2(1,:), x_ball_r2(2,:), 'm--');
hold off
% cvx minimization QPQC
cvx_begin
    variable x(2);
    minimize (quad_form(x, A) + f'*x + c);
    subject to
        quad_form(x - xc1, invP1) <= 1;
        quad_form(x - xc2, invP2) <= 1;
cvx_end
min_val = cvx_optval;
x_min = x;
hold on
    plot(x_min(1),x_min(2),'ks');
hold off
disp(['minimization = ', num2str(min_val),...
    ' for ', num2str(x_min(1)), '  ', num2str(x_min(2))]);
