function [xx,yy] = profiler(a,b)

% clear a b Org tta r ttaa I POL R 
% figure, imagesc(o)
% [a,b] = ginput(5);
% hold on, plot(a,b,'g*')
Org = mean([a,b]);
a = a - Org(1);
b = b - Org(2);
% plot(Org(1),Org(2),'ok')
[tta,r] = cart2pol(a,b);
[ttaa, I] = sort(tta);
POL = [ttaa,r(I)];
POL(end+1,1) = 2*pi+ POL(1,1);
POL(end,2) = POL(1,2);
Vec = POL(1,1):.1:POL(end,1);
R = interp1(POL(:,1),POL(:,2),Vec,'cubic');
% figure, polar(POL(:,1),POL(:,2),'*')
% hold on, polar(Vec,R,'g')
[xx,yy] = pol2cart(Vec,R);
xx = xx + Org(1);
yy = yy + Org(2);
% figure, imagesc(o)
% a = a + Org(1);
% b = b + Org(2);
% hold on, plot(a,b,'g*'), plot(xx,yy,'y')