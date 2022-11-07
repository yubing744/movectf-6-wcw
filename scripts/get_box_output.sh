#!/bin/bash

cat << EOF
----- Certificate ----
Transaction Hash: rplo8vkf+KAlx76+ZGD/GCRk0+FfvwyDnvn+LXx5e2U=
Transaction Signature: AA==@K9C2gvK+/kMME2eNY6vy8AaSmOYUrNEzihbd/wSlCH8nYktQ/Y0pHWYejL7GASBXFoPZs7jcs1VzbRg+3ifbDg==@WvI9eNeVO9HjpUax5oW3WQdd9c260FAQnDp4+lAthEs=
Signed Authorities Bitmap: RoaringBitmap<[0, 1, 3]>
Transaction Kind : Call
Package ID : 0x16501105e3b6f37744c33de30f9a2686d9871d14
Module : test_ctf
Function : try_get_treasury_box
Arguments : ["0x2c11de51dbceba29c99a93fd9a4e9b7020ddd397"]
Type Arguments : []
----- Transaction Effects ----
Status : Success
Created Objects:
  - ID: 0x139431b1bd1ea48af62d2d9642663779e5713c81 , Owner: Account Address ( 0x2f443fbc4f70c9f4921ae38cabb19c004d62f3aa )
Mutated Objects:
  - ID: 0x2531433e11c5cb41de0124a84d718669385d98f9 , Owner: Account Address ( 0x2f443fbc4f70c9f4921ae38cabb19c004d62f3aa )
  - ID: 0x2c11de51dbceba29c99a93fd9a4e9b7020ddd397 , Owner: Shared
EOF
