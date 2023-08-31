#!/bin/bash
set -e

cp /vagrant/server2_id_rsa /home/vagrant/.ssh/id_rsa
cp /vagrant/server2_id_rsa.pub /home/vagrant/.ssh/id_rsa.pub
cat /vagrant/server1_vagrant_id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

chown -R vagrant:vagrant /home/vagrant/.ssh/

cp /vagrant/server2_root_id_rsa /root/.ssh/id_rsa
cp /vagrant/server2_root_id_rsa.pub /root/.ssh/id_rsa.pub

cat /vagrant/server1_root_id_rsa.pub >> /root/.ssh/authorized_keys

chmod 700 /root/.ssh
chmod 600 /root/.ssh/id_rsa
chmod 644 /root/.ssh/id_rsa.pub

# vagrant user
cat <<EOF >/home/vagrant/.ssh/config
Host *
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
EOF

# root
cat <<EOF >/root/.ssh/config
Host *
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
EOF

echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
echo "PermitRootLogin prohibit-password" >> /etc/ssh/sshd_config
systemctl restart sshd


rm -f /vagrant/*rsa*