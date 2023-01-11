clear; close all;
Nc = 10; % Number of subchannels
N0 = 1; % Average noise power
index = 1:1:Nc;
lambda = 0.2;
mu = [0.1 0.2 0.3 0.4];
h = [0.1+0.1i, 0.2+0.8i, 0.01+0.2i, 0.1+0.9i, 0.3+0.1i, 0.1+0.7i, 0.09+0.02i, 0.1+0.8i, 0.4+0.8i, 0.1+0.3i];

%% Calculate optimal power allocation
% Initialisation
n_mu = length(mu);
n_channel = length(h);
Pn = zeros(n_channel, n_mu);
waterLevel = zeros(n_channel, n_mu);
figure;

for i = 1:n_mu
    Pn(:, i) = 1./(lambda-mu(:,i).* abs(h).^2) - N0 ./ abs(h) .^2; % Calculate optimal power allocation for subcarriers
    Pn (Pn<0) = 0;
    waterLevel(:, i) = 1./(lambda-mu(:,i).* abs(h).^2); % Calculate threshold of power
    N0_carrier = N0 ./ abs(h) .^2; % Noise of each subcarrier
    % Plot power allocation
    Fig1 = subplot(4, 1, i);
    bar(index, [N0_carrier; Pn(:, i)'], 'stacked');
    hold on
    threshold = bar(Fig1, waterLevel(:, i), 'FaceColor','none', 'LineWidth', 1, 'LineStyle', '--');
    ylim([0 1.2 * max(waterLevel(:, 1))]);
    title(['Carrier power (mu= ',num2str(mu(:,i)),')']);
    legend('Noise', 'Power', 'Waterlevel');
    xlabel('Subcarrier index');
    ylabel('Power');
end