function [theta, rho, fac, mini]=RTmethod(perimeter,centroid,interp)
% Perimeter array 2D
perimeter(:,2)=perimeter(:,2)-centroid(1);
perimeter(:,1)=perimeter(:,1)-centroid(2);
[theta,rho] = cart2pol(perimeter(:,2),perimeter(:,1));
mini=min(rho);

%%%%% Equally spaced sampling
dth=linspace(-pi,pi,size(perimeter,1));
rhoe=zeros(size(dth));
for j=1:size(perimeter,1)
    resta=abs(theta-dth(j));
    [~,k]=sort(resta);
    rhoe(j)=mean([rho(k(1)),rho(k(2)),rho(k(3))]);
end
if interp==1
    %%% Interpolation
    theta=linspace(-pi,pi,512);
    rho=interp1(dth,rhoe, theta,'linear', 'extrap');
else
    rho=rhoe;
    theta=dth;
end
%%%% Unit
fac=max(rho);
rho=rho/max(rho);