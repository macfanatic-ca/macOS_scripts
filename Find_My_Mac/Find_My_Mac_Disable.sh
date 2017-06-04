#!/bin/bash
# Remove Find My Mac token from nvram
/usr/sbin/nvram -d fmm-mobileme-token-FMM
if [ $? == 0 ]; then
  echo "Find My Mac token removed"
  exit 0
else
  echo "Error removing Find My Mac token"
  exit 1
fi
