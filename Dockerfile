FROM ubuntu

RUN apt update && apt install --no-install-recommends -y gnome-session-flashback xrdp

RUN echo "gnome-session --session=gnome-flashback-metacity --disable-acceleration-check & gnome-panel" > ~/.xsession
