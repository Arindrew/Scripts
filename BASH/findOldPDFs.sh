#!/bin/bash

find /mnt/NAS/ctptransfer -type d -path /mnt/NAS/ctptransfer/.snapshot -prune -o \
-name "*.pdf" ! -name "*geo.*" -mtime +4015 -exec ls -og --time-style=iso {} \; | cut -d" " -f6 | sort
