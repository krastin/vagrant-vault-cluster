disable_mlock = true
ui = true

storage "file" {
  path = "/home/vagrant/vault-data"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

seal "transit" {
  address = "http://127.0.0.1:18200"
  token = "<SECRET>" # edit this and then init e.g. $> vault operator init -recovery-shares=3 -recovery-threshold=2
  disable_renewal = "false"
  key_name = "autounseal"
  mount_path = "transit/"
  tls_skip_verify = "true"
}