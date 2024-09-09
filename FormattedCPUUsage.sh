#!/bin/bash

top -bn1 | grep "Cpu(s)" | \
          sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
          awk '{printf("%6s\n", int(100 - $1 + 0.5) "%")}'
