#!/usr/bin/env bash

# TODO: my own box will have these utilities and vault

# install utilities we need
which curl jq vim unzip tmux || {
  apt-get update
  apt-get install -y curl jq vim unzip tmux
}

# exit if product is not set
if [ ! "$PRODUCT" ] ; then
  echo "this script needs a variable PRODUCT=product"
  exit 1
fi

VERSION=`curl -sL https://releases.hashicorp.com/${PRODUCT}/index.json | jq -r '.versions[].version' | sort -V | egrep -v 'ent|beta|rc|alpha' | tail -1`

which ${PRODUCT} || {
  cd /usr/local/bin
  wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_linux_amd64.zip
  unzip ${PRODUCT}_${VERSION}_linux_amd64.zip
}
