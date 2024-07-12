battery=$(cat /sys/class/power_supply/BAT0/capacity )
battery_remaining=$(acpi -b | awk '{print $5}')
battery_state=$(cat /sys/class/power_supply/BAT0/status)

date_formatted=$(date "+%A %F ")
time_now=$(date "+%H:%M:%S")

## samle output: amixer get Master
# Simple mixer control 'Master',0
#   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
#   Playback channels: Mono
#   Limits: Playback 0 - 87
#   Mono: Playback 0 [0%] [-65.25dB] [on]

volume=$(amixer get Master | grep dB | awk '{print $4}' | cut -d '[' -f 2 | cut -d ']' -f 1)

if [[ $battery_state == "Discharging" ]]
then
    battery_state=""
fi

echo VOLUME: $volume \| BAT: $battery, $battery_remaining  $battery_state \| $date_formatted  $time_now
