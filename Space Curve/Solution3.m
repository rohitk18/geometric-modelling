%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%SPACE CURVE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
clc;
%% Given data
%% Two curves of degree 3
deg=3;

%% start point
c10 = [1;1;1];

%% end point
c23 = c10;

%% start derivative
s1 = [3;0;0];

%% end derivative
e2 = [0;-3;0];

%% start second derivative
s2 = [6;0;-6];

%% Finding point c11 using s1
c11 = (s1/deg)+c10;

%% Finding point c22 using e2
c22 = c23-(e2/deg);

%% Finding point c12 using s2
c12 = (s2/(deg*(deg-1)))-c10+2.*c11;

%% Points present c10, c11, c12, c22, c23
%% Points still needed c13, c20, c21
%% Since curve is as smooth as possible

%% Solving c21
%% c11-2*c12+c13 = c22-2*c21+c20; c13=c20;
c21 = (c22+(2.*c12)-c11)./2;

%% Solving c13
c13 = (c12+c21)./2;
c20 = c13;

%% Control Points
CP1 = [c10 c11 c12 c13];
CP2 = [c20 c21 c22 c23];

%% parameter t
t = linspace(0,1,100);

%% Collection of all points on the curves for plotting
P1 = Bezier(CP1,t,deg);
P2 = Bezier(CP2,t,deg);
P = [P1,P2];

%% frenet calculation
[Tan Norm Bin cur tor] = frenet(P(1,:),P(2,:),P(3,:));


%% 3d plots of points collection
%hold on
%grid on
%plot3(P1(1,:),P1(2,:),P1(3,:),'Linewidth',2);
%plot3(P2(1,:),P2(2,:),P2(3,:),'Linewidth',2);
%title("Space Curve");
%plot3(P(1,100),P(2,100),P(3,100),'x','MarkerSize',20,'Color','black');
%quiver3(P(1,100),P(2,100),P(3,100),Tan(100,1),Tan(100,2),Tan(100,3),'Color','red');
%quiver3(P(1,100),P(2,100),P(3,100),Norm(100,1),Norm(100,2),Norm(100,3),'Color','green');
%quiver3(P(1,100),P(2,100),P(3,100),Bin(100,1),Bin(100,2),Bin(100,3),'Color','blue');
%axis equal
for f=1:size(Tan,1)
  clf;
  hold on
  grid on
  plot3(P(1,f),P(2,f),P(3,f),'x','MarkerSize',20,'Color','black');
  quiver3(P(1,f),P(2,f),P(3,f),Tan(f,1),Tan(f,2),Tan(f,3),'Color','red');
  quiver3(P(1,f),P(2,f),P(3,f),Norm(f,1),Norm(f,2),Norm(f,3),'Color','green');
  quiver3(P(1,f),P(2,f),P(3,f),Bin(f,1),Bin(f,2),Bin(f,3),'Color','blue');
  
  
  plot3(P1(1,:),P1(2,:),P1(3,:),'Linewidth',2);
  plot3(P2(1,:),P2(2,:),P2(3,:),'Linewidth',2);
  title("Space Curve");
  plot3(P(1,100),P(2,100),P(3,100),'x','MarkerSize',20,'Color','black');
  quiver3(P(1,100),P(2,100),P(3,100),Tan(100,1),Tan(100,2),Tan(100,3),'Color','red');
  quiver3(P(1,100),P(2,100),P(3,100),Norm(100,1),Norm(100,2),Norm(100,3),'Color','green');
  quiver3(P(1,100),P(2,100),P(3,100),Bin(100,1),Bin(100,2),Bin(100,3),'Color','blue');
  showpoints(CP1,1);
  showpoints(CP2,2);
  showpolygon(CP1);
  showpolygon(CP2);
  axis equal
  
  drawnow
  hold off
end


%% function to show points
function showpoints (points,curve)
    num_points = size(points, 2);
    for i = 1 : num_points
        x = points(1,i);
        y = points(2,i);
        z = points(3,i);
        m = line(x,y,z);
        m.Marker = '.';
        m = text(x, y, z, strcat('c',num2str(curve), num2str(i-1)));
        m.HorizontalAlignment = 'center';
        m.VerticalAlignment = 'bottom';
    end
end

%% function to show the control polygon
function showpolygon (points)
    num_points = size(points, 2);
    for i = 1:num_points-1
        x = points(1,i:i+1);
        y = points(2,i:i+1);
        z = points(3,i:i+1);
        l = line(x,y,z,'Color','red');
    end
    l_end = line(points(1,[4 1]),points(2,[4 1]),points(3,[4 1]),'Color','red');
end