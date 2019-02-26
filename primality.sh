#!/bin/bash

function generator() {
# number sequence generator
  # high and low range
  high="2000"
  low="1000"

  # generate a string of numbers
  seq $low $high 
}

function sum_factor_three() {
# sum integers in string and modulas

  # sum
  total=$(echo $candidate|sed 's/ /+/g'|bc -l);

  # modulas sum by three cleanly
  if [ $((total%3)) -eq 0 ]; then
    : # noop
  else
    echo $candidate # return string
  fi
}

function factor_seven() {
# there is not arithmatic shortcut for factoring 7...
# this is the only function that actually factors the total string!

  if [ $((candidate%7)) -eq 0 ]; then
    : # noop
  else
    echo $candidate # return string
  fi
}

function factor_substring() {
# match the last character of the string

  # substring last character
  last="${candidate:-1}";

  # check if last character matches an composite number or a number divisable by 5
  # NO MATH
  match=$(echo $last|grep -v -E '0|2|4|5|6|8');

  if [ -z $match ]; then
    : # noop
  else 
    echo $match # return candidate
    
  fi
}

function main() {

  while read candidate; do
    factor_substring $candidate  &
  done | while read candidate; do
    sum_factor_three $candidate &
    done | while read candidate; do
      factor_seven $candidate
      done
}
generator|main
