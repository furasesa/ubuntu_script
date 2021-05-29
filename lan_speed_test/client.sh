#!/bin/bash

echo "./lan_test_client.sh 191.168.43.1"

dd if=/dev/zero bs=1M count=1K | nc -vvn $1 12345
