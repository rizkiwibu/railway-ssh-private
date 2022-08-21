FROM ubuntu:focal
RUN apt update -y > /dev/null 2>&1 && apt upgrade -y > /dev/null 2>&1
RUN apt install ssh wget unzip -y > /dev/null 2>&1
WORKDIR /app/haznre
RUN echo '/usr/sbin/sshd -D' >>/1.sh
RUN mkdir /run/sshd
RUN echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config 
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN service ssh start
RUN chmod 755 /1.sh
RUN echo root:haznre|chpasswd
EXPOSE 80 8080
CMD ['ifconfig']
