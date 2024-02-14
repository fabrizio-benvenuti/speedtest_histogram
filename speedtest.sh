#!/bin/bash
while(true);do
	speedtest-cli | grep -e 'Download:' -e 'Upload:' >> ./speedtest.txt
	sudo hwclock --show >> ./speedtest.txt
done
