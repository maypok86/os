#!/bin/bash
grep -o -r -h -s -E "[[:alnum:]+]+@[[:alnum:]]+.[[:alnum:]]+" /etc | sort | uniq | awk '{ printf("%s, ",$0) }' > emails.lst
