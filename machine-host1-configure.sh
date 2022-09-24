# run
# log into host1
# download and run this script
#   curl -o - https://raw.githubusercontent.com/nickhardiman/machine-host1/main/machine-host1-configure.sh | bash -x

# SSH security
# if SSH service on this box is accessible to the Internet
# use key pairs only, disable password login
# for more information, see
#   man sshd_config
#echo "AuthenticationMethods publickey" >> /etc/ssh/sshd_config
 
# install Ansible
sudo dnf install --assumeyes ansible-core
# install Ansible libvirt collection
sudo ansible-galaxy collection install community.libvirt --collections-path /usr/share/ansible/collections

# !!! move this to machine-host1-configure.yml
# install git
sudo dnf install --assumeyes git
git config --global user.name         "Nick Hardiman"
git config --global user.email        nick@email-domain.com
git config --global github.user       nick
git config --global push.default      simple
# default timeout is 900 seconds (https://git-scm.com/docs/git-credential-cache)
git config --global credential.helper 'cache --timeout=1200'
git config --global pull.rebase false

# enable nested virtualization? 
# /etc/modprobe.d/kvm.conf 
# options kvm_amd nested=1

# move this to machine-host1-configure.yml
# install my libvirt host role
# I'm not using ansible-galaxy because I am actively developing this role.
# Check out the directive in ansible.cfg in some playbooks.
mkdir -p ~/ansible/roles
cd ~/ansible/roles
# If the repo has already been cloned, git exits with this error message. 
#   fatal: destination path 'libvirt-host' already exists and is not an empty directory.
git clone https://github.com/nickhardiman/libvirt-host.git
# turn the host into a hypervisor
sudo ansible-playbook libvirt-host/tests/test.yml

# host config
mkdir -p ~/ansible/playbooks
cd ~/ansible/playbooks
git clone https://github.com/nickhardiman/machine-host1.git
cd machine-host1
ansible-playbook --ask-become-pass machine-host1-configure.yml

