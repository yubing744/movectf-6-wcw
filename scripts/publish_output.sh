#!/bin/bash

cat << EOF
INCLUDING DEPENDENCY MoveStdlib
INCLUDING DEPENDENCY Sui
INCLUDING DEPENDENCY ctf
BUILDING ctf_wcw
----- Certificate ----
Transaction Hash: OfH+5HW3z9LNrQzJzpNsPNZhped8uFa50eHeSpu1K7U=
Transaction Signature: AA==@OQ+7TZqkXDtLaTF66q9m3yCeoIJeDvMRqArwFjy6k7lBBrs//sWtIg3ElFZjEwTd4sBSYB1AcZlUKDJ3K1tTBw==@WvI9eNeVO9HjpUax5oW3WQdd9c260FAQnDp4+lAthEs=
Signed Authorities Bitmap: RoaringBitmap<[0, 1, 3]>
Transaction Kind : Publish
----- Transaction Effects ----
Status : Success
Created Objects:
  - ID: 0xf2aa8eac501ed1ddf0d299ccdeabc01aa695d5cb , Owner: Immutable
Mutated Objects:
  - ID: 0x2531433e11c5cb41de0124a84d718669385d98f9 , Owner: Account Address ( 0x2f443fbc4f70c9f4921ae38cabb19c004d62f3aa )
EOF
