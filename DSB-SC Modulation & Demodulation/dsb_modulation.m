clc; clear; close all;
fs = 150e3; % Sampling frequency 
t_duration = 1;
t = 0:1/fs:t_duration-1/fs; % Time vector (10 ms duration)
carrier_freq = 25000;
dtmf_freqs_0 = [941, 1336]; % DTMF "0"
single_tone = cos(2 * pi * 1000 * t); % 1 kHz sine signal
dtmf_tone = cos(2 * pi * dtmf_freqs_0(1) * t) + cos(2 * pi * dtmf_freqs_0(2) * t);%dtmf '0' signal
carrier = cos(2 * pi * carrier_freq * t);%carrier

%%% time domain of massage 
figure(1);
subplot(2, 1, 1);plot(t, single_tone);title("time domain of single tone masagge");
xlabel("time [sec]");ylabel("Amplitude");xlim([0 0.01]);

subplot(2, 1, 2);plot(t, dtmf_tone);title("time domain of DTMF tone masagge");
xlabel("time [sec]");ylabel("Amplitude");xlim([0 0.01]);

%%% frequency domain of massage
figure(2);
% Compute the FFT of single tone
N = length(single_tone); % Number of points
spectrum_ST = abs(fft(single_tone))/N; % Compute FFT
fd_st = (0:N-1)*(fs/N); % Frequency vector

% Compute the FFT of DTMF tone
N = length(dtmf_tone); % Number of points
spectrum_DTMF = abs(fft(dtmf_tone))/N; % Compute FFT
fd_DTMF = (0:N-1)*(fs/N); % Frequency vector

subplot(2, 1, 1);plot(fd_st, spectrum_ST);title("frequency domain of single tone masagge");
xlabel("Frequency [HZ]");ylabel("Amplitude");xlim([0 fs/50]);

subplot(2, 1, 2);plot(fd_DTMF, spectrum_DTMF);title("frequency domain of DTMF tone masagge");
xlabel("Frequency [HZ]");ylabel("Amplitude");xlim([0 fs/50]);

%tx_part_PB2
dsb_single_tone = single_tone .* carrier;
dsb_dtmf = dtmf_tone .* carrier;

%PB3
%%% DSB time domain 
figure(3);
subplot(2, 1, 1);plot(t, dsb_single_tone,'r');title("time domain of DSB single tone ");
xlabel("time [sec]");ylabel("Amplitude");xlim([0 0.01]);

subplot(2, 1, 2);plot(t, dsb_dtmf,'r');title("time domain of DSB DTMF tone ");
xlabel("time [sec]");ylabel("Amplitude");xlim([0 0.01]);


%%% DSB frequency domain
figure(4);
% Compute the FFT of single tone
N = length(dsb_single_tone); % Number of points
spectrum_DSB_ST = abs(fft(dsb_single_tone))/N; % Compute FFT
fd_st = (0:N-1)*(fs/N); % Frequency vector

% Compute the FFT of DTMF tone
N = length(dsb_dtmf); % Number of points
spectrum_DSB_DTMF = abs(fft(dsb_dtmf))/N; % Compute FFT
fd_DTMF = (0:N-1)*(fs/N); % Frequency vector

subplot(2, 1, 1);plot(fd_st, spectrum_DSB_ST,'r');title("frequency domain of DSB single tone");
xlabel("Frequency [HZ]");ylabel("Amplitude");xlim([20e3 fs/5]);

subplot(2, 1, 2);plot(fd_DTMF, spectrum_DSB_DTMF,'r');title("frequency domain of DSB DTMF tone");
xlabel("Frequency [HZ]");ylabel("Amplitude");xlim([20e3 fs/5]);

%********PB4***********************************************************
%rx_part
%%% DIODE
diode_st=max(0,dsb_single_tone);
diode_dtfm=max(0,dsb_dtmf);

%%% diode time domain 
figure(5);
subplot(2, 1, 1);plot(t, diode_st,'g');title("time domain of Rectified Signal for Single Tone");
xlabel("time [sec]");ylabel("Amplitude");xlim([0 0.01]);

subplot(2, 1, 2);plot(t, diode_dtfm,'g');title("time domain of Rectified Signal for DTMF Tone");
xlabel("time [sec]");ylabel("Amplitude");xlim([0 0.01]);

%%% diode frequency domain
figure(6);
% Compute the FFT of single tone
N = length(diode_st); % Number of points
spectrum_diode_ST = abs(fft(diode_st))/N; % Compute FFT
fd_st = (0:N-1)*(fs/N); % Frequency vector

% Compute the FFT of DTMF tone
N = length(diode_dtfm); % Number of points
spectrum_diode_DTMF = abs(fft(diode_dtfm))/N; % Compute FFT
fd_DTMF = (0:N-1)*(fs/N); % Frequency vector

subplot(2, 1, 1);plot(fd_st, spectrum_diode_ST,'g');title("frequency domain of Rectified Signal for Single Tone");
xlabel("Frequency [HZ]");ylabel("Amplitude");xlim([0 fs/2.5]);

subplot(2, 1, 2);plot(fd_DTMF, spectrum_diode_DTMF,'g');title("frequency domain of Rectified Signal for DTMF Tone");
xlabel("Frequency [HZ]");ylabel("Amplitude");xlim([0 fs/2.5]);






%demodulation (Coherent detector)
mixer_single_tone=diode_st.* carrier;
mixer_dtmf=diode_dtfm.* carrier;


%%% MIXER time domain 
figure(7);
subplot(2, 1, 1);plot(t, mixer_single_tone,'k');title("time domain of Mixed Signal for Single Tone");
xlabel("time [sec]");ylabel("Amplitude");xlim([0 0.01]);

subplot(2, 1, 2);plot(t, mixer_dtmf,'k');title("time domain of Mixed Signal for DTMF Signal");
xlabel("time [sec]");ylabel("Amplitude");xlim([0 0.01]);

%%% MIXER frequency domain
figure(8);
% Compute the FFT of single tone
N = length(mixer_single_tone); % Number of points
spectrum_mixer_ST = abs(fft(mixer_single_tone))/N; % Compute FFT
fd_st = (0:N-1)*(fs/N); % Frequency vector

% Compute the FFT of DTMF tone
N = length(mixer_dtmf); % Number of points
spectrum_mixer_DTMF = abs(fft(mixer_dtmf))/N; % Compute FFT
fd_DTMF = (0:N-1)*(fs/N); % Frequency vector

subplot(2, 1, 1);plot(fd_st, spectrum_mixer_ST,'k');title("frequency domain of Mixed Signal for Single Tone");
xlabel("Frequency [HZ]");ylabel("Amplitude");xlim([0 fs/3.75]);

subplot(2, 1, 2);plot(fd_DTMF, spectrum_mixer_DTMF,'k');title("frequency domain of Mixed Signal for DTMF Signal");
xlabel("Frequency [HZ]");ylabel("Amplitude");xlim([0 fs/3.75]);




%*********PB5********************************************************
% Parameters for the LPF
lpf_cutoff_freq = 1500; % Cutoff frequency for LPF (Hz)
lpf_order = 6;          % Filter order

%Design the LPF using a Butterworth filter
[b, a] = butter(lpf_order, lpf_cutoff_freq / (fs / 2), 'low'); % Normalize cutoff frequency
%Apply the LPF to demodulated signals
filtered_single_tone = filtfilt(b, a, mixer_single_tone);
filtered_dtmf = filtfilt(b, a, mixer_dtmf);
%fvtool(b, a, 'Fs', fs);

%%% filtered massage time domain 
figure(9);
subplot(2, 1, 1);plot(t, filtered_single_tone,'m');title("time domain of filtered Single Tone");
xlabel("time [sec]");ylabel("Amplitude");xlim([0 0.01]);

subplot(2, 1, 2);plot(t, filtered_dtmf,'m');title("time domain of filtered DTMF Tone");
xlabel("time [sec]");ylabel("Amplitude");xlim([0 0.01]);

%%% filtered massage frequency domain
figure(10);
% Compute the FFT of single tone
N = length(filtered_single_tone); % Number of points
spectrum_filtered_ST = abs(fft(filtered_single_tone))/N; % Compute FFT
fd_st = (0:N-1)*(fs/N); % Frequency vector

% Compute the FFT of DTMF tone
N = length(filtered_dtmf); % Number of points
spectrum_filtered_DTMF = abs(fft(filtered_dtmf))/N; % Compute FFT
fd_DTMF = (0:N-1)*(fs/N); % Frequency vector

subplot(2, 1, 1);plot(fd_st, spectrum_filtered_ST,'m');title("frequency domain of filtered Single Tone");
xlabel("Frequency [HZ]");ylabel("Amplitude");xlim([0 fs/50]);

subplot(2, 1, 2);plot(fd_DTMF, spectrum_filtered_DTMF,'m');title("frequency domain of filtered DTMF Tone");
xlabel("Frequency [HZ]");ylabel("Amplitude");xlim([0 fs/50]);

% %Plot frequency response of the LPF
figure(11);
freqz(b, a, 1024, fs); % Frequency response of the filter
disp("")
title('Frequency Response of the Low-Pass Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
xlim([0 2500])
grid on;




% PB6 %%%%%%%%%%%%%%%%%%
noise_levels=[1 100];
for i = 1:length(noise_levels)
    % Add noise to signal
    noise = noise_levels(i) * randn(size(dsb_dtmf));
    noisy_dsb_dtfm = dsb_dtmf + noise;

    %%% DSB time domain 
    figure(11+i);    
    subplot(4, 2, 1);plot(t, noisy_dsb_dtfm,'r');
    title(['time domain of noisy DSB DTMF tone (Noise Level = ' num2str(noise_levels(i)) ')']);
    xlabel("time [sec]");ylabel("Amplitude");xlim([0 0.01]);
   
    %%%DSB frequecy domain 
    % Compute the FFT of DTMF tone
    spectrum_DSB_DTMF = abs(fft(noisy_dsb_dtfm))/N; % Compute FFT
    subplot(4, 2, 2);plot(fd_DTMF, spectrum_DSB_DTMF,'m');
    title(['frequency domain of noisy DSB DTMF tone (Noise Level = ' num2str(noise_levels(i)) ')']);
    xlabel("Frequency [HZ]");ylabel("Amplitude");xlim([20e3 fs/5]);
    
    %%% diode time domain 
    diode_dtfm=max(0,noisy_dsb_dtfm);
    subplot(4, 2, 3);plot(t, diode_dtfm,'g');
    title(['time domain of Rectified Signal for noisy DTMF Tone (Noise Level = ' num2str(noise_levels(i)) ')']);
    xlabel("time [sec]");ylabel("Amplitude");xlim([0 0.01]);

    %%%diode frequecy domain 
    spectrum_diode_DTMF = abs(fft(diode_dtfm))/N; % Compute FFT
    subplot(4, 2, 4);plot(fd_DTMF, spectrum_diode_DTMF,'m');
    title(['Frequency domain of Rectified Signal for noisy DTMF Tone (Noise Level = ' num2str(noise_levels(i)) ')']);

    xlabel("Frequency [HZ]");ylabel("Amplitude");xlim([0 fs/2]);ylim([0 0.3]);
    
    %%% MIXER time domain 
    %demodulation (Coherent detector)
    mixer_dtmf=diode_dtfm.* carrier;
    subplot(4, 2, 5);plot(t, mixer_dtmf,'k');
    title(['time domain of Mixed noisy Signal for DTMF Signal (Noise Level = ' num2str(noise_levels(i)) ')']);
    xlabel("time [sec]");ylabel("Amplitude");xlim([0 0.01]);
    
    %%%MIXER frequecy domain
    spectrum_mixer_DTMF = abs(fft(mixer_dtmf))/N; % Compute FFT
    subplot(4, 2, 6);plot(fd_DTMF, spectrum_mixer_DTMF,'m');
    title(['Frequency domain of Mixed noisy Signal for DTMF Signal (Noise Level = ' num2str(noise_levels(i)) ')']);
    xlabel("Frequency [HZ]");ylabel("Amplitude");xlim([0 fs/3.75]);ylim([0 0.3]);

    %Apply the LPF to demodulated signals
    filtered_dtmf = filtfilt(b, a, mixer_dtmf);
    %%% filtered massage time domain 
    subplot(4, 2, 7);plot(t, filtered_dtmf,'m');
    title(['time domain of filtered noisy DTMF Tone (Noise Level = ' num2str(noise_levels(i)) ')']);
    xlabel("time [sec]");ylabel("Amplitude");xlim([0 0.01]);

    %%%filtered dtmf frequecy domain 
    spectrum_filtered_DTMF=abs(fft(filtered_dtmf))/N; % Compute FFT
    subplot(4, 2, 8);plot(fd_DTMF, spectrum_filtered_DTMF,'m');
    title(['Frequency domain of filtered noisy DTMF Tone (Noise Level = ' num2str(noise_levels(i)) ')']);
    xlabel("Frequency [HZ]");ylabel("Amplitude");xlim([0 fs/50]);

    %part6_goertzel 
    %Apply Goertzel Algorithm
    N = length(filtered_dtmf);
    y =  abs(goertzel(filtered_dtmf))/N;
    f_dm = (0:N-1)*(fs/N); % Frequency vector

    figure(14);
    subplot(2, 1, i);
    plot(f_dm, y,'-o');
    title(['Goertzel Output (Noise Level = ' num2str(noise_levels(i)) ')']);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    xlim([0 fs/50])
    grid on;
end


