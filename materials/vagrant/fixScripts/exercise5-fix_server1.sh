#!/bin/bash
cat <<EOF > /home/vagrant/.ssh/config
Host *
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
EOF
