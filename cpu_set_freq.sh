#!/bin/bash
cpu_index=0
nproc=`nproc`
low_diff=300000
echo $cpu_index ${nproc}
while (($cpu_index < $nproc))
do
    max_freq=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq`
    min_freq=$[$max_freq-$low_diff]
    echo "cpu_index:$cpu_index total_cpu:${nproc} min_freq:$min_freq max_freq:$max_freq"
    sudo cpufreq-set -c $cpu_index -g performance -d $min_freq -u $max_freq
    #sudo cpufreq-set -c $cpu_index -d 500000 -u 800000
    ((cpu_index++))
done
