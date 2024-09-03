# jenkins_ansible
ansible -i /var/jenkins_home/ansible/inventory -m ping test1
ansible-playbook -i ansible/inventory ansible/playbook.yml