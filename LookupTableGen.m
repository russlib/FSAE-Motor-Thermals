% --- Load your CSV and prepare data (adapt to your filename) ---
filename = 'C:\Matlab\Motor Eff\Motor Heat Gen\Emrax Efficency\Motor Eff PNG to csv.csv';
tbl = readtable(filename);

rpm = double(tbl.RPM);
torque = double(tbl.Torque);
efficiency = double(tbl.Efficiency);

validRows = isfinite(rpm) & isfinite(torque) & isfinite(efficiency);
rpm = rpm(validRows);
torque = torque(validRows);
efficiency = efficiency(validRows);

% --- Scale inputs for fitting ---
rpm_scaled = rpm / max(rpm);
torque_scaled = torque / max(torque);

% --- Fit the poly33 model ---
sf = fit([rpm_scaled, torque_scaled], efficiency, 'poly33');

% --- Create lookup grid ---
rpm_vals = linspace(min(rpm), max(rpm), 100);
torque_vals = linspace(min(torque), max(torque), 100);
[rpmGrid, torqueGrid] = meshgrid(rpm_vals, torque_vals);

% --- Scale grid for fit evaluation ---
rpmGrid_scaled = rpmGrid / max(rpm);
torqueGrid_scaled = torqueGrid / max(torque);

% --- Evaluate fit on grid ---
efficiencyGrid = sf(rpmGrid_scaled, torqueGrid_scaled);




% --- User-defined grid resolution ---
num_rpm_points = 300;
num_torque_points = 200;

% --- Choose whether to start grid from zero ---
startFromZero = true;

% --- Define RPM and Torque grid vectors ---
if startFromZero
    rpm_vals = linspace(0, max(rpm), num_rpm_points);
    torque_vals = linspace(0, max(torque), num_torque_points);
else
    rpm_vals = linspace(min(rpm), max(rpm), num_rpm_points);
    torque_vals = linspace(min(torque), max(torque), num_torque_points);
end

% --- Create mesh grid ---
[rpmGrid, torqueGrid] = meshgrid(rpm_vals, torque_vals);

% --- Scale grid for model evaluation ---
rpmGrid_scaled = rpmGrid / max(rpm);
torqueGrid_scaled = torqueGrid / max(torque);

% --- Evaluate model on grid ---
efficiencyGrid = sf(rpmGrid_scaled, torqueGrid_scaled);

% --- Output path ---
outputFolder = 'C:\Matlab\Motor Eff\Motor Heat Gen\Emrax Efficency\LookupTables\Poly33';
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

% --- Save .mat file ---
save(fullfile(outputFolder, 'EfficiencyLookupTable_poly33.mat'), ...
    'rpm_vals', 'torque_vals', 'efficiencyGrid');

% --- Save .csv file (flattened list of [RPM, Torque, Efficiency]) ---
lookupTable = [rpmGrid(:), torqueGrid(:), efficiencyGrid(:)];
csvHeader = {'RPM', 'Torque', 'Efficiency'};
lookupTableCell = [csvHeader; num2cell(lookupTable)];

writecell(lookupTableCell, fullfile(outputFolder, 'EfficiencyLookupTable_poly33.csv'));

fprintf('Saved smooth lookup table (%dx%d grid, startFromZero=%d) to: %s\n', ...
    num_rpm_points, num_torque_points, startFromZero, outputFolder);
