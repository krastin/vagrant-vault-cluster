# run this on the transit vault cluster
# vault write -f transit/keys/autounseal/rotate

# then view key version after rotate
# vault read transit/keys/autounseal