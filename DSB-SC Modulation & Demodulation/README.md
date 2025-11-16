📡 DSB-SC Modulation & Demodulation Project
This project demonstrates Double Sideband Suppressed Carrier (DSB-SC) modulation and demodulation using MATLAB.
It includes the complete workflow of generating signals, modulating them, demodulating them using coherent detection, applying filtering, adding noise, and detecting DTMF frequencies using the Goertzel algorithm.

⚙️ Technologies

•	MATLAB

•	FFT (Fast Fourier Transform)

•	Butterworth Low-Pass Filter

•	Goertzel Algorithm (DTMF detection)

✨ Project Highlights

•	Generation of baseband signals: Single-Tone and DTMF

•	DSB-SC modulation using a cosine carrier

•	Half-wave rectification to model diode detection

•	Coherent demodulation using the original carrier

•	Reconstruction of message signal using a Butterworth LPF

•	Noise injection and performance analysis under different SNR levels

•	Frequency detection using the Goertzel algorithm

📊 Results

•	Successful demonstration of DSB-SC modulation in time and frequency domain

•	Recovery of the baseband signal through rectification + coherent mixing + LPF

•	Analysis of noise effects on demodulation quality

•	Evaluation of Goertzel accuracy under noisy conditions

📚 Key Learnings

•	Principles of amplitude modulation (DSB-SC)

•	Practical use of FFT for spectrum analysis

•	Filter design and implementation in MATLAB

•	Envelope detection and coherent demodulation
•	Frequency detection using Goertzel
