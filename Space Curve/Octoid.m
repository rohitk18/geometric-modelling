clear all;
clc;
pts = 16;
u = linspace(0,1,pts);
[U,V] = meshgrid(u,u);
W = 1-U-V;
%x = [0 0 0 0;
    %2 3 2 NaN;
    %3 3 NaN NaN;
    %3 NaN NaN NaN];
%y = [0 2 3 3;
 %   0 3 3 NaN;
  %  0 2 NaN NaN;
   % 0 NaN NaN NaN];
%z = [3 3 2 0;
 %    3 3 0 NaN;
  %   2 0 NaN NaN;
   %  0 NaN NaN NaN];
x = [0 0 0 0,2 3 2,3 3,3];
y = [0 2 3 3,0 3 3,0 2,0];
z = [3 3 2 0,3 3 0,2 0,0];

hold on
axis equal;
title("Octoid")
xlabel("X axis")
ylabel("Y axis")
zlabel("Z axis")


[Ax,Ay,Az] = get_XYZ(x,y,z,U,V,W);
[Bx,By,Bz] = get_XYZ(-x,y,z,U,V,W);
octoid_patch(x,y,z,Ax,Ay,Az);
octoid_patch(-x,y,z,Bx,By,Bz);
octoid_patch(-x,-y,z,-Ax,-Ay,Az);
octoid_patch(x,-y,z,-Bx,-By,Bz);
octoid_patch(x,y,-z,Ax,Ay,-Az);
octoid_patch(-x,y,-z,Bx,By,-Bz);
octoid_patch(-x,-y,-z,-Ax,-Ay,-Az);
octoid_patch(x,-y,-z,-Bx,-By,-Bz);

[K,n] = curvature(Ax,Ay,Az);
nathalf = n(65,:);
kathalf = K(8,8);
disp(nathalf);
disp(kathalf);
quiver3(Ax(8,8),Ay(8,8),Az(8,8),nathalf(1),nathalf(2),nathalf(3),100,'LineWidth',3,'Color','green');

view(25,25)
%shading interp
lightangle(-45,30)
h.FaceLighting = 'gouraud';
h.AmbientStrength = 0.3;
h.DiffuseStrength = 0.8;
h.SpecularStrength = 0.9;
h.SpecularExponent = 25;
h.BackFaceLighting = 'unlit';



function [X,Y,Z] = get_XYZ (x,y,z,U,V,W)
    X = x(1)*W.^3 + z(2)*3*W.^2.*U + x(3)*3*W.*U.^2 + x(4)*U.^3 + ...
        x(5)*3*W.^2.*V + x(6)*6*W.*U.*V + x(7)*3*U.^2.*V +...
        x(8)*3*W.*V.^2 + x(9)*3*U.*V.^2 +...
        x(10)*V.^3;
    X = X + flipud(triu(NaN * X,2));

    Y = y(1)*W.^3 + z(2)*3*W.^2.*U + y(3)*3*W.*U.^2 + y(4)*U.^3 + ...
        y(5)*3*W.^2.*V + y(6)*6*W.*U.*V + y(7)*3*U.^2.*V +...
        y(8)*3*W.*V.^2 + y(9)*3*U.*V.^2 +...
        y(10)*V.^3;
    Y = Y + flipud(triu(NaN * Y,2));

    Z = z(1)*W.^3 + z(2)*3*W.^2.*U + z(3)*3*W.*U.^2 + z(4)*U.^3 + ...
        z(5)*3*W.^2.*V + z(6)*6*W.*U.*V + z(7)*3*U.^2.*V +...
        z(8)*3*W.*V.^2 + z(9)*3*U.*V.^2 +...
        z(10)*V.^3;
    Z = Z + flipud(triu(NaN * Z,2));
end
function P = octoid_patch (x,y,z,X,Y,Z)
plot3(x(1:4),y(1:4),z(1:4)); hold on;
plot3(x(5:7),y(5:7),z(5:7)); hold on;
plot3(x(8:9),y(8:9),z(8:9)); hold on;
idx = [1 5 8 10];
plot3(x(idx),y(idx),z(idx)); hold on;
idx = [2 6 9];
plot3(x(idx),y(idx),z(idx)); hold on;
idx = [3 7];
plot3(x(idx),y(idx),z(idx)); hold on;
idx = [2 5];
plot3(x(idx),y(idx),z(idx)); hold on;
idx = [3 6 8];
plot3(x(idx),y(idx),z(idx)); hold on;
idx = [4 7 9 10];
plot3(x(idx),y(idx),z(idx)); hold on;

P = surf(X,Y,Z);

end
