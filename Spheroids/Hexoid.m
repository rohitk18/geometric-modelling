clear all;
clc;

pts = 16;
u = linspace(0,1,pts);
bfn = [ (1-u).^2;...   % degree 2 BB functions  evaluated at n parameters u
       2*(1-u).*u;...
         u.^2];

x = [-2 -3 -2;...
      0 0 0;...
      2 3 2];
y = [-2 0 2;...
      -3 0 3;...
      -2 0 2];
z=[2 3 2;...
      3 7 3;...
      2 3 2];
X = bfn'*x*bfn;
Y = bfn'*y*bfn;
Z = bfn'*z*bfn;

grid on;
plot3(x,y,z); hold on;
plot3(x',y',z'); hold on;
plot3(x,y,-z); hold on;
plot3(x',y',-z'); hold on;
plot3(x,z,y); hold on;
plot3(x',z',y'); hold on;
plot3(x,-z,y); hold on;
plot3(x',-z',y'); hold on;
plot3(z,y,x); hold on;
plot3(z',y',x'); hold on;
plot3(-z,y,x); hold on;
plot3(-z',y',x'); hold on;

surf(X,Y,Z);
surf(X,Y,-Z);
surf(X,Z,Y);
surf(X,-Z,Y);
surf(Z,Y,X);
surf(-Z,Y,X);
title("Hexoid");
xlabel("X axis")
ylabel("Y axis")
zlabel("Z axis")

[K,n]=curvature(X,Y,Z);
nathalf = n(64,:);
kathalf = K(8,8);
disp(nathalf);
disp(kathalf);
quiver3(X(8,8),Y(8,8),Z(8,8),nathalf(1),nathalf(2),nathalf(3),100);


view(25,25)
%shading interp
lightangle(-45,30)
h.FaceLighting = 'gouraud';
h.AmbientStrength = 0.3;
h.DiffuseStrength = 0.8;
h.SpecularStrength = 0.9;
h.SpecularExponent = 25;
h.BackFaceLighting = 'unlit';