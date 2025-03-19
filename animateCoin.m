function animateCoin(data_t,data_Z,params,Deltat,N_plot,N_animation)
R = params(3);

[data_t_unique,idx_unique] = unique(data_t);
data_Z_unique = data_Z(idx_unique,:);

t = linspace(data_t_unique(1),data_t_unique(end),Deltat*N_animation);
Z = interp1(data_t_unique,data_Z_unique,t);

figure;
for ii = 1:length(t)
    plotCoin(Z(ii,:),params,N_plot);
    grid on;
    hold on;
    plot3(Z(1:ii,1),Z(1:ii,2),Z(1:ii,3),"color",[0,0.447,0.741]);
    title([num2str(t(ii)),' s']);
    view(3);
    axis equal;
    xlim([min(data_Z(:,1))-2*R,max(data_Z(:,1))+2*R]);
    ylim([min(data_Z(:,2))-2*R,max(data_Z(:,2))+2*R]);
    zlim([0, max(data_Z(:,3))+2*R]);
    drawnow;
    hold off;
end

end