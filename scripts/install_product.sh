#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y curl jq vim unzip tmux


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
