# how do I start adding VMs? 
# how about some kinda chain loading, like starting with this one VM, then building all others from there? 

# guest: builder1
# get the code
cd ~/ansible/playbooks
git clone https://github.com/nickhardiman/vm-builder1
cd vm-builder1
# install roles to ~/.ansible/roles/
ansible-galaxy install -r roles/requirements.yml
# build the machine
ansible-playbook \
  --ask-become-pass  \
  -e 'rhsm_user=RH_user'  \
  -e 'rhsm_password=RH_password' \
  -e 'rhsm_pool_id=12345'  \
  main.yml

