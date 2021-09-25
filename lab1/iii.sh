#!/bin/nash
echo "1.) Start nano"
echo "2.) Start vim"
echo "3.) Start links"
echo "4.) Close menu"
read value
case $value in
    1) exec nano;;
    2) exec vim;;
    3) exec links;;
    4) echo "Exit menu";;
    *) echo "Uncorrect input";;
esac
