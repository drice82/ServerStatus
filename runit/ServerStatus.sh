#!/bin/sh
exec python /ServerStatus/client-linux.py SERVER=$SERVER USER=$USER PASSWORD=$PASSWORD 2>&1
