read -r -d '' CREATION_STATEMENTS << EOM
CREATE ROLE "{{name}}" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';
REVOKE ALL ON SCHEMA public FROM public, "{{name}}";
GRANT SELECT ON ALL TABLES IN SCHEMA public TO "{{name}}";
EOM

# create a database policy that is read-only
# vault policy write db_readonly /vagrant/config/policy/db_readonly.hcl

# enable a database secret engine
# vault secrets enable database

# configure a sample postresql database running on localhost
# vault write database/config/postgresql plugin_name=postgresql-database-plugin allowed_roles=readonly connection_url=postgresql://postgres@localhost/myapp
# vault write database/roles/readonly db_name=postgresql creation_statements="$CREATION_STATEMENTS" default_ttl=1h max_ttl=24h

# set up approle
# vault auth enable approle
# vault write auth/approle/role/apps policies="db_readonly"
# echo $(vault read -format=json auth/approle/role/apps/role-id | jq  -r '.data.role_id') > roleID
# echo $(vault write -f -format=json auth/approle/role/apps/secret-id | jq -r '.data.secret_id') > secretID

# sample agent config for approle
read -r -d '' AGENT_CONFIG << EOM
exit_after_auth = false
pid_file = "./pidfile"
auto_auth {
    method "approle" {
        mount_path = "auth/approle"
        config = {
            role_id_file_path = "roleID"
            secret_id_file_path = "secretID"
            remove_secret_id_file_after_reading = false
        }
    }
    sink "file" {
        config = {
            path = "/home/vagrant/approleToken"
        }
    }
}
cache {
    use_auto_auth_token = true
}
listener "tcp" {
    address = "127.0.0.1:8007"
    tls_disable = true
}
vault {
    address = "http://127.0.0.1:8200"
}
EOM

