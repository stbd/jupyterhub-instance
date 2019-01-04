from jupyterhub/jupyterhub

run apt-get update && apt-get install \
                              sudo \
                              nano

# Install dependencies
copy dependencies.txt /dependencies.txt
run pip install -r /dependencies.txt
run python -m bash_kernel.install

# Create files that are mounted at "docker run"
run touch /srv/jupyterhub/jupyterhub_config.py
run touch /srv/jupyterhub/key.cert
run touch /srv/jupyterhub/cert.cert

copy create-user.sh /srv/jupyterhub/create-user.sh

# Root user, when accessed from web terminal, does not have Conda on path
run echo "PATH=/opt/conda/bin:\$PATH" >> /root/.bashrc

# Directory for notebooks
run mkdir /notebooks

cmd ["jupyterhub", "--ssl-key", "/srv/jupyterhub/key.cert", "--ssl-cert", "/srv/jupyterhub/cert.cert" ]
