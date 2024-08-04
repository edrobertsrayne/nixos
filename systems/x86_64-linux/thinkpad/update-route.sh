#!/bin/bash

interface=$1
event=$2

if [ "$interface" == "wlp61s0" ] && [ "$event" == "up" ]; then
    # Get the new gateway for the interface
    new_gateway=$(ip route show dev wlp61s0 | grep 'default via' | awk '{print $3}')

    if [ -n "$new_gateway" ]; then
        # Remove the old route if it exists
        ip route del 82.13.72.26 dev wlp61s0

        # Add the new route with the updated gateway
        ip route add 82.13.72.26 via $new_gateway dev wlp61s0
    fi
fi

