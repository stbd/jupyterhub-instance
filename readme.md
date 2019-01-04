# Jupyterhub Instance

Minimalistic configuration for running Jupyterhub in Docker. Not the best way and definitely not for production, but if you want to try it out or to run it for yourself, this might be useful.

## User Management

Configuration uses LocalAuthenticator for user management, this means that Juperhub uses the Linux inside the container for authentication. To simplify creating new users, small script is added to configuration so that when new user is created from web UI, it is added to the Linux. Script also sets password for user to be the same as the username. New users should login and start terminal from web UI and change it (as said, not for production).

## State

Notebooks are stored under /notebooks. To have them persist when container is stopped, mount the directory to host.

## HTTPS

Jupyterhub assumes to find key and cert under /srv/jupyterhub, so they should be mounted.

## Example

Example script for running the container can be found in scripts/, take a look and create a new one as needed.

```
./scripts/run-jupyterhub.sh \
    /host/notebooks/ \
    /host/letsencrypt/privkey.pem \
    /host/letsencrypt/fullchain.pem
```