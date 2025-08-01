close all
folderName = fullfile(pwd, 'Plots');
if ~exist(folderName, 'dir')    
    mkdir(folderName); 
end

% --- PLOT Forces ---
figure(1);
hold on;
plot(out.tau.Time, out.tau.Data(1,:), 'LineWidth', 1);
plot(out.tau.Time, out.tau.Data(2,:), 'LineWidth', 1);
plot(out.tau.Time, out.tau.Data(3,:), 'LineWidth', 1);
hold off;
grid on; box on;
title('Forces', 'Interpreter','latex');
xlabel('$t$ [s]', 'Interpreter','latex');
ylabel('$\tau$ [N]', 'Interpreter','latex');
legend({'$\tau_x$', '$\tau_y$', '$\tau_z$'}, 'Interpreter','latex', 'Location','best');
saveas(gcf, fullfile(folderName, 'forces.eps'), 'epsc');

figure(2);
hold on;
plot(out.tau.Time, out.tau.Data(4,:), 'LineWidth', 1);
plot(out.tau.Time, out.tau.Data(5,:), 'LineWidth', 1);
plot(out.tau.Time, out.tau.Data(6,:), 'LineWidth', 1);
hold off;
grid on; box on;
title('Torques', 'Interpreter','latex');
xlabel('$t$ [s]', 'Interpreter','latex');
ylabel('$\tau$ [Nm]', 'Interpreter','latex');
legend({'$\tau_{\phi}$', '$\tau_{\theta}$', '$\tau_{\psi}$'}, 'Interpreter','latex', 'Location','best');
saveas(gcf, fullfile(folderName, 'torques.eps'), 'epsc');

% % --- PLOT NED ---
% figure(3);
% hold on;
% plot(out.NED.Time, out.NED.Data(:,1), 'LineWidth', 1);
% plot(out.NED.Time, out.NED.Data(:,2), 'LineWidth', 1);
% plot(out.NED.Time, out.NED.Data(:,3), 'LineWidth', 1);
% hold off;
% grid on; box on;
% title('Position in NED', 'Interpreter','latex');
% xlabel('$t$ [s]', 'Interpreter','latex');
% ylabel('Position [m]', 'Interpreter','latex');
% legend({'$Nord$', '$East$', '$Down$'}, 'Interpreter','latex', 'Location','best');
% saveas(gcf, fullfile(folderName, 'NED.eps'), 'epsc');

% --- PLOT Errors ---
figure(4);
hold on;
plot(out.eP.Time, out.eP.Data(1,:), 'LineWidth', 1);
plot(out.eP.Time, out.eP.Data(2,:), 'LineWidth', 1);
plot(out.eP.Time, out.eP.Data(3,:), 'LineWidth', 1);
hold off;
grid on; box on;
title('Position Errors', 'Interpreter','latex');
xlabel('$t$ [s]', 'Interpreter','latex');
ylabel('Position Errors [m]', 'Interpreter','latex');
legend({'$e_{x}$', '$e_{y}$', '$e_{z}$'}, 'Interpreter','latex', 'Location','best');
saveas(gcf, fullfile(folderName, 'ep.eps'), 'epsc');

dim_eO=size(out.eO.Data(:,1));
if dim_eO(1)==4
    figure(5);
    hold on;
    plot(out.eO.Time, out.eO.Data(2,:), 'LineWidth', 1);
    plot(out.eO.Time, out.eO.Data(3,:), 'LineWidth', 1);
    plot(out.eO.Time, out.eO.Data(4,:), 'LineWidth', 1);
    % plot(out.eO.Time, out.eO.Data(4,:), 'LineWidth', 1);
    hold off;
    grid on; box on;
    title('Orientation Errors', 'Interpreter','latex');
    xlabel('$t$ [s]', 'Interpreter','latex');
    ylabel('Orientation Errors', 'Interpreter','latex');
    legend({ '$e_{1}$', '$e_{2}$','$e_{3}$'}, 'Interpreter','latex', 'Location','best');
    saveas(gcf, fullfile(folderName, 'eO.eps'), 'epsc');
else
    figure(5);
    hold on;
    plot(out.eO.Time, out.eO.Data(1,:), 'LineWidth', 1);
    plot(out.eO.Time, out.eO.Data(2,:), 'LineWidth', 1);
    plot(out.eO.Time, out.eO.Data(3,:), 'LineWidth', 1);
    % plot(out.eO.Time, out.eO.Data(4,:), 'LineWidth', 1);
    hold off;
    grid on; box on;
    title('Orientation Errors', 'Interpreter','latex');
    xlabel('$t$ [s]', 'Interpreter','latex');
    ylabel('Orientation Errors', 'Interpreter','latex');
    legend({ '$e_{1}$', '$e_{2}$','$e_{3}$'}, 'Interpreter','latex', 'Location','best');
    saveas(gcf, fullfile(folderName, 'eO.eps'), 'epsc');


end

% --- PLOT Velocities ---
figure(6);
hold on;
plot(out.LinearVel.Time, out.LinearVel.Data(:,1), 'LineWidth', 1);
plot(out.LinearVel.Time, out.LinearVel.Data(:,2), 'LineWidth', 1);
plot(out.LinearVel.Time, out.LinearVel.Data(:,3), 'LineWidth', 1);
hold off;
grid on; box on;
title('Linear Velocity', 'Interpreter','latex');
xlabel('$t$ [s]', 'Interpreter','latex');
ylabel('Linear Velocity [m/s]', 'Interpreter','latex');
legend({'u', 'v', 'w'}, 'Interpreter','latex', 'Location','best');
saveas(gcf, fullfile(folderName, 'LinearVel.eps'), 'epsc');

figure(7);
hold on;
plot(out.AngularVel.Time, out.AngularVel.Data(:,1), 'LineWidth', 1);
plot(out.AngularVel.Time, out.AngularVel.Data(:,2), 'LineWidth', 1);
plot(out.AngularVel.Time, out.AngularVel.Data(:,3), 'LineWidth', 1);
hold off;
grid on; box on;
title('Angular Velocities', 'Interpreter','latex');
xlabel('$t$ [s]', 'Interpreter','latex');
ylabel('Angular Velocity [rad/s]', 'Interpreter','latex');
legend({'p', 'q', 'r'}, 'Interpreter','latex', 'Location','best');
saveas(gcf, fullfile(folderName, 'AngularVel.eps'), 'epsc');
