#!/usr/bin/env bash

vault secrets enable transit
vault write -f transit/keys/autounseal
vault policy write autounseal /vagrant/config/autounseal.policy

