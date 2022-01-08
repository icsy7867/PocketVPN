#!/bin/bash

if [ "$1" -eq "0" ]; then
   echo "reboot 0" > /pocket-pipe
   exit;
fi

if [ "$1" -eq "1" ]; then
   echo "shutdown 1" > /pocket-pipe
   exit;
fi
