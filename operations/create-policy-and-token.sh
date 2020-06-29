# create policy
# vault policy write sample-policy-1 /vagrant/config/policy/sample-policy.hcl

# create token and assign policy
# vault token create -policy="sample-policy-1"