#!/bin/bash

generator () {
  seq 0 100000000|sed 's/ /\n/g';
}

function even () {
  # send odd numbers back	
  if [ $((req%2)) -eq 0 ]; then
    res=even
  else
    res=odd
    echo $req
  fi
  #echo "$req $res"|grep -v even;
}


function three () {
  # send number not divisable by three back
  total=`echo $req|sed 's/ /+/g'|bc -l`;

  if [ $((total%3)) -eq 0 ]; then
    res=divisable
  else
    res=indivisable
    echo $req
  fi
  #echo "$total three"|grep -v three;

}

function five () {
  # send odd numbers back	
  if [ $((req%5)) -eq 0 ]; then
    res=divisable
  else
    res=indivisable
    echo $req
  fi
  #echo "$req five"|grep -v five;

}

function seven () {
  if [ $((req%7)) -eq 0 ]; then
    res=divisable
  else
    res=indivisable
    echo $req
  fi
}


stringLast () {

  candidate="`echo $last|grep -v -E '0|2|4|5|6|8'`";
  if [ -z $candidate ]; then
    res=notPrime;
  else 
    res=maybe;
    echo $req
  fi

}

workflow () {

  while read req; do
    # get the last number of the string
    last="${req: -1}";
    # even $last
    stringLast $last $req
  done|
    while read req; do
      last="${req: -1}";
      even $last
    done|
      while read req; do
        three $req
      done|
        while read req; do
          five $req;
        done|
         while read req; do
           seven $req;
         done

}
generator|workflow #|wc -l
