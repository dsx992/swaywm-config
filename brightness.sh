# vars
brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
max=$(cat /sys/class/backlight/intel_backlight/max_brightness)
steps=10

let increment=$max/$steps

if [ $# -ne 0 ]     # if argc != 0
then
    # up or down
    if [ $1 == "down" ]
    then
        increment=-$increment
    elif [ $1 == "up" ]
    then
        # does nothing - needs not negation
        increment=$increment
    else
        increment=0
    fi
else
    increment=0
fi

brightness=$(expr $brightness + $increment)

if [ $brightness -ge $max ]
then
    brightness=$max
elif [ $brightness -lt 0 ]
then
    brightness=0
fi
echo $brightness
echo $brightness > /sys/class/backlight/intel_backlight/brightness

