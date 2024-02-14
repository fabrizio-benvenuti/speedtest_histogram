#!/bin/bash
awk '/Download:/ {print $2}' speedtest.txt > download_speeds.txt
awk '/Upload:/ {print $2}' speedtest.txt > upload_speeds.txt
gnuplot -persist <<-EOFMarker
    set terminal png size 800,600
    set output 'speeds_histogram.png'
    set title "Download and Upload Speeds Histogram"
    set xlabel "Speed (Mbit/s)"
    set ylabel "Frequency"
    binwidth=5
    bin(x,width)=width*floor(x/width) + binwidth/2.0
    plot 'download_speeds.txt' using (bin(\$1,binwidth)):(1.0) smooth freq with boxes title "Download", \
         'upload_speeds.txt' using (bin(\$1,binwidth)):(1.0) smooth freq with boxes title "Upload"
EOFMarker
open ./speeds_histogram.png
rm upload_speeds.txt download_speeds.txt