#!/bin/bash

function generator() {
# number sequence generator
  # high and low range
  high="10000"
  low="1000"

  # generate a string of numbers
  seq $low $high 
}

function sum_factor_three() {
# sum integers in string and modulas

  # sum
  total=$(echo $req|sed 's/ /+/g'|bc -l);

  # modulas sum by three cleanly
  if [ $((total%3)) -eq 0 ]; then
    : # noop
  else
    echo $req # return string
  fi
}

function factor_seven() {
# there is not arithmatic shortcut for factoring 7...
# this is the only function that actually factors the total string!

  if [ $((req%7)) -eq 0 ]; then
    : # noop
  else
    echo $req # return string
  fi
}

function factor_substring() {
# match the last character of the string

  # substring last character
  last="${req: -1}";

  # check if last character matchs an composite number or a number divisable by 5
  # NO MATH
  candidate=$(echo $last|grep -v -E '0|2|4|5|6|8');

  if [ -z $candidate ]; then
    : # noop
  else 
    echo $req # return string
  fi
}

function main() {

  while read req; do
    factor_substring $req  &
  done| while read req; do
      sum_factor_three $req &
    done| while read req; do
        factor_seven $req; 
      done
}
generator|main
