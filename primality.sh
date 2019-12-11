#!/bin/bash

function generator() {
# number sequence generator
	# generate a string of numbers
	seq "$low" "$high"
}


function sum_factor_three() {
# sum integers in string and modulas

	# sum
	total=$(echo "$candidate"|sed 's/ /+/g'|bc -l)

	# modulas sum by three cleanly
	if [ $((total%3)) -eq 0 ]; then
  		:
	else
  		echo "$candidate"
	fi
}


function factor_seven() {
# there is not arithmatic shortcut for factoring 7...
# this is the only function that actually factors the total string!

	if [ "$((candidate%7))" -eq 0 ]; then
  		:
	else
  		echo "$candidate"
	fi
}


function factor_substring() {
# match the last character of the string

	# check if last character matches an composite number or a number divisable by 5
	# no math
	match=$(echo "${candidate: -1}"|grep -v -E '0|5'|grep -v -E '2|4'|grep -v -E '6|8')

	if [ -z "$match" ]; then
		:
	else 
		echo "$candidate"
	fi
}


function factor_primes() {
# brute force prime factors
	factors=("$(factor "$candidate")")
	if [ "${factors[2]}" ]; then
		:
	else 
		echo "$candidate"
	fi
}


function main() {
	factor_path=$(which factor)
	if [ -z "$factor_path" ]; then
		echo "factor must be installed and is missing"
		echo "sudo apt install -y factor; sudo yum install -y factor"
		exit
	fi

	while read -r candidate; do
		factor_substring "$candidate" &
	done | while read -r candidate; do
		sum_factor_three -r "$candidate"
	done | while read -r candidate; do
		factor_seven "$candidate"
	done | while read -r candidate; do
		factor_primes "$candidate"
	done
}


low=$1
high=$2

[ $# -lt 2 ] && { echo "Usage: $0 low_number high_number"; exit 1; }
if [ "$high" -le "$low" ]; then
	echo "Usage: $0 low_number high_number"; exit 1;
fi

generator|main
