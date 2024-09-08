### jenkins
```
sudo chown 1000:1000 /var/run/docker.sock
ansible -i /ansible/inventory -m ping test1
ansible-playbook -i ansible/inventory ansible/playbook.yml
ssh -i /ansible/remote-key remote_user@centos
```
