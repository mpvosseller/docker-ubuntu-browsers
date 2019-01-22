#!/bin/bash
Xvfb $DISPLAY -screen 0 1280x1024x24 -cc 4 &
sleep 6
x11vnc -forever -passwd 1234 &
fluxbox &
