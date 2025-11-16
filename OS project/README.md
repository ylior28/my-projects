🌡️ Temperature Sensor Monitoring & Fault Detection

This project implements a multi-sensor temperature monitoring system that reads sensor data from files, calculates statistics using Exponential Moving Average (EMA), detects overheating events, and identifies malfunctioning sensors using parallel processing.

⚙️ Technologies

•	Python (file I/O, threading, multiprocessing)

•	Multithreading for concurrent file reading (I/O-bound tasks)

•	Multiprocessing for CPU-intensive tasks (EMA, statistics, defect detection)

•	EMA Calculation for smoothing noisy sensor readings

•	Segmented Statistics (mean, min, max) for 30-minute intervals

✨ Project Highlights

•	Reads temperature data from multiple sensors concurrently using threads.

•	Computes EMA to reduce noise in temperature readings.

•	Segments data into fixed 30-minute intervals and calculates mean, min, max for each segment.

•	Detects overheating events if average segment temperatures exceed 90°C in the majority of sensors.

•	Identifies malfunctioning sensors based on deviation from other sensors’ ranges.

•	Fully parallelized using Python's multiprocessing to handle CPU-bound analysis efficiently.

📊 Results

•	Successfully detected temperature alerts in simulated sensor data.

•	Accurately flagged sensors with readings inconsistent with the majority.

•	Demonstrated the efficiency gain of threading for file I/O and multiprocessing for computations.

📚 Key Learnings

•	Efficient concurrent programming using threads and processes.

•	Practical use of Exponential Moving Average for sensor data smoothing.

•	Techniques for fault detection in multi-sensor systems.

•	Managing data segmentation and parallel aggregation of statistics.

