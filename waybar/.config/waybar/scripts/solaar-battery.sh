#!/bin/bash
solaar show 2>/dev/null | grep -m 1 -Eo 'Battery: [0-9]+%' | awk '{print $2}'
