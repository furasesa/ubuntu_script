#!/bin/bash

echo "port 12345"
nc -vvlnp 12345 >/dev/null
