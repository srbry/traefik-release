#!/bin/sh

git submodule update --init

golang_file=go1.9.4.linux-amd64.tar.gz

if [ -f "src/golang/${golang_file}" ]; then
  echo "Golang tar already downloaded"
else
  curl "https://dl.google.com/go/${golang_file}" -o "src/golang/${golang_file}"
fi

consul_version=0.7.4
consul_file="consul_${consul_version}_linux_amd64.zip"

if [ -f "src/consul/${consul_file}" ]; then
  echo "Consul zip already downloaded"
else
  curl "https://releases.hashicorp.com/consul/${consul_version}/${consul_file}" -o "src/consul/${consul_file}"
fi

bosh create-release --force
