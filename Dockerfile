FROM ubuntu

RUN apt update

RUN apt install xrdp mate-core mate-desktop-environment mate-notification-daemon -y

RUN apt install supervisor curl -y

RUN curl https://get.docker.com | bash

RUN sed -i.bak '/fi/a #xrdp multiple users configuration \nmate-session\n' /etc/xrdp/startwm.sh

COPY etc/ /etc/

RUN useradd -ms /bin/bash andrei && \
    sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini && \
    xrdp-keygen xrdp auto && \
    usermod -aG docker andrei && \
    usermod -aG sudo andrei && \
    echo "andrei:andrei" | chpasswd

CMD ["supervisord", "-n"]
# CMD tail -f /dev/null
