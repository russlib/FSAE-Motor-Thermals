%95 merger





lq96(:,3) = 96;
lq95(:,3) = 95;
lq94(:,3) = 94;
lq90(:,3) = 90;
lq86(:,3) = 86;





% Extract x, y, and z values from ploop86 and ploop96 datasets
x95 = lq95(:, 1);
y95 = lq95(:, 2);
z95 = lq95(:, 3);

x96 = lq96(:, 1);
y96 = lq96(:, 2);
z96 = lq96(:, 3);

x94 = lq94(:, 1);
y94 = lq94(:, 2);
z94 = lq94(:, 3);

x90 = lq90(:, 1);
y90 = lq90(:, 2);
z90 = lq90(:, 3);

x86 = lq86(:, 1);
y86 = lq86(:, 2);
z86 = lq86(:, 3);


% Combine x, y, and z values into single arrays
x = [x95; x96;x94;x90;x86];
y = [y95; y96;y94;y90;y86];
z = [z95; z96; z94;z90;z86];

% Create a grid of x and y coordinates
[X, Y] = meshgrid(linspace(min(x), max(x), 100), linspace(min(y), max(y), 100));

% Interpolate values on the grid
Z = griddata(x, y, z, X, Y,"natural");

% Plot the interpolated surface
surf(X, Y, Z);
xlabel('X');
ylabel('Y');
zlabel('Efficiency');
title('Interpolated Surface');

% Alternatively, you can plot a contour plot
% contour(X, Y, Z);
% xlabel('X');
% ylabel('Y');
% title('Contour Plot');

% Or a filled contour plot
% contourf(X, Y, Z);
% colorbar;
% xlabel('X');
% ylabel('Y');
% title('Filled Contour Plot');


% Define the point for which you want to find the z value
point = [300, 200]; % Replace x_value and y_value with the coordinates of your point

% Interpolate the z value for the given point
z_value = griddata(x, y, z, point(1), point(2), 'natural');

disp(['Z value at point (' num2str(point(1)) ', ' num2str(point(2)) ') is: ' num2str(z_value)]);


function new_matrix = increase_x_values(matrix)
    % Increase the x values of each vector in the matrix by 10%
    new_matrix = matrix;
    new_matrix(:,1) = matrix(:,1) * 1.1; % Increase x values by 10%
end

