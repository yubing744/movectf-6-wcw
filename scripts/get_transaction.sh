#!/bin/bash

curl 'https://fullnode.devnet.sui.io/' \
  -H 'authority: fullnode.devnet.sui.io' \
  -H 'accept: */*' \
  -H 'accept-language: en-GB,en-US;q=0.9,en;q=0.8,zh-CN;q=0.7,zh;q=0.6' \
  -H 'content-type: application/json' \
  -H 'origin: https://explorer.devnet.sui.io' \
  -H 'referer: https://explorer.devnet.sui.io/' \
  -H 'sec-ch-ua: "Google Chrome";v="107", "Chromium";v="107", "Not=A?Brand";v="24"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-site' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36' \
  --data-raw "{\"method\":\"sui_getTransaction\",\"jsonrpc\":\"2.0\",\"params\":[$1],\"id\":\"52c4ebd1-b979-4758-bca7-2172989923df\"}" \
  --compressed