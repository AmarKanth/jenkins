### jenkins
```
sudo chown 1000:1000 /var/run/docker.sock
ansible -i /ansible/inventory -m ping test1
ansible-playbook -i ansible/inventory ansible/playbook.yml
ssh -i /ansible/remote-key remote_user@centos
```
```
#!/bin/bash

if ! dpkg -l | grep -q jenkins; then
    sudo apt-get update
    sudo apt install fontconfig openjdk-17-jre

    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
    
    sudo apt-get update
    sudo apt-get install jenkins

    sudo systemctl start jenkins
    sudo systemctl enable jenkins

    echo "Jenkins installation completed."
else
    echo "Jenkins is already installed, skipping installation."
fi
```
