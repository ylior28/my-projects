import os
import multiprocessing
import threading

THRESHOLD_TEMP = 90
TIME_SEGMENT = 30


def read_file(file_name, all_data, lock):
    """
    Reads data from a file and appends it to the all_data list.
    Uses a lock to ensure thread-safe access to the list.
    """
    try:
        with open(file_name, 'r') as f:
            data = [float(line.strip()) for line in f.readlines() if line.strip()]
            lock.acquire()
            all_data.extend(data)
            lock.release()
    except Exception as e:
        print(f"Error reading file {file_name}: {e}")


def ema(data, alpha=0.3):
    """
    Calculates the Exponential Moving Average (EMA) for a list of data.
    """
    if not data:
        return []

    ema_values = [data[0]]
    ema_value = data[0]

    for value in data[1:]:
        ema_value = alpha * value + (1 - alpha) * ema_value
        ema_values.append(ema_value)

    return ema_values


def statics(ema_results, segment_size=TIME_SEGMENT):
    """
    Computes statistics (mean, min, max) for segments of the EMA results.
    """
    stat_result = []

    for i in range(0, len(ema_results), segment_size):
        res = ema_results[i:i + segment_size]
        if res:  # Avoid division by zero
            res_mean = sum(res) / len(res)
            res_max = max(res)
            res_min = min(res)
            stat_result.append((res_mean, res_min, res_max))

    return stat_result


def process_data_list(data_list):
    """
    Processes a list of data to compute EMA results and segment statistics.
    """
    try:
        if data_list:
            ema_results = ema(data_list)
            segment_statistics = statics(ema_results, segment_size=30)

            return segment_statistics

    except Exception as e:
        print(f"Error in process_data_list for index : {e}")


def excessive_heat(args):
    """
    Checks if the number of segments with mean temperatures above the threshold is greater than half.
    Prints an alert if this is the case.
    """
    segment_idx, statistics_list = args
    count_above_90 = sum(mean > THRESHOLD_TEMP for mean, _, _ in statistics_list)
    if count_above_90 > len(statistics_list) / 2:
        start_time = TIME_SEGMENT * segment_idx
        end_time = TIME_SEGMENT * (segment_idx + 1)
        print(f'Temperature alert detected at timeline {start_time}-{end_time}')


def mean_ranges(args):
    """
    Computes defect counts based on whether sensor means fall outside the range of most other sensors.
    """
    segment_idx, statistics_list = args
    # Initialize counters for each sensor
    defect_counts = [0] * len(statistics_list)

    # Iterate through each sensor's statistics
    for i, (mean, min_val, max_val) in enumerate(statistics_list):
        outside_range_count = 0

        # Check if the mean is outside the range of other sensors
        other_sensors_stats = [stats for j, stats in enumerate(statistics_list) if j != i]

        for _, min_val_other, max_val_other in other_sensors_stats:
            if not (min_val_other <= mean <= max_val_other):
                outside_range_count += 1

        # Update count only if the mean is outside the range of at least two other sensors
        if outside_range_count > len(statistics_list)/2:
            defect_counts[i] += 1

    return defect_counts


def main():
    """
    Main function to read sensor data from files, process it, and identify defective sensors.
    """
    directory = 'Data'

    files = []
    for file in os.listdir(directory):
        full_path = os.path.join(directory, file)
        if os.path.isfile(full_path):
            files.append(file)

    all_data = [[] for _ in files]
    locks = [threading.Lock() for _ in files]

    # Start threads to read data from each file
    # Threading is used here to handle multiple file reads concurrently
    # Since file I/O is typically I/O-bound, threading is suitable for parallelizing this task
    threads = []
    for i, file in enumerate(files):
        full_path = os.path.join(directory, file)
        thread = threading.Thread(target=read_file, args=(full_path, all_data[i], locks[i]))
        threads.append(thread)
        thread.start()

    # Wait for all threads to finish
    for thread in threads:
        thread.join()

    # Process the collected data using multiprocessing
    # Multiprocessing is used here to parallelize CPU-bound tasks such as EMA calculation and statistical processing
    # These tasks can benefit from multi-core processors to improve performance
    num_process = multiprocessing.cpu_count()  # Get the number of CPU cores available on the system

    pool = multiprocessing.Pool(processes=num_process)
    results = pool.map(process_data_list, all_data)
    pool.close()
    pool.join()

    # Aggregate segment statistics by index to dict data structure
    segment_statistics_by_index = {}
    for idx in range(len(results)):  # number of the sensors
        for idx2 in range(len(results[idx])):  # number of the samples/30
            if idx2 not in segment_statistics_by_index:
                segment_statistics_by_index[idx2] = []
            segment_statistics_by_index[idx2].append(results[idx][idx2])

    # Distribute tasks using multiprocessing to handle them concurrently
    # Multiprocessing is used here to parallelize CPU-bound tasks like checking for excessive heat and computing mean ranges
    # This approach leverages multiple CPU cores to improve processing efficiency and performance

    pool = multiprocessing.Pool(processes=num_process)
    pool.map(excessive_heat, segment_statistics_by_index.items())
    mean_sensors_defect = pool.map(mean_ranges, segment_statistics_by_index.items())
    pool.close()
    pool.join()

    defective_lst = []
    defective_sensors = []
    threshold_samples = len(segment_statistics_by_index)/2  # most of the samples time at least 6 in this case

    # Sum the defect counts and determine defective sensors
    summed_list = [sum(x) for x in zip(*mean_sensors_defect)]
    for i in range(len(summed_list)):
        if summed_list[i] >= threshold_samples:
            defective_lst.append(i)
    if defective_lst:
        for i in defective_lst:
            defective_sensors.append(files[i])

        print(f'Sensors {defective_sensors} are suspected for malfunction')


if __name__ == '__main__':
    main()
