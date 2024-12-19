#!/bin/bash -xe

cfssl gencert -initca ca.json | cfssljson -bare ca
cfssl gencert -ca ca.pem -ca-key ca-key.pem -config cfssl.json -profile=server host1.json | cfssljson -bare host-1-server
cfssl gencert -ca ca.pem -ca-key ca-key.pem -config cfssl.json -profile=client host1.json | cfssljson -bare host-1-client
openssl dhparam 2048 > dh2048.pem
