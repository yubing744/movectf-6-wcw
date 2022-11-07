
.PHONY: build test publish hack

install-deps:
	sudo apt-get install jq

build:
	sui move build

test:
	sui move test

publish:
	sui client publish --gas-budget 100000

get_box:
	sui client call --function try_get_treasury_box --module test_ctf --package 0xfa06153816c2171ff2afe3ae1163240e9807f136 --gas-budget 1000000 --args 0xfe06e67f83046cad00576fb707972d2fd796ab6b

hack:
	sui client call --function get_flag --module test_ctf --package 0xfa06153816c2171ff2afe3ae1163240e9807f136 --gas-budget 1000000 --args 0xfe06e67f83046cad00576fb707972d2fd796ab6b
