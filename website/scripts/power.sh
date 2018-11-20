#!/bin/bash

if [ "$1" -eq "0" ]; then
   shutdown -r now;
   exit;
fi

if [ "$1" -eq "1" ]; then
   shutdown -h now;
   exit;
fi
