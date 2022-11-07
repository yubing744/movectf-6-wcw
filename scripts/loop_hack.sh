#!/bin/bash

for ((i=1; i<=100; i ++))
do
	ret=$(sui client call --function find_box --module test_ctf --package 0x95da2e28874775b1e55e263970006da3341407a2 --gas-budget 10000 --args 0xb707abf4460318cee6aae7b790ace7bac2782a2f)
  echo $ret
done