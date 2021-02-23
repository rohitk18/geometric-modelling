function Bz = Bezier(C,t,deg)
    for j = 1:length(t)
        Bz(:,j) = [0;0;0];
        for i = 1:size(C,2)
            Bz(:,j) = Bz(:,j)+ C(:,i)*Bernstein(deg,i-1,t(j));
        end
    end
end
   

function Br = Bernstein(n,i,t)
    Br = (factorial(n)/(factorial(i)*factorial(n-i)))*(t^i)*((1-t)^(n-i));
end