#!/bin/bash

day=$(date +"%a")
if [[ "$day" == "Sat" ]] || [[ "$day" == "Sun" ]]; then
    /sbin/shutdown now > /tmp/shutdown-at.log
fi

shutdown -h 15:30

xinput set-prop "Elo TouchSystems, Inc. Elo TouchSystems 2700 IntelliTouch(r) USB Touchmonitor Interface" "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1

#chromium-browser --kiosk --incognito --app=file:///home/kiosk/welcome.html --password-store=basic &

sleep 5

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker pull docker.io/jhadvig/artropro:latest

# standard startup
amixer -q -D pulse sset Master 100%
docker run -d -p 8080:8080 docker.io/jhadvig/artropro:latest
sleep 3
chromium-browser --kiosk --incognito --app=http://localhost:8080 --password-store=basic &
