% Rerun on existing .mat file, to make adjustments to plot.

%% Nominal plots: Think about making these subplots (left-right)!
% z1 vs time:
figure(1)
clf
modificatorF{1} = '';
modificatorF{2} = 'LineWidth';
modificatorF{3} = 1.5;
modificatorJ{1} = '*--';
modificatorJ{2} = 'LineWidth';
modificatorJ{3} = 1.5;
plotHarc(tNom,jNom,xNom(:,1),[],modificatorF,modificatorJ);
hold on
plot(deltaVecNom(3),deltaVecNom(1),'k.','MarkerSize', 14)
strDeltaNom = [num2str(deltaVecNom(3)),'s'];
hold on
text(deltaVecNom(3),deltaVecNom(1),strDeltaNom,'HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',12);
hold off
axis([0 4 -30 60]);
xlabel('t','FontSize',16)
ylabel('z_1','FontSize',16)
saveas(gcf,'Plots\PlotNominal','epsc')

figure(2)
clf
semilogy(tNom,lNom,'LineWidth',1.5);
axis([0 10 10^(-25) 10^(4)]);
xlabel('t','FontSize',16)
ylabel('L(z_1)-L^*','FontSize',16)
saveas(gcf,'Plots\PlotLog','epsc')