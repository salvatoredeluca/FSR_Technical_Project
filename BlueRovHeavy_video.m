close all;
folderName = fullfile(pwd, 'Media');
if ~exist(folderName, 'dir')    
    mkdir(folderName); 
end

% === Estrai dati dalla simulazione ===
time = out.NED.Time;
NED = out.NED.Data;
x = NED(:, 1);
y = NED(:, 2);
z = NED(:, 3);

% === Estrai traiettoria di riferimento ===
etad = out.etad.Data;  % Data è una 3xN (riga = variabile, colonna = tempo)
xref = etad(1, :);
yref = etad(2, :);
zref = etad(3, :);
% === Setup video ===
v = VideoWriter(string(folderName) + '/TrajectoryVideoFeedbackLin.mp4', 'MPEG-4');
v.FrameRate = 15;
v.Quality = 100;
open(v);

% === Setup figura ===
fig = figure('Color', 'w');
set(gcf, 'Position', [100, 100, 1600, 900]);

xlabel('$x$ [m]', 'Interpreter', 'latex');
ylabel('$y$ [m]', 'Interpreter', 'latex');
zlabel('$z$ [m]', 'Interpreter', 'latex');
title('Animazione traiettoria robot', 'Interpreter', 'latex');
view(35, 25);
grid on;
axis equal;
hold on;

ax = gca;
ax.Position = [0.05 0.05 0.9 0.9];

% === Limiti asse fissi e simmetrici (usando sia traiettoria che riferimento) ===
padding = 0.3;
xmin = min([x; xref']); xmax = max([x; xref']);
ymin = min([y; yref']); ymax = max([y; yref']);
zmin = min([z; zref']); zmax = max([z; zref']);
rangeMax = max([xmax - xmin, ymax - ymin, zmax - zmin]) / 2;
xc = (xmin + xmax)/2;
yc = (ymin + ymax)/2;
zc = (zmin + zmax)/2;
xlim([xc - rangeMax - padding, xc + rangeMax + padding]);
ylim([yc - rangeMax - padding, yc + rangeMax + padding]);
zlim([zc - rangeMax - padding, zc + rangeMax + padding]);

axis manual;

% === Plot traiettoria di riferimento ===
plot3(xref, yref, zref, '--', 'Color', [0.6 0.6 0.9], 'LineWidth', 1.5);  % blu-grigio chiaro

% === Sfera robot ===
r = 0.4;
[sx, sy, sz] = sphere(20);
hsfera = surf(r*sx + x(1), r*sy + y(1), r*sz + z(1), ...
              'FaceColor', [0, 0.3, 0.5], 'EdgeColor', 'none', 'FaceAlpha', 1.0);

% === Traiettoria robot ===
htraj = plot3(x(1), y(1), z(1), '-', 'Color', [0.3 1 0.3], 'LineWidth', 1.5);

% === Animazione ===
step = 3;
for k = step:step:length(time)
    set(htraj, 'XData', x(1:k), 'YData', y(1:k), 'ZData', z(1:k));
    set(hsfera, 'XData', r*sx + x(k), 'YData', r*sy + y(k), 'ZData', r*sz + z(k));
    title(sprintf('t = %.2f s', time(k)), 'Interpreter', 'latex');
    
    drawnow;
    frame = getframe(fig);
    writeVideo(v, frame);
end

close(v);
