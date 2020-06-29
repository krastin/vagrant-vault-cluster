# initiate a rekey and create a nonce
# vault operator rekey -init -key-shares=3 -key-threshold=2 -format=json | jq -r ".nonce" > nonce.txt

# or this way if using auto-unseal
# vault operator rekey -init -key-shares=3 -key-threshold=2 -target="recovery" -format=json | jq -r ".nonce" > nonce.txt

# execute the rekey operation
# vault operator rekey -nonce=$(cat nonce.txt) $(grep 'Key 1:' key.txt | awk '{print $NF}')

