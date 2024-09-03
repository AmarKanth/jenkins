FROM centos:8

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-* 
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=https://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-*

RUN yum -y update && yum -y install openssh-server python3 && yum clean all

RUN rm -f /var/run/nologin

RUN useradd remote_user && echo "remote_user:1234" | chpasswd

RUN mkdir /home/remote_user/.ssh && chmod 700 /home/remote_user/.ssh

COPY remote-key.pub /home/remote_user/.ssh/authorized_keys 

RUN chown remote_user:remote_user -R /home/remote_user/.ssh/ 

RUN yum -y install mysql

RUN curl -O https://bootstrap.pypa.io/pip/3.6/get-pip.py && python3 get-pip.py && pip3 install awscli --upgrade

RUN ssh-keygen -A

CMD ["/usr/sbin/sshd", "-D"]