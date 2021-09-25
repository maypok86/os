#!/bin/bash
man bash | sed 's/\s/\n/g' | sort | uniq -c | sort -rn | awk '{ if (length($2) >= 4) print($2) }' | head -3
