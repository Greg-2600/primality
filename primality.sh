#!/bin/bash

function generator() {
# number sequence generator
	# high and low range
	high="1000000000"
	low="10"

	# generate a string of numbers
	seq $low $high 
}


function sum_factor_three() {
# sum integers in string and modulas

	# sum
	total=$(echo $candidate|sed 's/ /+/g'|bc -l)

	# modulas sum by three cleanly
	if [ $((total%3)) -eq 0 ]; then
  		:
	else
  		echo $candidate
	fi
}


function factor_seven() {
# there is not arithmatic shortcut for factoring 7...
# this is the only function that actually factors the total string!

	if [ $((candidate%7)) -eq 0 ]; then
  		:
	else
  		echo $candidate
	fi
}


function factor_substring() {
# match the last character of the string

	# check if last character matches an composite number or a number divisable by 5
	# no math
	match=$(echo ${candidate: -1}|grep -v -E '0|5'|grep -v -E '2|4'|grep -v -E '6|8')

	if [ -z $match ]; then
		:
	else 
		echo $candidate
	fi
}


function factor_primes() {
# brute force prime factors
	factors=($(factor $candidate))
	if [ ${factors[2]} ]; then
		:
	else 
		echo $candidate
	fi
}


function main() {

	while read candidate; do
		factor_substring $candidate &
	done | while read candidate; do
		sum_factor_three $candidate
	done | while read candidate; do
		factor_seven $candidate
	done | while read candidate; do
		factor_primes $candidate
	done
}


generator|main
