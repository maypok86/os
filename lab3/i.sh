#!/bin/bash

success="catalog test was created successfully"
host="www.net_nikogo.ru"

rm -rf ~/test
mkdir ~/test && { echo $success >> ~/report; touch ~/test/$(date +"%F_%R"); }
ping -c 1 $host 2>/dev/null || echo "Failed ping" >> ~/report
