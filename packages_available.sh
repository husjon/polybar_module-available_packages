#!/bin/bash

case $1 in
    notify)
        notify-send -a checkupdates "checkupdates" "$(cat < /tmp/checkupdates | awk '{printf "%30-s %s\n", $1,$4}')";;
    *)
        UPDATE_COUNT=$(checkupdates | tee /tmp/checkupdates | wc -l)

        if [[ ${UPDATE_COUNT} -gt 0 ]]; then
            echo " ${UPDATE_COUNT}"
        else
            echo ""
        fi
        ;;
esac

