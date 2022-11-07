
.PHONY: build test publish hack

build:
	sui move build

test:
	sui move test

publish:
	sui client publish --gas-budget 100000

hack:
	sui client call --function get_flag --module hack --package 0xf11c20731dde8f546cb5f3dc1b47042e419a4b5a --gas-budget 100000 --args 0x6bf75aa353945025d12ae7484807748699bee5ec

encode_flag:
	python ./encode_flag.py

decode_flag:
	python ./decode_flag.py