#!/bin/bash
#
#[root@vortex-nether booker-x9]# ls /sys/class/drm/card0/device/hwmon/hwmon1/
#device      name   pwm1         pwm1_max  subsystem   temp1_crit_hyst  uevent
#fan1_input  power  pwm1_enable  pwm1_min  temp1_crit  temp1_input
#
#
vga_device=/sys/class/drm/card0/device
pwm=$vga_device/hwmon/hwmon1/pwm1
perf_level=$vga_device/power_dpm_force_performance_level
gpu_clock=$vga_device/pp_sclk_od
vram_clock=$vga_device/pp_mclk_od
current_cpu_clock=$(cat $gpu_clock)
#amdgpu_info=$(cat /sys/kernel/debug/dri/0/amdgpu_pm_info | tail -15 | head -12)	

print_monitoring () {
echo "$(cat /sys/kernel/debug/dri/0/amdgpu_pm_info | tail -15 | head -12)";
sleep 0.5;
};


case $1 in

		-g|--game)
		echo "***ENABLING HIGH PERFORMANCE***";
		echo "high" > $perf_level;
		echo "130" > $pwm;
		echo "GPU-FAN-RPM SET TO 50% POWER";;
		---mining)
		echo "***WARNING*** TOTAL PERFORMANCE!";
		echo "high" > $perf_level;
		echo "200" > $pwm;;
		-o|--office)
		echo "***EASY OFFICE USAGE***";
		echo "auto" > $perf_level;
		echo "50" > $pwm;;
		-h|--help)
		echo "Enhance GPU Performance for YOUR needs";
		echo "-c --core 	Read or Set VCORE clock";
		echo "-m --memory 	Read or Set VRAM clock";
		echo "-o --office 	Setting Office-Use Profile";
		echo "-g --game		Setting Gaming Profile";
		echo "--mining		Setting Mining Profile";
		echo "--monitoring	Monitoring GPU Infos";;
		-c|--core)
		echo "***CAUTION! SETTING NEW CLOCK PARAMETER***";
		echo "$2" > $gpu_clock;
		echo "CPU CORE CLOCK IS NOW AT "$current_gpu_clock"";;
                --monitoring)
                while true; do print_monitoring;

done

esac



