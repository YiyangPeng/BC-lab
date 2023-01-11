clear; close all;
%% Initialisation
Nc = 10;
N0 = 1;
lambda = 0: 0.01: 5;
mu = 0.2;
h = [0.1+0.1i, 0.2+0.8i, 0.01+0.2i, 0.1+0.9i, 0.3+0.1i, 0.1+0.7i, 0.09+0.02i, 0.1+0.8i, 0.4+0.8i, 0.1+0.3i];
PTx = zeros(Nc, length(lambda));
waterlevel = zeros(Nc, length(lambda));

%% Calculate power efficiency
% Calculate transmission power
for i = 1:length(lambda)
    PTx(:, i) = 1./(lambda(:,i)-mu.* abs(h).^2) - N0 ./ abs(h) .^2; % Calculate optimal power allocation for subcarriers
    PTx (PTx<0) = 0;
    waterlevel(:, i) = 1./(lambda(:,i)-mu.* abs(h).^2); % Calculate threshold of power
end

PRx = abs(h) .^2' .* PTx; % Calculate received power

% Sum power of all subchannels
sum_PTx = sum(PTx);
sum_PRx = sum(PRx);
% Calculate efficiency
eff = sum_PRx ./ sum_PTx;

figure;
plot(lambda, eff);
title(['Power efficiency with mu = ', num2str(mu)]);
xlabel('Lambda')
ylabel('A ratio of received power over transmission power')
