- Create an EC2 instance with Jenkins and Docker pre-installed

> Docker & Jenkins Installation
```
#!/bin/bash
set -e

# --- Install Docker ---
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

sudo usermod -aG docker ubuntu
sudo su - ubuntu -c "sg docker -c 'docker --version'"

sudo systemctl enable docker
sudo systemctl start docker


# --- Install Java (for Jenkins) ---
sudo apt-get update
sudo apt install -y fontconfig openjdk-17-jre


# --- Install Jenkins ---
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install -y jenkins
sudo usermod -aG docker jenkins

sudo systemctl start jenkins
sudo systemctl enable jenkins


# --- Install AWS CLI v2 ---
cd /tmp
sudo apt-get install -y unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
sudo ./aws/install
sudo rm -rf aws awscliv2.zip

# --- Logging ---
echo "###############################################" >> /var/log/user-data-status.log
echo "#         User data script COMPLETED          #" >> /var/log/user-data-status.log
echo "###############################################" >> /var/log/user-data-status.log
```

- Create SSH credentials with a private key and Jenkins pipeline

> Test Jenkins access to github
```
sudo su - jenkins
ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_ed25519 git@github.com
```

- Create JenkinsElasticBeanstalkRole with given policies and create credentails for aws-screct-key and access-key in jenkins
> JenkinsElasticBeanstalkPolicy
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ElasticBeanstalkActions",
            "Effect": "Allow",
            "Action": [
                "elasticbeanstalk:CreateApplicationVersion",
                "elasticbeanstalk:UpdateEnvironment",
                "elasticbeanstalk:DescribeEnvironments",
                "elasticbeanstalk:DescribeApplicationVersions"
            ],
            "Resource": "*"
        },
        {
            "Sid": "S3AccessForAppBundles",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::YOUR-BUCKET-NAME",
                "arn:aws:s3:::YOUR-BUCKET-NAME/*"
            ]
        }
    ]
}
```

- Create Elastic Beanstalk application
