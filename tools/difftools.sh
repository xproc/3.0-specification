#!/bin/bash

if [ "$DIFFPASSPHRASE" != "" ]; then
    openssl aes-256-cbc -d -k $DIFFPASSPHRASE -in tools/difftools.enc -out diff.tar.gz
    tar zxf diff.tar.gz
    rm -f diff.tar.gz
fi
