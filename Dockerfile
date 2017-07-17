FROM ubuntu

RUN apt update && apt install --no-install-recommends -y mate-core mate-desktop-environment mate-notification-daemon xrdp

RUN sed -i.bak '/fi/a #xrdp multi-users \n "mate-session" \n' /etc/xrdp/startwm.sh

EXPOSE 3389

CMD ["tail", "-f", "/dev/null"]
