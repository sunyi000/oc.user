#!/bin/bash

if [ -d /proc/driver/nvidia ]; then
       echo /proc/driver/nvidia exists
       # suppose there is an gpu 
       if [ -x /usr/bin/nvidia-smi ]; then
	       	echo command line /usr/bin/nvidia-smi found
       		/usr/bin/nvidia-smi --query-gpu=gpu_name,gpu_bus_id,vbios_version --format=csv
        	if [ $? -eq 0 ]; then
			echo "ABCDESKTOP_USE_X11_NVIDIA=${ABCDESKTOP_USE_X11_NVIDIA}"
			if [ ! -z ${ABCDESKTOP_USE_X11_NVIDIA} ]; then 
				echo "${ABCDESKTOP_USE_X11_NVIDIA} is set"
				exec /composer/xserver-nvidia.sh
			        exit 0
			fi
		fi
	fi
fi

# fallback to tigervnc
exec /composer/tigervnc.sh
 
