% Noise Cancellation using FIR and IIR Filters

% Parameters
fs = 44100;                  % Sampling frequency (Hz)
duration = 5;                % Duration of recording (seconds)
noise_duration = 2;          % Duration of noise sample (seconds)
order = 100;                 % Filter order

% Generate noise sample
t = 0:1/fs:noise_duration-1/fs;
noise = 0.5*sin(2*pi*1000*t) + 0.3*sin(2*pi*2000*t);

% Design FIR filter
fir_filter = fir1(order, 1000/(fs/2));

% Design IIR filter
[b, a] = butter(order, 1000/(fs/2));

% start recording
recorder = audiorecorder(fs, 16, 1);
disp('Start speaking...');
recordblocking(recorder, duration);
disp('Recording completed.');

% Get recorded data
input_signal = getaudiodata(recorder);

% Apply FIR filter
output_fir = filter(fir_filter, 1, input_signal);

% Apply IIR filter
output_iir = filter(b, a, input_signal);

% Play original, FIR-filtered, and IIR-filtered signals
soundsc(input_signal, fs);
pause(duration + 1);
soundsc(output_fir, fs);
pause(duration + 1);
soundsc(output_iir, fs);

% Plot original, FIR-filtered, and IIR-filtered signals
t = 0:1/fs:(length(input_signal)-1)/fs;
figure;
subplot(3,1,1);
plot(t, input_signal);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(3,1,2);
plot(t, output_fir);
title('FIR-Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(3,1,3);
plot(t, output_iir);
title('IIR-Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');