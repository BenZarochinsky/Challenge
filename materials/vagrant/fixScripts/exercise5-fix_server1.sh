#!/bin/bash
set -e


# vagrant server1
echo yes | ssh-keygen -f /home/vagrant/.ssh/id_rsa -N ''
chown -R vagrant:vagrant /home/vagrant/.ssh/
cp /home/vagrant/.ssh/id_rsa.pub /vagrant/server1_vagrant_id_rsa.pub

# vagrant server2
echo yes | ssh-keygen -f /home/vagrant/.ssh/server2_id_rsa -N ''
cp /home/vagrant/.ssh/server2_id_rsa /home/vagrant/.ssh/server2_id_rsa.pub /vagrant/
cat /home/vagrant/.ssh/server2_id_rsa.pub >> /home/vagrant/.ssh/authorized_keys


# root user server1
echo yes | ssh-keygen -f /root/.ssh/id_rsa -N ''
cp /root/.ssh/id_rsa.pub /vagrant/server1_root_id_rsa.pub

# root user server2
echo yes | ssh-keygen -f /root/.ssh/server2_root_id_rsa -N ''
cp /root/.ssh/server2_root_id_rsa /root/.ssh/server2_root_id_rsa.pub /vagrant/
cat /root/.ssh/server2_root_id_rsa.pub >> /root/.ssh/authorized_keys

chmod 700 /root/.ssh
chmod 600 /root/.ssh/id_rsa
chmod 644 /root/.ssh/id_rsa.pub

# vagrant user
cat <<EOF >/home/vagrant/.ssh/config
Host *
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
EOF
cat <<EOF >/root/.ssh/config
Host *
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
EOF

echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
echo "PermitRootLogin prohibit-password" >> /etc/ssh/sshd_config
systemctl restart sshd