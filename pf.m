clear
clc
m=exnl('pfex');
m.f=inline('x(1,:)/2+25*x(1,:)./(1+x(1,:).^2)+8*cos(1.2*t)', 't', 'x','a','b');
z=simulate(m,1000);
mpf=m;mpf.pe=10* cov(m.pe);
zekf=ekf(m,z);zpf=pf(mpf ,z,'k',1);
subplot(121);
zekf.name='EKF';
zpf.name='PF';
xplot(z,zekf,'conf',90,'view','cont')
subplot(122);
xplot(z,zpf,'conf',90,'view','cont')
MSE_EKF=mean((z.y-mean(zekf.y)).^2);
MSE_PF=mean((z.y-mean(zpf.y)).^2);
fprintf('Minimum Mean Squared Error: ')
if MSE_EKF>MSE_PF
    fprintf('%.2f -> PF\nWhile EKF -> %.2f\n', MSE_PF,MSE_EKF)
else
    fprintf('%.2f -> EKF\nWhile PF -> %.2f\n',MSE_EKF,MSE_PF)
end
