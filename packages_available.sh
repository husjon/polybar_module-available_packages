#!/bin/bash

TIMEOUT=${1:-60}
(( TIMEOUT < 60 )) && TIMEOUT=60

UPDATES_FILE=/tmp/checkupdates

check() {
    find \
        ${UPDATES_FILE} \
        -mmin -${TIMEOUT} \
        -and \
        -size +10c \
        2> /dev/null | grep -q . && return

    echo " Checking"
    checkupdates > "${UPDATES_FILE}"
}

case $1 in
    notify)
        #notify-send -a checkupdates "checkupdates" "$(cat < /tmp/checkupdates | awk '{printf "%30-s %s\n", $1,$4}')";;
        awk '{printf "%50-s %s\n", $1,$4}' "$UPDATES_FILE{}" | rofi -lines 20 -dmenu -p "Package"
        ;;
    *)
        check
        UPDATE_COUNT=$(cat "${UPDATES_FILE}" | wc -l)

        if [[ ${UPDATE_COUNT} -gt 0 ]]; then
            echo " ${UPDATE_COUNT}"
        else
            echo ""
        fi
        ;;
esac
