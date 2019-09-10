FROM ubuntu

RUN apt update && apt install -y \
    xrdp \
    mate-core \
    mate-desktop-environment \
    mate-notification-daemon \
    supervisor
    
RUN sed -i.bak '/fi/a #xrdp multiple users configuration \nmate-session\n' /etc/xrdp/startwm.sh

COPY etc/ /etc/

RUN useradd -ms /bin/bash andrei && \
    sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini && \
    xrdp-keygen xrdp auto && \
    usermod -aG sudo andrei && \
    echo "andrei:andrei" | chpasswd

CMD ["supervisord", "-n"]
