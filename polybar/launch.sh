#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Launch bar
polybar bar1 >>/tmp/polybar1.log 2>&1 &
