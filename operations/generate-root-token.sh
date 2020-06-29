# create a new one-time password
# vault operator generate-root -generate-otp > otp.txt

# create a new nonce using the earlier otp
# vault operator generate-root -init -otp=$(cat otp.txt) -format=json | jq -r ".nonce" > nonce.txt

# run the following for each unseal key holder until threshold is reached
# vault operator generate-root -nonce=$(cat nonce.txt) $(grep 'Key 1:' key.txt | awk '{print $NF}')