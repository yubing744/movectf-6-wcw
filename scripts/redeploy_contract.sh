#!/bin/bash

curl 'http://8.218.7.246:10005/contract' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8,zh-CN;q=0.7,zh;q=0.6' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Origin: http://8.218.7.246:10005' \
  -H 'Referer: http://8.218.7.246:10005/' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36' \
  -H 'X-REQUEST-UUID: ad98f576-e3d7-4d0b-bfdf-e54456fe86b9' \
  --data-raw '{}' \
  --compressed \
  --insecure