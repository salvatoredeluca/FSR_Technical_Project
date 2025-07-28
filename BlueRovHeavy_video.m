folderName =fullfile(pwd, 'Media');
if  ~exist(folderName, 'dir') % Check if the folder doesnt  exist    
    mkdir(folderName); % Create the folder
end

% === Estrai dati dalla simulazione ===
time = out.NED.Time;
NED = out.NED.Data;
x = NED(:, 1);
y = NED(:, 2);
z = NED(:, 3);

% === Setup video ===
v = VideoWriter(string(folderName)+'/TrajectoryVideo3.mp4', 'MPEG-4');
v.FrameRate = 30;
v.Quality = 100;
open(v);

% === Setup figura ===
fig = figure('Color', 'w');
set(gcf, 'Position', [100, 100, 1600, 900]);  % Finestra più grande per migliore risoluzione

xlabel('$x$ [m]', 'Interpreter', 'latex');
ylabel('$y$ [m]', 'Interpreter', 'latex');
zlabel('$z$ [m]', 'Interpreter', 'latex');
title('Animazione traiettoria robot', 'Interpreter', 'latex');
view(35, 25);
grid on;
axis equal;
hold on;

% Riduci margini degli assi per eliminare bianco inutile
ax = gca;
ax.Position = [0.05 0.05 0.9 0.9];  % fa occupare quasi tutta la figura agli assi

% === Limiti asse fissi e simmetrici ===
padding = 0.3;
xmin = min(x); xmax = max(x);
ymin = min(y); ymax = max(y);
zmin = min(z); zmax = max(z);
rangeMax = max([xmax - xmin, ymax - ymin, zmax - zmin]) / 2;
xc = (xmin + xmax)/2;
yc = (ymin + ymax)/2;
zc = (zmin + zmax)/2;
xlim([xc - rangeMax - padding, xc + rangeMax + padding]);
ylim([yc - rangeMax - padding, yc + rangeMax + padding]);
zlim([zc - rangeMax - padding, zc + rangeMax + padding]);

axis manual; % Blocca i limiti degli assi!

% === Sfera robot ===
r = 0.4;
[sx, sy, sz] = sphere(20);
hsfera = surf(r*sx + x(1), r*sy + y(1), r*sz + z(1), ...
              'FaceColor', [0, 0.3, 0.5], 'EdgeColor', 'none', 'FaceAlpha', 1.0);

% === Traiettoria verde chiaro ===
htraj = plot3(x(1), y(1), z(1), '-', 'Color', [0.3 1 0.3], 'LineWidth', 1.5);

% === Animazione ===
step = 3;
for k = step:step:length(time)
    % Aggiorna traiettoria
    set(htraj, 'XData', x(1:k), 'YData', y(1:k), 'ZData', z(1:k));
    % Aggiorna sfera
    set(hsfera, 'XData', r*sx + x(k), 'YData', r*sy + y(k), 'ZData', r*sz + z(k));
    title(sprintf('t = %.2f s', time(k)), 'Interpreter', 'latex');
    
    drawnow;
    frame = getframe(fig); % Prendi l’intera figura (non solo gli assi)
    writeVideo(v, frame);
end

close(v);

