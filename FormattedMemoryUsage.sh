#!/bin/bash

free | grep Mem | awk '{printf("%6s\n", int($3/$2 * 100 + 0.5) "%")}'
