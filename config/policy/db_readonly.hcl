path "database/creds/readonly" {
  capabilities = [ "read" ]
}
path "/sys/leases/renew" {
  capabilities = [ "update" ]
}
path "auth/token/create" {
  capabilities = ["update"]
}