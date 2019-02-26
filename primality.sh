#!/bin/bash

function generator() {
# number sequence generator
  # accept an argument for high and low range
  low="0"
  high="1000"

  # generate a space dillemited string of numbers
  seq $low $high|sed 's/ /\n/g'
}

function even() {
# determine if a number is even or odd
  # 
  if [ $((req%2)) -eq 0 ]; then
    : # noop
  else
    # return odd numbers back
    echo $req
  fi
}

function three() {
# determine if a number is even or odd

  # sum total string
  total=$(echo $req|sed 's/ /+/g'|bc -l);

  # divide sum by 3 cleanly
  if [ $((total%3)) -eq 0 ]; then
    : # noop
  else
    # return number not divisable by three back
    echo $req
  fi
}

function five() {
  if [ $((req%5)) -eq 0 ]; then
    : # noop
  else
    # return numbers not divisable by 5 back
    echo $req
  fi
}

function seven() {
  if [ $((req%7)) -eq 0 ]; then
    : # noop
  else
    # return numbers not divisable by seven
    echo $req
  fi
}


function stringLast() {
# match the last character of the string

  # substring last character
  last="${req: -1}";
  # check if last character matchs an even number or a number divisable by 5
  # NO MATH
  candidate=$(echo $last|grep -v -E '0|2|4|5|6|8');

  if [ -z $candidate ]; then
    : # noop
  else 
    echo $req
  fi

}

workflow () {

  while read req; do
    # get the last number of the string
    # even $last
    stringLast $req
  done|
    #while read req; do
    #  last="${req: -1}";
    #  even $last
    #done|
      while read req; do
        three $req
      done|
    #    while read req; do
    #      five $req;
    #    done|
         while read req; do
           seven $req;
         done

}
generator|workflow #|wc -l
#generator|workflow|wc -l
