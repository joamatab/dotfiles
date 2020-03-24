#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Launch bar
polybar default >>/tmp/polybar1.log 2>&1 &
