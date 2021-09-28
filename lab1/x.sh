#!/bin/bash
man bash | grep -E -o "[[:alpha:]]{4,}" | sort | uniq -c | sort -rnk1 | head -3 | awk '{ print($2) }'
