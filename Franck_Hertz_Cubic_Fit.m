% Load data
data = load('frank_dip6_final.txt');
x_data = data(:, 1);
y_data = data(:, 2);
x_error = data(:, 3);
y_error = data(:, 4);

% Perform curve fitting
fitted_params = lsqcurvefit(@Franck_Hertz, [6.3812e-11,-4.9389e-09,9.6456e-08, 0], x_data, y_data);

% Calculate uncertainties
[~, R, J] = nlinfit(x_data, y_data, @Franck_Hertz, fitted_params);
ci = nlparci(fitted_params, R, 'Jacobian', J);
uncertainties = diff(ci) / 2;

% Calculate residuals
residuals = y_data - Franck_Hertz(fitted_params, x_data);

% Define x_fit and y_fit with the same length
x_fit = linspace(min(x_data), max(x_data), 100);
y_fit = Franck_Hertz(fitted_params, x_fit);

% Plot the data with error bars and the fitted curve
figure;
errorbar(x_data, y_data, y_error, 'o', 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'b');
hold on;
plot(x_fit, y_fit, 'r', 'LineWidth', 2);
legend('Data', 'Best Fit')
xlabel('Accelerating Voltage (V)');
ylabel('Current (A)');
title('Current vs Voltage');

% Plot residuals with error bars
figure;
errorbar(x_data, residuals, y_error, 'o', 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'b');
hold on;
plot([min(x_data), max(x_data)], [0, 0], 'r', 'LineWidth', 2); % Add a red horizontal line at y = 0
xlabel('Accelerating Voltage (V)');
ylabel('Residuals');
title('Residuals vs Accelerating Voltage');

for i = 1:numel(fitted_params)
    fprintf('Parameter %d: %.4e ± %.4e\n', i, fitted_params(i), uncertainties(i));
end

% Calculate chi-square statistic
chi_square = sum((residuals ./ y_error).^2);

% Calculate R-squared
y_mean = mean(y_data);
ss_total = sum((y_data - y_mean).^2);
ss_residual = sum(residuals.^2);
r_squared = 1 - (ss_residual / ss_total);

% Root Mean Square Error (RMSE)
rmse = sqrt(mean(residuals.^2));

fprintf('Chi-Square: %.4f\n', chi_square);
fprintf('R-squared: %.4f\n', r_squared);
fprintf('RMSE: %.4f\n', rmse);

% Fitting function for Franck-Hertz Law
function y_fit = Franck_Hertz(params, x)
    a = params(1);
    b = params(2);
    c = params(3);
    d= params(4);
    y_fit = a .* x.^3 + b .* x.^2 + c.*x + d;
end
