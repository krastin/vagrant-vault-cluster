disable_mlock = true
ui = true

storage "consul" {
  address = "10.10.10.10:8500"
  path = "vault/"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

cluster_addr = "https://10.10.10.11:8201"
api_addr = "https://10.10.10.11:8200"
