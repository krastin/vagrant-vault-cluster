path "kv/data/exercise/*" {
   capabilities = ["create", "read", "update"]
}

path "kv/data/exercise/team-admin" {
   capabilities = ["deny"]
}

path "sys/policies/acl" {
    capabilities = ["read"]
}

path "sys/auth" {
    capabilities = ["read"]
}