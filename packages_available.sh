#!/bin/bash

UPDATE_COUNT=$(checkupdates 2>/dev/null | wc -l)

[[ ${UPDATE_COUNT} > 0 ]] && {
    echo " ${UPDATE_COUNT}"
} || {
    echo ""
}
