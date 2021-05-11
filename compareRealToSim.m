clear all
load 'project2data.mat'
%1075 to 2700+1075-1 for first
%4500 to 4500+2700-1 for second
% testReal2 = Sensor2mmHg(4500:4500+2700-1).'; %1.5hr worth of data
% testReal3 = Sensor3mmHg(4500:4500+2700-1).';
% FIR1 filter: Order 60, cutoff 0.025
% FIRPM: Order 80, Cutoff 0.075
% IIR: Order 2, cutoff 0.025
b2 = fir1(60, 0.025, 'low');
filtered2 = filter(b2, 1, Sensor3mmHg);
%a = 1;
a = [1 1 0 0];
f = [0 0.075 0.075+0.025 1];
b4 = firpm(80, f, a);
filtered4 = filter(b4, 1, Sensor3mmHg);
% a = 1;
[b3, a1] = butter(2, 0.025);
filtered3 = filter(b3, a1, Sensor3mmHg);


subplot(4,1,1)
plot(Sensor3mmHg)
title('Sensor3mmHg Full')
xlabel('Sample')
ylabel('Value in mmHg')
subplot(4,1,2)
plot(filtered2)
title('Sensor3mmHg Filtered by Window Method')
xlabel('Sample')
ylabel('Value in mmHg')
subplot(4,1,3)
plot(filtered4)
title('Sensor3mmHg Filtered by Parks-McClellan Method')
xlabel('Sample')
ylabel('Value in mmHg')
subplot(4,1,4)
plot(filtered3)
title('Sensor3mmHg Filtered by Butterworth Filter')
xlabel('Sample')
ylabel('Value in mmHg')

% a = [1 1 0 0];
% f = [0 0.075 0.1 1];
% [true, complete] = pressure_sim(64.76, 29.87, 1.5, 1);
% b1 = firpm(80, f, a);
% filtered1 = filter(b1, 1, complete);
% y1 = pressure_eval(true, filtered1, 100);
% 
% f = [0 0.3 0.325 1];
% b2 = firpm(60, f, a);
% filtered2 = filter(b2, 1, complete);
% y2 = pressure_eval(true, filtered2, 100);
% 
% subplot(3,1,1);
% plot(true)
% title('True Pressure Simulation, noise std = 1')
% xlabel('Sample')
% ylabel('Value in mmHg')
% subplot(3,1,2)
% plot(filtered1)
% title('Filtered Pressure Simulation, order = 80, wc = 0.075pi')
% xlabel('Sample')
% ylabel('Value in mmHg')
% subplot(3,1,3)
% plot(filtered2)
% title('Filtered Pressure Simulation, order = 60, wc = 0.3pi')
% xlabel('Sample')
% ylabel('Value in mmHg')
