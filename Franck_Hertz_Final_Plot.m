% Read data from the text file
data = dlmread('filtered_data_final10.txt');

% Extract columns
x_data = data(:, 1);
y_data = data(:, 2);
x_uncertainty = data(:, 3);
y_uncertainty = data(:, 4);

figure;

% Plot data points with error bars (error bars in green, larger circles, black color)

errorbar(x_data, y_data, y_uncertainty, y_uncertainty, x_uncertainty, x_uncertainty, 'ok', 'MarkerSize', 3, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'Color', [0.7 0.7 0.7], 'LineStyle', 'none');

hold on;

% Add labels and title
xlabel('Accelerating Voltage (V)');
ylabel('Current (A)');
title('Treated Frank-Hertz Data with Curves of Best Fit Centered Around Local Minima');

% Add grid
grid on;

% Define the intervals for each function
interval1 = [8, 18];
interval2 = [13, 22];
interval3 = [19, 26];
interval4 = [24, 32];
interval5 = [29, 37];
interval_cubic = [34, 42]; % Interval for the cubic function

% Generate x-values within each interval
x_values1 = linspace(interval1(1), interval1(2), 1000);
x_values2 = linspace(interval2(1), interval2(2), 1000);
x_values3 = linspace(interval3(1), interval3(2), 1000);
x_values4 = linspace(interval4(1), interval4(2), 1000);
x_values5 = linspace(interval5(1), interval5(2), 1000);
x_values_cubic = linspace(interval_cubic(1), interval_cubic(2), 1000);

% Example quadratic functions (change coefficients as needed)
quadratic1 = 2.0773e-11*x_values1.^2 + -5.1647e-10*x_values1 + 3.4455e-09;
quadratic2 = 2.0827e-11*x_values2.^2 + -7.1475e-10*x_values2 + 6.4962e-09;
quadratic3 = 4.1531e-11*x_values3.^2 + -1.8792e-09*x_values3 + 2.1722e-08;
quadratic4 = 4.6947e-11*x_values4.^2 + -2.6145e-09*x_values4 + 3.7007e-08;
quadratic5 = 3.7638e-11*x_values5.^2 + -2.4819e-09*x_values5 + 4.1696e-08;

% Plot quadratic functions
plot(x_values1, quadratic1, "MarkerFaceColor",[0.6350 0.0780 0.1840], 'LineWidth', 1.5);
plot(x_values2, quadratic2, "MarkerFaceColor",[0.8500 0.3250 0.0980], 'LineWidth', 1.5);
plot(x_values3, quadratic3, "MarkerFaceColor",[0.9290 0.6940 0.1250], 'LineWidth', 1.5);
plot(x_values4, quadratic4, "MarkerFaceColor",[0.4660 0.6740 0.1880], 'LineWidth', 1.5);
plot(x_values5, quadratic5, "MarkerFaceColor",[0 0.4470 0.7410], 'LineWidth', 1.5);

% Example cubic function (change coefficients as needed)
cubic = 2.6448e-12*x_values_cubic.^3 + -2.7265e-10*x_values_cubic.^2 + 9.2552e-09*x_values_cubic + -1.0215e-07;

% Plot cubic function
plot(x_values_cubic, cubic,"MarkerFaceColor",[0.5 0.5 1], 'LineWidth', 1.5);



% Adjust legend to reflect the changes
legend('Data with Error Bars', '1st Minimum Quadratic Fit', '2nd Minimum Quadratic Fit', '3rd Minimum Quadratic Fit', '4th Minimum Quadratic Fit', '5th Minimum Quadratic Fit', '6th Minimum Cubic Fit');
