FROM ubuntu:zesty-20170224

RUN sed -i.bk s/archive.ubuntu.com/jp.archive.ubuntu.com/g /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y \
  sudo \
  build-essential \
  curl  \
  bash \
  git \
  unzip \
  nodejs \
  nodejs-legacy \
  npm

RUN groupadd -g 1000 nobita \
  && useradd -u 1000 -g nobita -G sudo -m -s /bin/bash nobita \
  && echo 'nobita ALL=NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir -p /home/nobita/.a5cache \
  && cd /home/nobita/.a5cache \
  && curl -Ss -L https://github.com/google/web-starter-kit/releases/download/v0.6.5/web-starter-kit-0.6.5.zip > web-starter-kit-0.6.5.zip \
  && unzip web-starter-kit-0.6.5.zip \
  && mv web-starter-kit-0.6.5 web-starter-kit \
  && cd web-starter-kit \
  && npm install \
  && npm install gulp -g

RUN mv ~/.npm /home/nobita/.a5cache/ \
  && chown -R nobita:nobita /home/nobita/.a5cache

COPY *.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

VOLUME ["/srv/web-starter-kit"]

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
