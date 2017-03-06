A = [ -0.3 1; 4 1; 1.1 1];
b = [-6 -10 4]';

x_low = -15; x_high = 20;
y_low = (b - A(:,1)*x_low)./A(:,2);
y_high = (b - A(:,1)*x_high)./A(:,2);
n = size(A, 1);
X = [x_low; x_high]*ones(1, n);
Y = [y_low' ; y_high'];

figure(1), line(X,Y), grid;
axis([-15 25 -25 15]);

point1 = [5; 5];
point2 = [-5; 0];
point3 = [5; -10];
point_internal = [0; 0];

p1 = zeros(1, 3); p2 = zeros(1, 3); p3 = zeros(1, 3); p4 = zeros(1, 3);
p1 = (A(:,1) * point1(1) + A(:,2) * point1(2)) - b;
p2 = (A(:,1) * point2(1) + A(:,2) * point2(2)) - b;
p3 = (A(:,1) * point3(1) + A(:,2) * point3(2)) - b;
p4 = (A(:,1) * point_internal(1) + A(:,2) * point_internal(2)) - b;

hold on,
plot(point1(1),point1(2),'r*');
plot(point2(1),point2(2),'r*');
plot(point3(1),point3(2),'r*');
plot(point_internal(1),point_internal(2),'ro');
hold off

text = ['Punkt "point1" o wspó³rzêdnych ', num2str(point1(1)), ' i ', num2str(point1(2)), ':'];
disp(text);
disp(p1');
text = ['Punkt "point2" o wspó³rzêdnych ', num2str(point2(1)), ' i ', num2str(point2(2)), ':'];
disp(text);
disp(p2');
text = ['Punkt "point3" o wspó³rzêdnych ', num2str(point3(1)), ' i ', num2str(point3(2)), ':'];
disp(text);
disp(p3');
text = ['Punkt wewnêtrzny o wspó³rzêdnych ', num2str(point_internal(1)), ' i ', num2str(point_internal(2)), ':'];
disp(text);
disp(p4');