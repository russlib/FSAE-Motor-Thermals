%csv to nice plot script
%Russell B 

% Load data from CSV
filename = 'C:\Matlab\Motor Eff\Motor Heat Gen\Emrax Efficency\Motor Eff PNG to csv.csv';
tbl = readtable(filename);

% Extract columns and convert to numeric
rpm = double(tbl.RPM);
torque = double(tbl.Torque);
efficiency = double(tbl.Efficiency);

% Remove invalid data
validRows = isfinite(rpm) & isfinite(torque) & isfinite(efficiency);
rpm = rpm(validRows);
torque = torque(validRows);
efficiency = efficiency(validRows);

% Rescale inputs for fitting (to give torque more influence)
scaleFactor = 1; % I dont think this does anything
rpm_scaled = rpm / max(rpm);
torque_scaled = torque / max(torque) * scaleFactor;

% Create original grid for evaluation
rpm_vals = linspace(min(rpm), max(rpm), 100);
torque_vals = linspace(min(torque), max(torque), 100);
[rpmGrid, torqueGrid] = meshgrid(rpm_vals, torque_vals);

% Scale grid for fit evaluation
rpmGrid_scaled = rpmGrid / max(rpm);
torqueGrid_scaled = torqueGrid / max(torque) * scaleFactor;

% Best imo
fitTypes = {'poly22'};
% % Options
% fitTypes = {'poly11', 'poly22', 'poly33', 'poly35', 'lowess', 'smoothingspline'};

% Loop through each fit type
for i = 1:length(fitTypes)
    fitType = fitTypes{i};
    
    % Perform the fit
    try
        sf = fit([rpm_scaled, torque_scaled], efficiency, fitType);
    catch ME
        warning('Fit type %s failed: %s', fitType, ME.message);
        continue;
    end
    
    % Evaluate on scaled grid
    efficiencyGrid = feval(sf, rpmGrid_scaled, torqueGrid_scaled);
    
    % Plot
    figure('Name', ['Fit: ', fitType]);
    surf(rpmGrid, torqueGrid, efficiencyGrid);
    xlabel('RPM');
    ylabel('Torque (Nm)');
    zlabel('Efficiency (%)');
    title(['Efficiency Map using Fit: ', fitType], 'Interpreter', 'none');
    colorbar;
    shading interp;
    colormap jet;
    view(45, 30);
end
