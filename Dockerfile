FROM ubuntu:latest
RUN apt update -y > /dev/null 2>&1 && apt upgrade -y > /dev/null 2>&1 && apt install locales -y \
&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
RUN apt install openssh-server curl wget unzip sudo -y > /dev/null 2>&1
RUN wget -O ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip > /dev/null 2>&1
RUN unzip ngrok.zip
RUN echo "./ngrok config add-authtoken 2G6OAon5DxxVIarx2lGq7m43kLk_2zLHHCbqqvXFiWU58tfkt" >>/1.sh
RUN echo "./ngrok tcp --region ap 22 &>/dev/null &" >>/1.sh
RUN mkdir /run/sshd
RUN echo '/usr/sbin/sshd -D' >>/1.sh
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config 
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN sudo service ssh start
RUN chmod 755 /1.sh
RUN adduser hazn -y
RUN adduser hazn sudo
RUN echo hazn:root|chpasswd
CMD  /1.sh
