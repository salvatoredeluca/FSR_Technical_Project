close all
folderName =fullfile(pwd, 'Plots');
if  ~exist(folderName, 'dir') % Check if the folder doesnt  exist    
    mkdir(folderName); % Create the folder
end
% --- PLOT tau ---
figure(1);
hold on;
plot(out.tau.Time, out.tau.Data(1,:), 'r', 'LineWidth', 1);
plot(out.tau.Time, out.tau.Data(2,:), 'g', 'LineWidth', 1);
plot(out.tau.Time, out.tau.Data(3,:), 'b', 'LineWidth', 1);
hold off;
grid on; box on;
title('Control Input', 'Interpreter','latex');
xlabel('$t$ [s]', 'Interpreter','latex');
ylabel('$\tau$ [Nm]', 'Interpreter','latex');
legend({'$\tau_1$', '$\tau_2$', '$\tau_3$'}, 'Interpreter','latex', 'Location','best');
saveas(gcf, fullfile(folderName, 'tau.eps'), 'epsc');


% --- PLOT NED ---
figure(2);
hold on;
plot(out.NED.Time, out.NED.Data(:,1), 'r', 'LineWidth', 1);
plot(out.NED.Time, out.NED.Data(:,2), 'g', 'LineWidth', 1);
plot(out.NED.Time, out.NED.Data(:,3), 'b', 'LineWidth', 1);
hold off;
grid on; box on;
title('Position in NED', 'Interpreter','latex');
xlabel('$t$ [s]', 'Interpreter','latex');
ylabel('Position [m]', 'Interpreter','latex');
legend({'$Nord$', '$East$', '$Down$'}, 'Interpreter','latex', 'Location','best');
saveas(gcf, fullfile(folderName, 'NED.eps'), 'epsc');


% --- PLOT Errors ---
figure(3);
hold on;
plot(out.eP.Time, out.eP.Data(1,:), 'r', 'LineWidth', 1);
plot(out.eP.Time, out.eP.Data(2,:), 'g', 'LineWidth', 1);
plot(out.eP.Time, out.eP.Data(3,:), 'b', 'LineWidth', 1);
hold off;
grid on; box on;
title('Position Errors', 'Interpreter','latex');
xlabel('$t$ [s]', 'Interpreter','latex');
ylabel('Position Errors [m]', 'Interpreter','latex');
legend({'$e_{x}$', '$e_{y}$', '$e_{z}$'}, 'Interpreter','latex', 'Location','best');
saveas(gcf, fullfile(folderName, 'ep.eps'), 'epsc');


figure(4);
hold on;
plot(out.eO.Time, out.eO.Data(1,:), 'r', 'LineWidth', 1);
plot(out.eO.Time, out.eO.Data(2,:), 'g', 'LineWidth', 1);
plot(out.eO.Time, out.eO.Data(3,:), 'b', 'LineWidth', 1);
% plot(out.eO.Time, out.eO.Data(4,:), 'm', 'LineWidth', 1);
hold off;
grid on; box on;
title('Orientation Errors', 'Interpreter','latex');
xlabel('$t$ [s]', 'Interpreter','latex');
ylabel('Orientation Errors', 'Interpreter','latex');
legend({ '$e_{\epsilon_1}$', '$e_{\epsilon_2}$','$e_{\epsilon_3}$'}, 'Interpreter','latex', 'Location','best');
saveas(gcf, fullfile(folderName, 'eO.eps'), 'epsc');

% --- PLOT Velocities ---
figure(5);
hold on;
plot(out.LinearVel.Time, out.LinearVel.Data(:,1), 'r', 'LineWidth', 1);
plot(out.LinearVel.Time, out.LinearVel.Data(:,2), 'g', 'LineWidth', 1);
plot(out.LinearVel.Time, out.LinearVel.Data(:,3), 'b', 'LineWidth', 1);
hold off;
grid on; box on;
title('Linear Velocity', 'Interpreter','latex');
xlabel('$t$ [s]', 'Interpreter','latex');
ylabel('Linear Velocity [m/s]', 'Interpreter','latex');
legend({'u', 'v', 'w'}, 'Interpreter','latex', 'Location','best');
saveas(gcf, fullfile(folderName, 'LinearVel.eps'), 'epsc');

figure(6);
hold on;
plot(out.AngularVel.Time, out.AngularVel.Data(:,1), 'r', 'LineWidth', 1);
plot(out.AngularVel.Time, out.AngularVel.Data(:,2), 'g', 'LineWidth', 1);
plot(out.AngularVel.Time, out.AngularVel.Data(:,3), 'b', 'LineWidth', 1);
hold off;
grid on; box on;
title('Angular Velocities', 'Interpreter','latex');
xlabel('$t$ [s]', 'Interpreter','latex');
ylabel('Angular Velocity [rad/s]', 'Interpreter','latex');
legend({'p', 'q', 'r'}, 'Interpreter','latex', 'Location','best');
saveas(gcf, fullfile(folderName, 'AngularVel.eps'), 'epsc');

