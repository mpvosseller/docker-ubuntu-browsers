FROM ubuntu:latest

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install -y wget gnupg2

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get update

RUN apt-get install -y xvfb x11vnc fluxbox xterm x11-apps google-chrome-stable firefox

COPY start-x11vnc.sh /root

EXPOSE 5900/tcp

ENV DISPLAY=:99
ENV BROWSER="google-chrome --no-sandbox --disable-gpu"

CMD /root/start-x11vnc.sh > /root/log.txt 2>&1 && echo 'open -a "Screen Sharing" vnc://:1234@localhost' && $BROWSER
