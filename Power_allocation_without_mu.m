clear; close all;
Nc = 10; % Number of subchannels
N0 = 1; % Average noise power
index = 1:1:Nc;
lambda = 0.28;
h = [0.1+0.1i, 0.2+0.8i, 0.01+0.2i, 0.1+0.9i, 0.3+0.1i, 0.1+0.7i, 0.09+0.02i, 0.1+0.8i, 0.4+0.8i, 0.1+0.3i];

Pn = 1/lambda - N0 ./ abs(h) .^2; % Calculate optimal power allocation for subcarriers
Pn (Pn<0) = 0;
waterLevel = 1 / lambda; % Calculate threshold of power
N0_carrier = N0 ./ abs(h) .^2; % Noise of each subcarrier

figure;
bar(index, [N0_carrier; Pn], 'stacked');
% Plot waterlevel
pl = line([0, Nc + 1], [waterLevel, waterLevel]);
pl.Color = 'green';
pl.LineStyle = '--';
ylim([0 1.2*waterLevel]);
legend('Noise', 'Power', 'Waterlevel');
xlabel('Subcarrier index');
ylabel('Power');

