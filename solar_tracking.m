% --- Final MATLAB Script for Passive Solar Tracking ---
% This script simulates a passively tracked solar panel vs. a fixed panel,
% with a corrected energy calculation for an accurate comparison.

clc;        % Clear the command window
clear;      % Clear all variables
close all;  % Close all open figures

% --- STEP 1: Define Simulation Parameters ---
% Time vector for a full 24-hour day in one-hour increments.
hours = 0:23;

% Maximum rated power of the solar panel in kilowatts (kW).
maxPower = 5;

% --- STEP 2: Simulate Sun's Position & Panel Tilt Angle ---
% This is a simplified passive tracking algorithm. The tilt angle is calculated
% based on the time of day, assuming a sunrise at 6 AM and sunset at 6 PM.
tiltAngle = 90 * sin(pi*(hours-6)/12);
tiltAngle(hours < 6) = 0;   % Panel is at rest before sunrise.
tiltAngle(hours > 18) = 0;  % Panel is at rest after sunset.

% --- STEP 3: Calculate Power Output for the Tracked Panel ---
% Power is proportional to the cosine of the angle of incidence.
solarTracked = maxPower .* cosd(90-tiltAngle);
solarTracked(solarTracked < 0) = 0; % Power cannot be negative.

% --- STEP 4: Simulate a Fixed Panel for Comparison ---
% The fixed panel's power is modeled with a lower peak efficiency (80%).
% Crucially, its power output is also set to zero during nighttime hours for a fair comparison.
solarFixed = maxPower * 0.8 * sin(pi*(hours-6)/12);
solarFixed(solarFixed < 0) = 0;
solarFixed(hours < 6) = 0;
solarFixed(hours > 18) = 0;

% --- STEP 5: Plot the Results ---
% This section generates the visual graph for your demonstration.
figure;
plot(hours, solarTracked, 'b', 'LineWidth', 2);
hold on;
plot(hours, solarFixed, 'r--', 'LineWidth', 2);
xlabel('Hour of Day');
ylabel('Power Output (kW)');
title('Passive Solar Tracking Simulation');
legend('Tracked Panel', 'Fixed Panel');
grid on;

% --- STEP 6: Calculate and Display Daily Energy ---
% The total energy in kilowatt-hours (kWh) is the sum of the hourly power values.
energyTracked = sum(solarTracked);
energyFixed = sum(solarFixed);

fprintf('Daily Energy (Tracked) = %.2f kWh\n', energyTracked);
fprintf('Daily Energy (Fixed)   = %.2f kWh\n', energyFixed);
