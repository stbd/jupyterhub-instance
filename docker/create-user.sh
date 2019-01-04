#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "Usage: [username]"
    exit 1
fi

username=$1
path_notebook=/notebooks/$username

adduser \
    -q \
    --gecos "" \
    --disabled-password \
    "$username"

adduser "$username" sudo
echo "$username:$username" | chpasswd

mkdir -p "$path_notebook"
chown "$username:$username" "$path_notebook"
